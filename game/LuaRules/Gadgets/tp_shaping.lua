function gadget:GetInfo()
  return {
    name      = "Shaping",
    desc      = "Allows Locust 'Miners' to shape resource rocks into eggs.",
    author    = "yanom",
    date      = "14 Nov 2012",
    license   = "open-source, like the rest of Frontier (derived from Conflict Terra)",
    layer     = 0,
    enabled   = true  --  loaded by default 
  }
end

if (gadgetHandler:IsSyncedCode()) then


local resource_name = {}

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

function gadget:Initialize()
    make_resource_name_table ()
end

function search_res (unitID)
    local x, y, z = Spring.GetUnitPosition(unitID)
    --Spring.GiveOrderToUnit(unitID, CMD.FIRE_STATE , { 2 }, {})
    --Spring.GiveOrderToUnit(unitID, CMD.AREA_ATTACK  , { x, y, z,50000  }, {})
    --miners[unitID].last_mined_id = nil
    --miners[unitID].status = "send to search"
    local res = nearest_resID_from_miner (unitID)
    if (res) then Spring.GiveOrderToUnit(unitID, CMD.ATTACK  , { res }, {}) end
    --miners[unitID].status = "search finished"
end

function make_resource_name_table ()
    for id,unitDef in pairs(UnitDefs) do
        local cp = UnitDefs[id].customParams
        if (cp) then
            if (cp.is_mineable) then
                local resname = unitDef.name
                table.insert (resource_name, resname)
            end
        end
    end
end

function is_resource_type (unitDefID)
    if (unitDefID == nil) then return false end
    local unitDef = UnitDefs[unitDefID]
    if (unitDef == nil) then return false end
    for schluessel, wert in pairs(resource_name) do                            
        if (wert == unitDef.name) then return true end
    end 
    --if (unitDef.name == resource_name) then return true end
    return false
end


function nearest_resID_from_miner (minerID)
    local nearest_resID = nil
    local nearest_res_distance = 9999999999
    local nearest_unmined_res = nil
    local nearest_unmined_res_distance = 9999999999
    local x,y,z = Spring.GetUnitPosition(minerID)
    res=Spring.GetUnitsInCylinder (x,z, 10000, Spring.GetGaiaTeamID())
    if (res == nil) then return nil end --no near units at all :/
    for i in pairs (res) do
        if (is_resource_type (Spring.GetUnitDefID(res[i])) == true) then            
            local d = Spring.GetUnitSeparation (minerID, res[i])
            if (d < nearest_res_distance) then
                nearest_res_distance = d
                nearest_resID = res[i]
            end
        end      
    end
    if (nearest_resID~=nil) then return nearest_resID else return nil end
end


function gadget:GameFrame(frameNum) 
    --Spring.Echo("I am the test gadget on frame" .. frameNum)
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID)
	--if(unitDefID == UnitDefNames.bminerals.id) then
	--Spring.Echo("unit destroyed!")
	--Spring.Echo("It was destroyed by team " .. Spring.GetUnitTeam(attackerID) )
	if(attackerID ~= nil) then
		local cp = UnitDefs[Spring.GetUnitDefID(attackerID)].customParams
		if (cp) then
			--Spring.Echo(table.tostring(cp))
			if (cp.is_shaper) then
				--Spring.Echo("It was destroyed by a shaper!")
				if(unitDefID == UnitDefNames.bminerals.id or unitDefID==UnitDefNames.bmeteorimpact.id) then 
					local x,y,z = Spring.GetUnitPosition(unitID)
					Spring.CreateUnit(UnitDefNames[cp.shapessmallrockto].id,x,y,z,1,Spring.GetUnitTeam(attackerID))
				end
				if(unitDefID == UnitDefNames.bmeteorimpact_big.id) then
					local x,y,z = Spring.GetUnitPosition(unitID)
					Spring.CreateUnit(UnitDefNames[cp.shapesbigrockto].id,x,y,z,1,Spring.GetUnitTeam(attackerID))
				end
			end
		end
    end
end

function gadget:UnitIdle(unitID, unitDefID, teamID)
	local cp = UnitDefs[unitDefID]
	if(cp) then
		if(cp.is_shaper) then
			search_res (unitID)
		end
	end
end

--------------------------------------------------------
--Border between SYNC and UNSYNC
end
