local generalcfg = {
	--------------------------------------------------------------------------------------------------------
	--			general  settongs
	--------------------------------------------------------------------------------------------------------
	
	minheight			= 5,
	maxheight			= 600,
	waterheight			= 0,
	invertedwaterheight	= 0,
	minwind				= 1,
	maxwind				= 20,
	tidalstrength		= 10,
	gravity				= 130,
	maxmetal			= 0.9,
	extractorradius		= 68,
	maphardness			= 800,
	autoshowmetal		= 1,
	notDeformable		= 0,
	grassBladeTex    	= "",
	grassShadingTex  	= "",
	grassBladeWaveScale = 1.0,
    grassBladeWidth     = 0.32,
    grassBladeHeight    = 4.0,
    grassBladeAngle     = 1.57, -- (PI / 2) radians
	
	weathersystem = {
		snow = {
			particledensity			= 1024,
			particlescale			= 5000,
			particlespeed			= 20,
			particletexture		= 'LuaGaia/effects/snowflake.tga',
		},
	},
}


return generalcfg