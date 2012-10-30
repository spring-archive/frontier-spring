-- $Id: unit_carrier_drones.lua 3291 2008-11-25 00:36:20Z licho $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    unit_carrier_drones.lua
--  brief:   Spawns drones for aircraft carriers
--  author:  
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.

-- Data Structures:
--[[
drone_defs: (indexed by unitDefID)
    table ???:
        table 1:
            drone Unit ID
            reloadTime
            maxDrones
            spawnSize
            range
            managed (boolean)
        table 2:
            drone Unit ID
            reloadTime
            maxDrones
            spawnSize
            range
            managed (boolean)
        table 3:
            etc.
    table ***:
        etc


carrierData: (indexed by unitID)
    table ???:
        table 1: (corresponds to above table 1 for data)
            drones {   }
            reload
        table 2: (corresponds to above table 2 for data)
            drones {   }
            reload
        table 3: 
            etc
    table ***:
        etc

]]
--alternate data structure
--[[

drone_defs: --indexed numerically --inefficient(?) but easy(?) to code
    --below, one unit can have multiple tables !
    table 1:
        host Unit Def ID
        drone Unit Def ID
        reloadTime
        maxDrones
        spawnSize
        range
        managed (boolean)
    table 2:
        host Unit Def ID
        drone Unit Def ID
        reloadTime
        maxDrones
        spawnSize
        range
        managed (boolean)
    table 3:
        etc
    
carrierData:
    --below, one unit can have multiple tables !
    table 1:
        host Unit ID
        drones {   }
        reload
    table 2:
        host Unit ID
        drones {   }
        reload
    table 3:
        etc
        
]]

--alternate data structure 2:

--[[
drone_defs:
    --below, one unit can have multiple tables !
    table 1:
        host Unit Def ID
        drone Unit Def ID
        reloadTime
        maxDrones
        spawnSize
        --range --probably won't use
        managed (boolean)
        
        drones = {   } --gets used when a carriertable is instantiated
        reload = nil   --gets used when a carriertable is instantiated
        hostUnitID = nil   --gets used when a carriertable is instantiated
        
    table 2:
        host Unit Def ID
        drone Unit Def ID
        reloadTime
        maxDrones
        spawnSize
        --range --probably won't use
        managed (boolean)
        
        drones = {   } --gets used when a carriertable is instantiated
        reload         --gets used when a carriertable is instantiated
        hostUnitID = nil   --gets used when a carriertable is instantiated
        
    table 3:
        etc
    

carrierData:
    looks just like the above ^ ^ ^
    --new carrier unit? copy all relevant tables from above
    --carrier unit died? delete all relevant tables
]]
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "CarrierDrones",
    desc      = "Spawns drones for aircraft carriers",
    author    = "formerly TheFatConroller and KingRaptor, rewritten by yanom",
    date      = "12.01.2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- SYNCED CODE
if (not gadgetHandler:IsSyncedCode()) then
  return
end

local carrierDefs = include "LuaRules/Configs/drone_defs.lua"

--Speed-ups

local GetUnitPosition   = Spring.GetUnitPosition
local CreateUnit        = Spring.CreateUnit
local AddUnitDamage     = Spring.AddUnitDamage
local GiveOrderToUnit   = Spring.GiveOrderToUnit
local GetCommandQueue   = Spring.GetCommandQueue
local SetUnitPosition   = Spring.SetUnitPosition
local SetUnitNoSelect   = Spring.SetUnitNoSelect
local random            = math.random
local CMD_ATTACK        = CMD.ATTACK

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end
---------------------------------------------------------------------------------
local carrierList = {}
local UPDATE_FREQUENCY = 50
--local droneList = {}

--reminder - here's how to get a unit's Def: local udID =Spring.GetUnitDefID(unitID)
--also: Spring.GetUnitAllyTeam and Spring.GetUnitTeam
---------------------------------------------------------------------------------


function gadget:Initialize()
    --Spring.Echo("Hello World!")
    --Spring.Echo(table.tostring(carrierDefs))
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    --Spring.Echo("unit finished!")
    for i,v in pairs(carrierDefs) do
        if(v.hostUnitDefID == unitDefID) then --found a match
            table.insert(carrierList,{hostUnitDefID = v.hostUnitDefID, droneUnitDefID=v.droneUnitDefID, reloadTime=v.reloadTime, maxDrones = v.maxDrones, managed=v.managed, hostUnitID = unitID, drones = {  }, lastReloadFrame = 0})
            --lastReloadFrame is, well, the last game frame it was reloaded
        end
    end
end

--TODO: REMOVE DEAD DRONES FROM THE DRONES{} SUBTABLE using Spring.GetUnitIsDead(unitID) 

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    for i,v in pairs(carrierList) do
        if(v.hostUnitID == unitID) then--this table slated for destruction
            for ii,vv in pairs(v.drones) do --first thing we do, let's kill all the lawyers^W drones
                AddUnitDamage(vv,10000)
            end
            table.remove(carrierList,i)
        end
    end
end

function gadget:GameFrame(n)
    --debug vvv
    --Spring.Echo(table.tostring(carrierList))
    --debug ^^^
    if(n%UPDATE_FREQUENCY == 0) then
        --debug vvv
        --makeNewDrone(carrierList[1])
        --copyHostOrdersToDrone(carrierList[1])
        --debug ^^^
        for i,thisTable in pairs(carrierList) do
            copyHostOrdersToDroneIfManaged(thisTable)
            purgeDeadDrones(thisTable) --remove them from the roll if they can't prove they're alive.
                                          --it's like voter supression for drones!
            checkAndGenerateDrones(thisTable,n) --we must pass n (the current frame) to the function for reloading purposes
                                          
            
            
            --debug vvv
            --Spring.Echo(#thisTable.drones)
            --debug ^^^
            
            --debug vvv
            --if(n%2000) then makeNewDrone(thisTable) end
            --debug ^^^
        end
        
    end
end

function purgeDeadDrones(carrierTable)
    for index,thisUnitID in pairs(carrierTable.drones) do
        --Spring.Echo(Spring.GetUnitIsDead(thisUnitID))
        if(Spring.GetUnitIsDead(thisUnitID)~=false) then
            --Spring.Echo("removing dead drone!: " .. index)
            table.remove(carrierTable.drones,index)
        end
    end
end

function copyHostOrdersToDroneIfManaged(carrierTable)
    if(carrierTable.managed == true) then
        Spring.GiveOrderToUnitArray(carrierTable.drones, CMD.STOP, {}, {}) -- flush the queue
        for i,com in pairs(Spring.GetCommandQueue(carrierTable.hostUnitID)) do
            Spring.GiveOrderToUnitArray(carrierTable.drones, com.id, com.params, com.options)
            --Spring.Echo(table.tostring(com))
        end
        --Spring.Echo(table.tostring(Spring.GetCommandQueue(carrierTable.hostUnitID)))
    end
end


function makeNewDrone(carrierTable) --simply creates the drone. 
    --DOES NOT TOUCH RELOAD, MAXDRONES, OR OTHER PROPERTIES OF CARRIERTABLE. edit those elsewhere or add them here.
    local x, y, z = GetUnitPosition(carrierTable.hostUnitID)
    local angle = math.rad(random(1,360))
    local xS = (x + (math.sin(angle) * 20))
    local zS = (z + (math.cos(angle) * 20))
    local thisDrone = CreateUnit(carrierTable.droneUnitDefID,x,y,z,1,Spring.GetUnitTeam(carrierTable.hostUnitID))
    SetUnitPosition(thisDrone, xS, zS, true)
    SetUnitNoSelect(thisDrone,true)
    table.insert(carrierTable.drones,thisDrone)
end

function checkAndGenerateDrones(carrierTable,currentGameFrame)
	if(#carrierTable.drones >= carrierTable.maxDrones) then -- no more drones, please
		return --end function
	else
		if(currentGameFrame-carrierTable.lastReloadFrame>carrierTable.reloadTime) then--add another drone!
			makeNewDrone(carrierTable)
			carrierTable.lastReloadFrame=currentGameFrame
		end
	end
end

----------------------------------------------------------------------------------

--local carrierDefs = include "LuaRules/Configs/drone_defs.lua"

--local DEFAULT_UPDATE_ORDER_FREQUENCY = 60       -- gameframes
--local DEFAULT_MAX_DRONE_RANGE = 1500

--local carrierList = {}
--local droneList = {}

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------


--local function InitCarrier(unitDefID, unitAllyID)
        --local carrierData = carrierDefs[unitDefID]
        --return {unitDefID = unitDefID, unitAllyID = unitAllyID, droneCount = 0, reload = carrierData.reloadTime, drones = {}, managed=carrierData.managed}
--end

--local function NewDrone(unitID, unitDefID, droneName)
  --local x, y, z = GetUnitPosition(unitID)
  --local angle = math.rad(random(1,360))
  --local xS = (x + (math.sin(angle) * 20))
  --local zS = (z + (math.cos(angle) * 20))
  --local droneID = CreateUnit(droneName,x,y,z,1,carrierList[unitID].unitAllyID)
  --carrierList[unitID].reload = carrierDefs[unitDefID].reloadTime
  --carrierList[unitID].droneCount = (carrierList[unitID].droneCount + 1)
  --carrierList[unitID].drones[droneID] = true
 
  --SetUnitPosition(droneID, xS, zS, true)
  --GiveOrderToUnit(droneID, CMD.MOVE_STATE, { 2 }, {})
  --GiveOrderToUnit(droneID, CMD.IDLEMODE, { 0 }, {})
  --if(carrierList[unitID].managed==true) then
    ----GiveOrderToUnit(droneID, CMD.AUTOREPAIRLEVEL, { 3 }, {})
    ----GiveOrderToUnit(droneID, CMD.FIGHT,  {(x + (random(0,600) - 300)), 60, (z + (random(0,600) - 300))}, {""})
    --GiveOrderToUnit(droneID, CMD.GUARD, {unitID} , {"shift"})
  --end
  --SetUnitNoSelect(droneID,true)
 
  --droneList[droneID] = unitID
--end

--function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
  --if (carrierList[unitID]) then
    --for droneID in pairs(carrierList[unitID].drones) do
                --droneList[droneID] = nil
                --AddUnitDamage(droneID,10000)
    --end
    --carrierList[unitID] = nil
  --elseif (droneList[unitID]) then
    --local i = droneList[unitID]
        --carrierList[i].droneCount = (carrierList[i].droneCount - 1)
        --carrierList[i].drones[unitID] = nil
        --droneList[unitID] = nil
  --end
--end

--function gadget:UnitFinished(unitID, unitDefID, unitTeam)
  --if (carrierDefs[unitDefID]) then
    --carrierList[unitID] = InitCarrier(unitDefID, unitTeam)
  --end
--end

--function gadget:AllowUnitTransfer(unitID, unitDefID, oldTeam, newTeam, capture)
  --if (droneList[unitID]) then
        --if capture then
                --gadget:UnitDestroyed(unitID, unitDefID, oldTeam)
                --return true
        --end
    --return false
  --else
    --if (carrierList[unitID] ~= nil) then
      --gadget:UnitDestroyed(unitID, unitDefID, oldTeam)
      --gadget:UnitFinished(unitID, unitDefID, newTeam)
    --end    
    --return true
  --end
--end

--local function GetDistance(x1, x2, y1, y2)
        --return ((x1-x2)^2 + (y1-y2)^2)^0.5
--end



--function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
  ----[[for i,v in pairs(carrierList) do
    ----Spring.Echo(carrierList[i].managed)
    --if(carrierList[i].managed==true) then --if we find the unit in here, return false
        ----Spring.Echo(carrierList[i].managed)
        --if(carrierList[i].drones[unitID]==true) then
            --return false
        --end
    --end
  --end]]
  --return true --modified it so that it will allow drones to be controlled by other scripts
--end


--function gadget:UnitCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
        --if (carrierList[unitID]) then
            --if (carrierList[unitID].managed) then
                --UpdateCarrierTarget(unitID)
            --end
        --end
--end


--function gadget:GameFrame(n)
  --if (((n+1) % 30) < 0.1) then
    --for i,_ in pairs(carrierList) do
          --local carrier = carrierList[i]
          --local carrierDef = carrierDefs[carrier.unitDefID]
      --if (carrier.reload > 0) then
        --carrier.reload = (carrier.reload - 1)
      --elseif (carrier.droneCount < carrierDef.maxDrones) then
                --for n=1,carrierDef.spawnSize do
                        --if (carrier.droneCount >= carrierDef.maxDrones) then
                                --break
                        --end
                        --NewDrone(i, carrier.unitDefID, carrierDef.drone)
        --end
      --end
    --end
  --end
  --if ((n % DEFAULT_UPDATE_ORDER_FREQUENCY) < 0.1) then
        --for i,_ in pairs(carrierList) do
            --if (carrierList[i].managed==true) then
                --UpdateCarrierTarget(i)
            --end
        --end
  --end
--end

--function UpdateCarrierTarget(carrierID)
        ----Spring.Echo("updating carrier target!")
        --local cQueueC = GetCommandQueue(carrierID, 1)
        --if cQueueC and cQueueC[1] and cQueueC[1].id == CMD_ATTACK then
                --local ox,oy,oz = GetUnitPosition(carrierID)
                --local params = cQueueC[1].params
                --local px,py,pz
                --if #params == 1 then
                        --px,py,pz = Spring.GetUnitPosition(params[1])
                --else
                        --px,py,pz = unpack(params)
                --end
                --if not px then return end
                ---- check range
                --local dist = GetDistance(ox,px,oz,pz)
                --if dist > carrierDefs[carrierList[carrierID].unitDefID].range then
                        --return
                --end
               
                --for droneID in pairs(carrierList[carrierID].drones) do
                        ----[[
                        --local cQueue = GetCommandQueue(droneID, 1)
                        --local engaged = false
                        --if cQueue and cQueue[1] and cQueue[1].id == CMD_ATTACK then
                                --engaged = true
                        --end
                        --]]--
                        ----if not engaged then
                                ----Spring.Echo("Ordering drone " .. droneID .. " to attack")
                                --droneList[droneID] = nil        -- to keep AllowCommand from blocking the order
                                --GiveOrderToUnit(droneID, CMD.FIGHT, {(px + (random(0,200) - 100)), (py+120), (pz + (random(0,200) - 100))} , {""})
                                --GiveOrderToUnit(droneID, CMD.GUARD, {carrierID} , {"shift"})
                                --droneList[droneID] = carrierID
                        ----end
                --end
        --else
                --for droneID in pairs(carrierList[carrierID].drones) do
                        --local cQueue = GetCommandQueue(droneID)
                        --local engaged = false
                        --for i=1, (cQueue and #cQueue or 0) do
                                --if cQueue[i].id == CMD.FIGHT then
                                        --engaged = true
                                        --break
                                --end
                        --end
                        --if not engaged then
                                --local px,py,pz = GetUnitPosition(carrierID)
                                --droneList[droneID] = nil        -- to keep AllowCommand from blocking the order
                                --GiveOrderToUnit(droneID, CMD.FIGHT, {(px + (random(0,200) - 100)), (py+120), (pz + (random(0,200) - 100))} , {""})
                                --GiveOrderToUnit(droneID, CMD.GUARD, {carrierID} , {"shift"})
                                --droneList[droneID] = carrierID
                        --end
                --end    
        --end
--end

----[[
--function gadget:Initialize()
        --for udid,data in pairs(carrierDefs) do
                --if data.weapon then
                        --Script.SetWatchWeapon(WeaponDefNames[data.weapon].id)
                --end
        --end
--end

--]]
