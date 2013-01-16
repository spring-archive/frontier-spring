--we are going to put flatification code here
--something like this:
--  local unitx,unity,unitz = Spring.GetUnitPosition(unitID)
--  Spring.LevelHeightMap(unitx-100,unitz-100,unitx+100,unitz+100,unity)

function unitName (unitID)

    if (not Spring.ValidUnitID (unitID)) then return "!invalid unitID in unitName()!" end

    local udID =Spring.GetUnitDefID(unitID)

    local uDef = UnitDefs [udID]

    return uDef.name

end

--[[
function gadget:UnitFinished(unitID, unitDefID, teamID)
	if(unitName(unitID)=="mnanoforge") then --test
		local unitx,unity,unitz = Spring.GetUnitPosition(unitID)
        Spring.LevelHeightMap(unitx-10000,unitz-10000,unitx+10000,unitz+10000,unity)
	end
end
]]
