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


function gadget:UnitFinished(unitID, unitDefID, teamID)
	if(unitName(unitID)=="mnanoforge") then --test
		local unitx,unity,unitz = Spring.GetUnitPosition(unitID)
		unitx = math.floor((unitx+4)/8)*8
		unitz = math.floor((unitz+4)/8)*8
		Spring.LevelHeightMap(unitx-1000,unitz-1000,unitx+1000,unitz+1000,unity)
        Spring.LevelSmoothMesh(unitx-1500,unitz-1500,unitx+1500,unitz+1500,unity/2)
	end
end

