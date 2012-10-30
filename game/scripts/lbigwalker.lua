    --Warrior Drone animation script by Oksnoop2 and Sanada
    
    --pieces
    local body = piece "body"

    local barrel = piece "barrel"
    local flare1 = piece "flare1"

    local lbthigh = piece "lbthigh"
    local lbshin = piece "lbshin"
    local lbfoot = piece "lbfoot"

    local rbthigh = piece "rbthigh"
    local rbshin = piece "rbshin"
    local rbfoot = piece "rbfoot"

    local flare2  = piece "flare2"

    local lfthigh = piece "lfthigh"
    local lfshin = piece "lfshin"
    local lffoot = piece "lffoot"

    local rfthigh = piece "rfthigh"
    local rfshin = piece "rfshin"
    local rffoot = piece "rffoot"


    --signals
    local SIG_AIM = 1
    local walk_go = 2


    --CEGs
    local ct_dirt = SFX.CEG 
    
    local speed = 0.5


    --local functions
    local function Walk()
            SetSignalMask( walk_go )
        Turn( rfthigh, x_axis, -0.25, speed )
        Turn( lbthigh, x_axis, -0.15, speed )

        WaitForTurn( rfthigh, x_axis )
        WaitForTurn( lbthigh, x_axis )
                Sleep(1)

            while ( true ) do
            Turn( lfthigh, x_axis, -0.25, speed)
            Turn( rbthigh, x_axis, -0.15, speed)

            Turn (rfthigh, x_axis, 0.15, speed)
            Turn (lbthigh, x_axis, 0.25, speed)

            WaitForTurn( lfthigh, x_axis )
            WaitForTurn( rbthigh, x_axis )

            WaitForTurn( rfthigh, x_axis )
            WaitForTurn( lbthigh, x_axis )
            Sleep(1)

            Turn( lfthigh, x_axis, 0.15, speed)
            Turn( rbthigh, x_axis, 0.25, speed)

            Turn (rfthigh, x_axis, -0.25, speed)
            Turn (lbthigh, x_axis, -0.15, speed)

            WaitForTurn( lfthigh, x_axis )
            WaitForTurn( rbthigh, x_axis )

            WaitForTurn( rfthigh, x_axis )
            WaitForTurn( lbthigh, x_axis )
            Sleep(1)
            end
    end
    
    local function StopWalk()
            Signal( walk_go )
            Turn( lfthigh, x_axis, 0, speed)
            Turn( rbthigh, x_axis, 0, speed)

            Turn (rfthigh, x_axis, 0, speed)
            Turn (lbthigh, x_axis, 0, speed)
    end

    local function BurrowAnim()
        --Stop Movement
        Signal(SIG_WALK)
        moving = false
        Spring.MoveCtrl.Enable(unitID)
        attacking = false
        
        --Set Cloak
        Spring.SetUnitCloak(unitID, 1)      
        Sleep(200)
        
        --Play sound
        local x, y, z = Spring.GetUnitPosition(unitID)
        --Spring.PlaySoundFile("sounds/digin.wav", 30, x, y, z)
        
        --Animation
        Move( body, y_axis, -38, 50 )
        EmitSfx(body, ct_dirt)
        Sleep(100)
        EmitSfx(body, ct_dirt)
        
        --??
        Spring.SetUnitRulesParam(unitID,'burrowed',1)
        burrowed = true
        return(1)
    end

    local function UnBurrowAnim()
        --Allow Movement
        Signal(SIG_WALK)
        moving = true
        Spring.MoveCtrl.Disable(unitID)
        attacking = true
        
        --Turn off cloak
        Spring.SetUnitCloak(unitID, 0)
        Sleep(200)
        
        --Play sound
        local x, y, z = Spring.GetUnitPosition(unitID)
        --Spring.PlaySoundFile("sounds/digout.wav", 30, x, y, z)
        
        --Animation
        Move( body, y_axis, 0, 50 )     
        Sleep(100)
        StartThread( Walk )
        EmitSfx(body, ct_dirt)
        Sleep(100)
        EmitSfx(body, ct_dirt)      
        Sleep(1000)
        StartThread( StopWalk)
        
        --??
        Spring.SetUnitRulesParam(unitID,'burrowed',0)
        burrowed = false
        return(1)
    end 
    
    local function RestoreAfterDelay(unitID)
        Sleep(1000)
        Turn(barrel, y_axis, 0, math.rad(150))
        Turn(barrel, x_axis, 0, math.rad(150))
    end


    --script
    function script.Create(unitID)
    end

    function script.Burrow()
        if burrowed then
            StartThread( UnBurrowAnim )
        else
            StartThread( BurrowAnim )   
        end
    end

    function script.StartMoving()
            StartThread( Walk )
    end
    
    function script.StopMoving()
            StartThread( StopWalk )
    end
    
    function script.QueryWeapon1() return flare1 end
    
    function script.AimFromWeapon1() return body end
    
    function script.AimWeapon1( heading, pitch )
        Signal(SIG_AIM)
        SetSignalMask(SIG_AIM)
        Turn(barrel, y_axis, heading, math.rad(150))
        Turn(barrel, x_axis, -pitch, math.rad(100))
        WaitForTurn(barrel, y_axis)
        WaitForTurn(barrel, x_axis)
        StartThread(RestoreAfterDelay)
        if burrowed then return false
        else
        return true
        end
    end
    
    function script.QueryNanoPiece() return barrel end

    
    function script.StartBuilding(heading, pitch)
        Signal(SIG_BUILD)
        SetSignalMask(SIG_BUILD)
        Turn(barrel, y_axis, heading, math.rad(90))
        Turn(barrel, x_axis, -pitch, math.rad(100))
        WaitForTurn(barrel, y_axis)
        SetUnitValue(COB.INBUILDSTANCE, 1)
        if burrowed then return 0
        else
        return 1
        end
    end

    function script.StopBuilding()
        Signal(SIG_BUILD)
        SetSignalMask(SIG_BUILD)
        SetUnitValue(COB.INBUILDSTANCE, 0)
        Turn(barrel, y_axis, 0, math.rad(90))
        WaitForTurn(barrel, y_axis)
        Sleep(1)
        return 0
    end
    
    function script.FireWeapon1()
    end
    
    function script.Killed(recentDamage, maxHealth)
        return 0
    end
