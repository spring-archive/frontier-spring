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

function gadget:GameFrame(frameNum) 
    --Spring.Echo("I am the test gadget on frame" .. frameNum)
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID)
	--if(unitDefID == UnitDefNames.bminerals.id) then
	--Spring.Echo("unit destroyed!")
	--Spring.Echo("It was destroyed by team " .. Spring.GetUnitTeam(attackerID) )
	local cp = UnitDefs[Spring.GetUnitDefID(attackerID)].customParams
    if (cp) then
        if (cp.is_shaper) then
            --Spring.Echo("It was destroyed by a shaper!")
            if(unitDefID == UnitDefNames.bminerals.id) then 
				local x,y,z = Spring.GetUnitPosition(unitID)
				Spring.CreateUnit(UnitDefNames[cp.shapesSmallRockTo].id,x,y,z,1,Spring.GetUnitTeam(attackerID))
			end
			if(unitDefID == UnitDefNames.bminerals_big.id) then
				local x,y,z = Spring.GetUnitPosition(unitID)
				Spring.CreateUnit(UnitDefNames[cp.shapesBigRockTo].id,x,y,z,1,Spring.GetUnitTeam(attackerID))
			end
        end
    end
	--end
end

--------------------------------------------------------
--Border between SYNC and UNSYNC
end
