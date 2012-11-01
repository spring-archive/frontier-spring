local nightcfg = {
	--------------------------------------------------------------------------------------------------------
	--			night settongs
	--------------------------------------------------------------------------------------------------------
	weather = {
		clear = {
			skybox 							= "",
			detailTex						= "detailtexdark.bmp",
			cloudcolor						= { 0, 0, 0 },
			suncolor						= { 1, 1, 1 },
			sundir							= { 0, 0.7, -1 },
			clouddensity					= 0.5,
			skycolor						= { 0.01, 0.1, 0.3 },
			fogcolor						= { 0.00, 0.01, 0.01 },
			fogstart						= 0.4,
			groundambientcolor				= { 0.3, 0.25, 0.25 },
			grounddiffusecolor				= { 0.35, 0.36, 0.68 },
			groundshadowdensity				= 0.9,
			unitambientcolor				= { 0.26, 0.33, 0.35 },
			unitdiffusecolor				= { 0.3, 0.35, 0.4 },
			unitshadowdensity				= 0.7,
			specularsuncolor				= { 0.2, 0.3, 0.5 },
			},
				
		snow = {
			skybox 							= "",
			detailTex						= "realdetnight.bmp",
			cloudcolor						= { 0, 0, 0 },
			suncolor						= { 1, 1, 1 },
			sundir							= { 0, 0.7, -1 },
			clouddensity					= 0.3,
			skycolor						= { 0.0, 0.0, 0.1 },
			fogcolor						= { 0.06, 0.10, 0.11 },
			fogstart						= 0.3,
			groundambientcolor				= { 0.3, 0.25, 0.5 },
			grounddiffusecolor				= { 0.6, 0.55, 0.95 },
			groundshadowdensity				= 0.7,
			unitambientcolor				= { 0.26, 0.33, 0.45 },
			unitdiffusecolor				= { 0.3, 0.35, 0.4 },
			unitshadowdensity				= 0.7,
			specularsuncolor				= { 0.1, 0.5, 0.8 },
			},
	},
		
	fog = {
		color			= {0.3,0.35,0.45},
		height			= 600,
		layers			= 0,
		layerspacing	= 50,
		mapsized		= 0.0,
		fogmaxstrength	= 0.1,
		foglowheight	= 200,
		fogatten 		= 0.0008,			
	},
		
	water ={
		shorewaves				= true,
		forcerendering			= false,
		absorb					= { 0.01, 0.0060, 0.004 },
		ambientfactor			= 0.1,
		basecolor				= { 0.1, 0.2, 0.25 },
		blurbase				= 8.0,
		blurexponent			= 2.0,
		diffusecolor			= { 0.7, 0.70, 0.6 },
		diffusefactor			= 0,
		fresnelmin				= 0.45,
		fresnelmax				= 0.45,
		fresnelpower			= 12,
		mincolor				= { 0.1, 0.1, 0.10 },
		perlinstartfreq			= 9.0,
		perlinlacunarity		= 2.5,
		perlinamplitude 		= 0.9,
		planecolor				= { 0.1, 0.2, 0.25 },
		reflectiondistortion 	= 0.7,
		specularcolor			= { 0.2, 0.25, 0.5 },
		specularfactor			= 9.7,
		specularpower			= 200,
		surfacecolor			= { 0.1, 0.2, 0.25 },
		surfacealpha			= 0.1,
	},
}


return nightcfg