--we are going to put flatification code here
--something like this:
--  local unitx,unity,unitz = Spring.GetUnitPosition(unitID)
--  Spring.LevelHeightMap(unitx-100,unitz-100,unitx+100,unitz+100,unity)

-------------------------------------------------PERLIN--------------------
function noise( x,  y,  z)
	local X = math.floor(x % 255)
	local Y = math.floor(y % 255)
	local Z = math.floor(z % 255)
	x = x - math.floor(x)
	y = y - math.floor(y)
	z = z - math.floor(z)
	local u = fade(x)
	local v = fade(y)
	local w = fade(z)
 
	A   = p[X  ]+Y
	AA  = p[A]+Z
	AB  = p[A+1]+Z
	B   = p[X+1]+Y
	BA  = p[B]+Z
	BB  = p[B+1]+Z
 
	return lerp(w, lerp(v, lerp(u, grad(p[AA  ], x  , y  , z   ),
								 grad(p[BA  ], x-1, y  , z   )),
						 lerp(u, grad(p[AB  ], x  , y-1, z   ),
								 grad(p[BB  ], x-1, y-1, z   ))),
				 lerp(v, lerp(u, grad(p[AA+1], x  , y  , z-1 ),  
								 grad(p[BA+1], x-1, y  , z-1 )),
						 lerp(u, grad(p[AB+1], x  , y-1, z-1 ),
								 grad(p[BB+1], x-1, y-1, z-1 )))
	)
end

 
function fade (t)
	return t * t * t * (t * (t * 6 - 15) + 10)
end
 
 
function lerp(t,a,b)
	return a + t * (b - a)
end
 
 
function grad(hash,x,y,z)
	local h = hash % 16
	local u
	local v
   
	if (h<8) then u = x else u = y end
	if (h<4) then v = y elseif (h==12 or h==14) then v=x else v=z end
	local r
   
	if ((h%2) == 0) then r=u else r=-u end
	if ((h%4) == 0) then r=r+v else r=r-v end
	return r
end
----------------------------------------/PERLIN--------------------------------

function unitName (unitID)

    if (not Spring.ValidUnitID (unitID)) then return "!invalid unitID in unitName()!" end

    local udID =Spring.GetUnitDefID(unitID)

    local uDef = UnitDefs [udID]

    return uDef.name

end

function gadget:Initialize()	
	Spring.SetHeightMapFunc(function() --Lua: function inside a function, because f*** you.
		for z=0,Game.mapSizeZ, Game.squareSize do
			for x=0,Game.mapSizeX, Game.squareSize do
				--nx,nz,ny = noise(x,z,0.5)
				Spring.SetHeightMap( x, z, 200 + 20 * math.cos((x + z) / 90) )
			end
		end
	end)
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

