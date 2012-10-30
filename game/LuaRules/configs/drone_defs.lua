local carrierDefs = {
        {hostUnitDefID = UnitDefNames.lbigwalker.id, droneUnitDefID=UnitDefNames.lwarrior.id, reloadTime=10, maxDrones = 6,  managed=true, hostUnitID = nil, drones = {  }, reload = nil},
        {hostUnitDefID = UnitDefNames.lengineer.id, droneUnitDefID=UnitDefNames.kdroneminerflyer.id, reloadTime = 10, maxDrones = 6,  managed=false, hostUnitID = nil, drones = {  }, reload = nil},
}

--for i,v in pairs(carrierDefNames) do 
        --if UnitDefNames[name] then carrierDefs[UnitDefNames[name].id] = data    end
--end

return carrierDefs
