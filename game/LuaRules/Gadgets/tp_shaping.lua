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

--------------------------------------------------------
--Border between SYNC and UNSYNC
end
