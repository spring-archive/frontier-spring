    unitDef = {
      unitname            = [[lobelisk]],
      name                = [[Locust Obelisk]],
      description         = [[Serves as a control unit for Nanomorphs. Use it to produce units.]],
      buildCostEnergy     = 300,
      buildCostMetal      = 300,
      builder             = false,
      buildPic            = [[kdroneminingtower.png]],
      buildTime           = 60,
      canStop             = true,
      category            = [[SINK]],
      corpse              = [[DEAD]],

      collisionVolumeOffsets = [[0 0 0]],
      collisionVolumeScales  = [[48 100 48]],
      collisionVolumeTest    = 1,
      collisionVolumeType    = [[box]],

      useBuildingGroundDecal    = true,
      buildingGroundDecalType   = "grounddecals/kdronemininggrounddecal.png",
      buildingGroundDecalSizeX  = 5,
      buildingGroundDecalSizeY  = 5,
      buildingGroundDecalDecaySpeed = 0.1,

      reclaimable         = false,
      radarDistance       = 300,
      energyMake          = 10,
      explodeAs           = [[DRONE_BUILDING]],
      footprintx          = 2,
      footprintZ          = 2,
      idleAutoHeal        = 1,
      levelGround         = false,
      mass                = 1300,
      maxDamage           = 3000,
      maxSlope            = 18,
      maxWaterDepth       = 0,
      objectName          = [[lobelisk.s3o]],
      seismicSignature    = 4,
      selfDestructAs      = [[DRONE_BUILDING]],
      side                = [[DRONE]],
      sightDistance       = 200,

      sfxtypes            = {
        explosiongenerators = {
        "custom:ct_mininglaser_blue", --not used
        },
      },

      sounds            = {
          select = {
        "",
        },
          ok = {
        "",
        },
      },

      smoothAnim          = true,
      yardMap             = [[ooooo ooooo ooooo ooooo ooooo]],
      script              = [[lobelisk.lua]],
    
    
      featureDefs         = {
    
        DEAD  = {
          description      = [[Wreckage - Drone Mining Tower]],
          blocking         = true,
          category         = [[corpses]],
          damage           = 500,
          energy           = 0,
          featureDead      = [[DEAD2]],
          footprintX       = 3,
          footprintZ       = 3,
          metal            = 50,
          object           = [[wrecks/kdroneminingtowerwreck.s3o]],
          reclaimable      = true,
          reclaimTime      = 1500,
        },
    
    
        DEAD2 = {
          description      = [[Debris - Drone Mining Tower]],
          blocking         = false,
          category         = [[heaps]],
          damage           = 250,
          energy           = 0,
          footprintX       = 5,
          footprintZ       = 5,
          metal            = 25,
          object           = [[b8x8heap.s3o]],
          reclaimable      = true,
          reclaimTime      = 750,
        },
    
      },
    
    }
    
    return lowerkeys({ lobelisk = unitDef })
