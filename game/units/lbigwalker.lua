local lbigwalker = {
    name                = [[Drone Walker]],
    description         = [[Fires a powerful beam of Anti-Unit plasma. Can Burrow.]],
    acceleration        = 1,
    brakerate           = 0.1,
    buildpic            = [[lwarrior.png]],
    buildCostEnergy     = 300,
    buildCostMetal      = 300,
    buildTime           = 100,
    --buildDistance       = 300,
    builder             = false,
    --buildoptions        = {
    --    [[lwarrior]],
    --    [[lengineer]],
    --    [[laadrone]],
    --    [[kdiairdrone]],
    --    [[ktriairdrone]],
    --},

    CanAttack           = true,
    canAssist           = true,
    canGuard            = true,
    canMove             = true,
    canPatrol           = true,
    canReclaim          = true,
    canStop             = true,
    category            = [[LAND]],
    corpse              = [[DEAD]],
    customParams = { is_dropoff=true,   },
    reclaimable         = false,
    
    cloakCost           = 2,
    cloakCostMoving     = 2,
    cloakTimeout        = 0,
    init_Cloaked        = false,    
    
    energyMake          = 30,
    explodeAs           = [[DRONE_GROUND_UNIT]],
    footprintx          = 10, 
    footprintZ          = 10, 
    idleAutoHeal        = 1,
    leaveTracks         = false,
    mass                = 800,
    maxDamage           = 7000,
    maxSlope            = 99999999,
    maxVelocity         = 3,
    maxWaterDepth       = 10000,
    metalMake           = 0,
    movementClass       = [[kdrone]],
    noChaseCategory     = [[MINERALS FIXEDWING GUNSHIP CRUISER SUB]],
    objectName          = "lbigwalker.s3o",
    onoffable           = false,
    seismicSignature    = 4,
    selfDestructAs      = [[DRONE_GROUND_UNIT]],
    side                = [[Drone]],
    sightDistance       = 1000,
    
    sfxtypes            = {
        explosiongenerators = {
        "custom:ct_dirt",
        },
    },  
    
    sounds          = {
          select = {
        "golgotha/vehicle_done_44khz",
        },
          ok = {
        "golgotha/vehicle_done_44khz",
        },
      },

    smoothAnim          = true,
    terraformSpeed      = 300,
    reclaimSpeed        = 300,
    repairSpeed         = 0.5,  
    turnInPlace         = 1,
    turnRate            = 1000,
    showNanospray       = 1,
    Resurrectspeed      = 100,
    workerTime          = 1,
    script              = "lbigwalker.lua",

    weapons             = {
        --{
        --    def = [[Shield]],
        --}
        {
          def                = [[Laser]],
          badTargetCategory  = [[SWIM LAND SHIP HOVER]],
          onlyTargetCategory = [[SWIM LAND SINK FLOAT SHIP HOVER]],
        },
        
    },
        
    weaponDefs          = {
        Laser = {
          name                    = [[BeamLaser]],
          areaOfEffect            = 8,
          avoidFeature            = false,
          coreThickness           = 0.5,
          collideFriendly         = false,
          craterMult              = 0.25,
    
          damage                  = {
        --Anti-Land
        default = 100,
        --[[Cruiser = 50,
        Building = 50,
        Tank = 100,
        Aircraft = 50,
        Ship = 50,
        Sub = 50,

        Meteor = 0,
        Drone = 50,
        Spare1 = 50,
        Spare2 = 50,
        Spare3 = 50,]]
          },

          beamTime                = 0.5,
          explosionGenerator      = [[custom:ct_impact_beam_green]],
          duration                = 5,
          energypershot           = 0,
          interceptedByShieldType = 1,
          heightMod               = 0.5,
          lineOfSight             = true,
          range                   = 1500,
          reloadtime              = 2,
          rgbColor                = [[0 1 0]],
          soundStart              = [[ct/pew1]],
          targetMoveError         = 0,
          thickness               = 15,
          tolerance               = 100,
          turret                  = true,
          weaponType              = [[BeamLaser]],
          weaponVelocity          = 2000,
        },
            
        Shield = {
            name                    = [[Energy Shield]],
            craterMult              = 0,
        
            damage                  = {
                default = 10,
            },
        
            exteriorShield          = true,
            impulseFactor           = 0,
            interceptedByShieldType = 1,
            isShield                = true,
            shieldAlpha             = 1,
            shieldBadColor          = [[1 0 0]],
            shieldGoodColor         = [[0 0 1]],
            shieldforce             = 10,
            shieldInterceptType     = 1,
            shieldPower             = 800,
            shieldPowerRegen        = 5,
            shieldPowerRegenEnergy  = 15,
            shieldRadius            = 420,
            shieldRepulser          = true,
            smartShield             = true,
            visibleShield           = true,
            visibleShieldHitFrames  = 4,
            visibleShieldRepulse    = true,
            weaponType              = [[Shield]],
        },
        
    },
    
    featureDefs         = {
    
    
    
        DEAD = {
          description      = [[Debris - Drone Warrior]],
          blocking         = false,
          category         = [[heaps]],
          damage           = 2,
          energy           = 0,
          footprintX       = 8,
          footprintZ       = 8,
          metal            = 75,
          object           = [[b8x8heap.s3o]],
          reclaimable      = true,
          reclaimTime      = 2250,
        },

      },

    }


return lowerkeys({ ["lbigwalker"] = lbigwalker })
