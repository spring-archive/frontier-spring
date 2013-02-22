unitDef = {

  unitname                      = [[mnanoforge]],
  name                          = [[Mason Factory]],
  description                   = [[Mechamakemechs]],
  amphibious                    = false,
  acceleration                  = 0,
  brakeRate                     = 0,
  buildCostEnergy               = 600,
  buildCostMetal                = 600,
  builder                       = true,

  buildoptions                  = {

    [[bminer]],
    [[mtank]],
    -- [[pnaamech]],
    -- [[pnjumpjetmech]],
    -- [[pnlightmech]],
    -- [[pnvlaunchmech]],
  },



  buildPic                      = [[mnanoforge.png]],
  buildTime                     = 45,
  canMove                       = true,
  canPatrol                     = true,
  canStop                       = true,
  canBeAssisted                 = false,
  category                      = [[SINK]],
--  collisionVolumeOffsets        = [[0 0 0]],
--  collisionVolumeScales         = [[256 100 272]],
--  collisionVolumeTest           = 1,
--  collisionVolumeType           = [[box]],
  corpse                        = [[DEAD]],
  customParams = { is_dropoff=true,   },
  reclaimable                   = false,

  energyMake                    = 10,
  energyUse                     = 0,
  explodeAs                     = [[LARGE_BUILDING]],
  footprintX                    = 16,
  footprintZ                    = 16,
  idleAutoHeal                  = 0,
  mass                          = 275,
  maxDamage                     = 4500,
  maxSlope                      = 15,
  maxVelocity                   = 0,
  maxWaterDepth                 = 0,
  metalMake                     = 0,
  minCloakDistance              = 150,
  noAutoFire                    = false,
  objectName                    = [[mnanoforge.s3o]],

  seismicSignature              = 4,
  selfDestructAs                = [[LARGE_BUILDING]],
  showNanoSpray                 = false,
  side                          = [[NKG]],
  sightDistance                 = 4000,

	  sounds			= {
	      select = {
		"golgotha/vehicle_done_44khz",
		},
	      ok = {
		"golgotha/vehicle_done_44khz",
		},
	  },

  smoothAnim                    = true,
  workerTime                    = 1,
  yardMap                       = [[cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc]],
  script                        = [[mnanoforge.lua]],



  featureDefs                   = {

    DEAD  = {
      description      = [[Wreckage - Saito Class Cruiser Mech Factory]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2250,
      energy           = 0,
      featureDead      = [[DEAD2]],
      footprintX       = 16,
      footprintZ       = 17,
      mass             = 2000,
      metal            = 300,
 --     object           = [[wrecks/mnanoforgewreck.s3o]],
      reclaimable      = true,
      reclaimTime      = 9000,
    },


    DEAD2 = {
      description      = [[Debris - Saito Class Cruiser Mech Factory]],
      blocking         = false,

      category         = [[heaps]],
      damage           = 1125,
      energy           = 0,
      footprintX       = 16,
      footprintZ       = 16,
      mass             = 750,
      metal            = 150,
      object           = [[b16x16heap.s3o]],
      reclaimable      = true,
      reclaimTime      = 4500,
    },


  },



}



return lowerkeys({ mnanoforge = unitDef })
