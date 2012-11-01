--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    mapinfo.lua
--  brief:   map configuration loader
--  author:  Dave Rodgers, Lurker, Smoth
--
--  Copyright (C) 2008.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Special table for map config files
--
--   Map.fileName
--   Map.fullName
--   Map.configFile

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function IsTdf(text)
  local s, e, c = text:find('(%S)') -- first non-space character
  -- TDF files should start with:
  --   '[name]' - section header
  --   '/*'     - comment
  --   '//      - comment
  return ((c == '[') or (c == '/'))
end


--------------------------------------------------------------------------------

local configFile = Map.configFile
local mapcfg
-- local SplatDefs
local waterheight

if VFS.FileExists("config/mapconfig.lua") then
	mapcfg = VFS.Include("config/mapconfig.lua")
	else
		  error("missing file: config/mapconfig.lua")
end

-- if VFS.FileExists("config/splatconfig.lua") then
--	SplatDefs = VFS.Include("config/splatconfig.lua")
--	else
--		  error("missing file: config/splatconfig.lua")
-- end

local WaterDefs

local configSource, err = VFS.LoadFile(configFile)
if (configSource == nil) then
  error(configFile .. ': ' .. err)
end


--------------------------------------------------------------------------------

local mapInfo, err

if (IsTdf(configSource)) then
  local mapTdfParser = VFS.Include('maphelper/parse_tdf_map.lua')
  mapInfo, err = mapTdfParser(configSource)
  if (mapInfo == nil) then
    error(configFile .. ': ' .. err)
  end
else
  local chunk, err = loadstring(configSource, configFile)
  if (chunk == nil) then
    error(configFile .. ': ' .. err)
  end
  mapInfo = chunk()
end

mapInfo.smf ={
	minheight	=	0,
	maxheight	=	0,
}

-- mapInfo.splats = {
--    texScales = {0.02, 0.02, 0.02, 0.02},
--    texMults  = {1.00, 1.00, 1.00, 1.00},
-- }
  
mapInfo.grass = {
	bladeWaveScale	= 1.0,
    bladeWidth		= 0.32,
    bladeHeight		= 4.0,
    bladeAngle		= 1.57,
 }
--------------------------------------------------------------------------------

--if (Spring.GetMapOptions and mapInfo.defaultoptions) then
  local optsFunc = VFS.Include('maphelper/applyopts.lua')
  optsFunc(mapInfo)
--end

	
if Spring.GetMapOptions then
--	AtmoSDefs	=	mapcfg.AtmoSDefs
--	WaterDefs	=	mapcfg.WaterDefs	
	
	-- Get some defaults
	mapInfo.atmosphere.minwind	=  	mapcfg.minwind
	mapInfo.atmosphere.maxwind	=  	mapcfg.maxwind
	mapInfo.tidalstrength		=  	mapcfg.tidalstrength
	mapInfo.gravity				=  	mapcfg.gravity
	mapInfo.maxmetal			=  	mapcfg.maxmetal
	mapInfo.extractorradius		=  	mapcfg.extractorradius
	mapInfo.maphardness			=  	mapcfg.maphardness
	mapInfo.autoshowmetal		=   mapcfg.autoshowmetal
	mapInfo.notDeformable		=   mapcfg.notDeformable
	
	mapInfo.smf.minheight 		= 	mapcfg.minheight
	mapInfo.smf.maxheight 		=  	mapcfg.maxheight
	
--	mapInfo.resources.detailTex 		= 	AtmoSDefs.detailTex
--	mapInfo.resources.splatDistrTex 	= 	SplatDefs.splatDistrTex
--	mapInfo.resources.splatDetailTex 	= 	SplatDefs.splatDetailTex
--	mapInfo.resources.specularTex 		= 	SplatDefs.specularTex
--	mapInfo.resources.skyReflectModTex	= 	SplatDefs.skyReflectModTex
	
--  mapInfo.splats.texScales			=	SplatDefs.SplatTexScales
--	mapInfo.splats.texMults				=	SplatDefs.SplatTexMults
	
	mapInfo.grass.bladeWaveScale		= 	mapcfg.grassBladeWaveScale
	mapInfo.grass.bladeWidth     		= 	mapcfg.grassBladeWidth
	mapInfo.grass.bladeHeight    		=  	mapcfg.grassBladeHeight
	mapInfo.grass.bladeAngle     		= 	mapcfg.grassBladeAngle
	
--	mapInfo.atmosphere.skybox			=	AtmoSDefs.skybox	
--	mapInfo.atmosphere.cloudcolor		=	AtmoSDefs.cloudcolor
--	mapInfo.atmosphere.suncolor			=	AtmoSDefs.suncolor
--	mapInfo.atmosphere.clouddensity		=	AtmoSDefs.clouddensity
--	mapInfo.atmosphere.skycolor			=	AtmoSDefs.skycolor
--	mapInfo.atmosphere.fogcolor			=	AtmoSDefs.fogcolor
--	mapInfo.atmosphere.fogstart			=	AtmoSDefs.fogstart

--	mapInfo.lighting.sundir					=	AtmoSDefs.sundir	
	
--	mapInfo.lighting.groundambientcolor		=	AtmoSDefs.groundambientcolor	
--	mapInfo.lighting.grounddiffusecolor		=	AtmoSDefs.grounddiffusecolor
--	mapInfo.lighting.groundshadowdensity	=	AtmoSDefs.groundshadowdensity

--	mapInfo.lighting.unitambientcolor	=	AtmoSDefs.unitambientcolor
--	mapInfo.lighting.unitdiffusecolor	=	AtmoSDefs.unitdiffusecolor
--	mapInfo.lighting.unitshadowdensity	=	AtmoSDefs.unitshadowdensity
--	mapInfo.lighting.specularsuncolor	=	AtmoSDefs.specularsuncolor
		
	mapInfo.voidwater					=	mapcfg.voidwater	
--	mapInfo.water.shorewaves 			=	WaterDefs.shorewaves
--	mapInfo.water.forcerendering 		=	WaterDefs.forcerendering
--	mapInfo.water.absorb				=	WaterDefs.absorb
--	mapInfo.water.ambientfactor 		=	WaterDefs.ambientfactor
--	mapInfo.water.basecolor				=	WaterDefs.basecolor
--	mapInfo.water.blurbase 				=	WaterDefs.blurbase
--	mapInfo.water.blurexponent 			=	WaterDefs.blurexponent
--	mapInfo.water.diffusecolor 			=	WaterDefs.diffusecolor
--	mapInfo.water.diffusefactor 		=	WaterDefs.diffusefactor
--	mapInfo.water.fresnelmin 			=	WaterDefs.fresnelmin
--	mapInfo.water.fresnelmax 			=	WaterDefs.fresnelmax
--	mapInfo.water.fresnelpower 			=	WaterDefs.fresnelpower
--	mapInfo.water.mincolor				=	WaterDefs.mincolor
--	mapInfo.water.perlinstartfreq 		=	WaterDefs.perlinstartfreq
--	mapInfo.water.perlinlacunarity 		=	WaterDefs.perlinlacunarity
--	mapInfo.water.perlinamplitude 		=	WaterDefs.perlinamplitude		
--	mapInfo.water.planecolor			=	WaterDefs.planecolor
--	mapInfo.water.reflectiondistortion 	=	WaterDefs.reflectiondistortion
--	mapInfo.water.specularcolor 		=	WaterDefs.specularcolor
--	mapInfo.water.specularfactor 		=	WaterDefs.specularfactor
--	mapInfo.water.specularpower 		=	WaterDefs.specularpower
--	mapInfo.water.surfacecolor			=	WaterDefs.surfacecolor
--	mapInfo.water.surfacealpha			=	WaterDefs.surfacealpha
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return mapInfo

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------