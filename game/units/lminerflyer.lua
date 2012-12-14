    unitDef = {
      unitname            = [[lminerflyer]],
      name                = [[Locust Shaper]],
      description         = [[Aerial Shaper Unit - Can produce Nanomorphs from minerals]],
      amphibious          = false,
      buildCostEnergy     = 20,
      buildCostMetal      = 20,
      builder             = false,
      buildPic            = [[lminerflyer.png]],
      buildTime           = 10,
      canAttack           = true,
      canDropFlare        = false,
      canFly              = true,
      canFight            = true,
      canGuard            = true,
      canMove             = true,
      canPatrol           = true,
      canStop             = true,
      canSubmerge         = false,
      category            = [[GUNSHIP]],
      collide             = false,
      corpse              = [[DEAD]],
      cruiseAlt           = 110,
      reclaimable         = false,
      
      customParams = {
		  is_shaper=true,
		  --shapedefs={ bminerals="lstemcell", bminerals_big="lstemcell"},
		  
		  shapessmallrockto="lstemcell",
		  shapesbigrockto="lobelisk",
          
          
          --is_miner=true,   --used by minig: if the unit can mine is_mineable=1 ressources
          --max_cargo=25,    --used by mining: how much metal the unit can carry at once before having to return to a drop off --currently not in use
        },
    
      explodeAs           = [[SMALL_UNIT]],
      floater             = false,
      footprintx          = 2,
      footprintZ          = 2,
      hoverAttack         = true,
      idleAutoHeal        = 0,
      mass                = 15,
      maxAcc              = 1,
      maxDamage           = 10,
      maxVelocity         = 1.5,
      moveState           = 2,
      noAutoFire          = false,
      noChaseCategory     = [[LAND SINK HOVER SHIP FLOAT FIXEDWING GUNSHIP CRUISER SUB]],
      objectName          = [[lminerflyer.s3o]],
      radarDistance       = 750,
      seismicSignature    = 0,
      selfDestructAs      = [[SMALL_UNIT]],
      side                = [[DRONE]],
      sightDistance       = 750,
      smoothAnim          = true,

      sfxtypes            = {
        explosiongenerators = {
        "custom:ct_mininglaser_green",
        },
      },      
      
      sounds            = {
          select = {
        "argh/Argh_Jet.wav",
        },

          ok = {
        "argh/Argh_Jet.wav",
        },
      },

      turnRadius          = 200,
      --unitRestricted      = 20,
      useSmoothMesh       = false,
      script              = [[lminerflyer.lua]],

          weapons             = {
        
            {
              def                = [[Rock_Laser]],
              onlyTargetCategory = [[MINERALS]],
            },
        
          },

          weaponDefs          = {
        
            Rock_Laser = {
              name                    = [[Rock Laser]],
              areaOfEffect            = 8,
              avoidFeature            = false,
              avoidFriendly           = false,
              craterMult              = 0.25,
              accuracy                = 0,
              collideFriendly         = false,
        
              damage                  = {
                default = 1,
                Cruiser = 0,
                Building = 0,
                Land = 0,
                Aircraft = 0,
                Ship = 0,
                Sub = 0,

                Meteor = 100,
                Drone = 0,
                Spare1 = 0,
                Spare2 = 0,
                Spare3 = 0,
              },
        
              explosionGenerator      = [[custom:resmining_green]],
              interceptedByShieldType = 1,
              impulseFactor           = 0,
              lineOfSight             = true,
              range                   = 215,
              reloadtime              = 0.1,
              rgbColor                = [[.4 1 0.4]],
              separation              = 2,
              size                    = 0.05,
              soundStart              = [[tp/swoosh]],
              soundStartVolume        = 0.5,
              soundTrigger            = true,
              stages                  = 50,
              targetBorder            = 1,
              tolerance               = 8000,
              turret                  = true,
              weaponType              = [[BeamLaser]],
              weaponVelocity          = 7500,


          },
        
      },
    
    
      featureDefs         = {
            
        DEAD = {
          description      = [[Debris - Drone Miner-Flyer]],
          blocking         = false,
          category         = [[heaps]],
          damage           = 50,
          energy           = 0,
          footprintX       = 2,
          footprintZ       = 2,
          metal            = 25,
          object           = [[b1x1heap.s3o]],
          reclaimable      = true,
          reclaimTime      = 750,
        },
    
      },
    
    }
    
    return lowerkeys({ lminerflyer = unitDef })
