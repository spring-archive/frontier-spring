local carrierDefs = {
        --{hostUnitDefID = UnitDefNames.lbigwalker.id, droneUnitDefID=UnitDefNames.lwarrior.id, reloadTime=10, maxDrones = 4,  managed=true, hostUnitID = nil, drones = {  }, reload = nil},
        --{hostUnitDefID = UnitDefNames.lbigwalker.id, droneUnitDefID=UnitDefNames.laadrone.id, reloadTime=10, maxDrones = 4,  managed=true, hostUnitID = nil, drones = {  }, reload = nil},
        {hostUnitDefID = UnitDefNames.lengineer.id, droneUnitDefID=UnitDefNames.kdroneminerflyer.id, reloadTime = 10, maxDrones = 6,  managed=false, hostUnitID = nil, drones = {  }, reload = nil, selectMode=0},
        {hostUnitDefID = UnitDefNames.lengineer.id, droneUnitDefID=UnitDefNames.lstemcell.id, reloadTime = 10, maxDrones = 10,  managed=false, hostUnitID = nil, drones = {  }, reload = nil, selectMode=1},
}

--selectMode options:

--0 = drones are noselect
--1 = drones are selectable

return carrierDefs
