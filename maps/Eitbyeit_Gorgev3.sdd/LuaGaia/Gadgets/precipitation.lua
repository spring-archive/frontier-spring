--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    precipitation.lua
--  brief:   precipitation shader gadget
--  author:  Dave Rodgers
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "Precipitation",
    desc      = "Precipitation shader gadget",
    author    = "trepan",
    date      = "May 22, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Unsynced side only
if (gadgetHandler:IsSyncedCode()) then
  return false
end

-- Require shaders
if (gl.CreateShader == nil) then
  return false
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local enabled 

local shader
local shaderTimeLoc
local shaderCamPosLoc
local shaderNeedLocs = true

local rainList
local particleList
local particleConf

local mapcfg

if VFS.FileExists("config/mapconfig.lua") then
	mapcfg = VFS.Include("config/mapconfig.lua")
	else
		  error("missing file: config/mapconfig.lua")
end

	particleConf = mapcfg.weathersystem.snow


	local rainDensity 	= 32 * particleConf.particledensity
	local rainScale 	= particleConf.particlescale
	local rainSpeed 	= particleConf.particlespeed
	local rainTexture 	= particleConf.particletexture

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:Initialize()
  if (not ReloadResources()) then
    gadgetHandler:RemoveGadget()
    return
  end
  
  if Spring.GetMapOptions().wc == "1" then
	enabled = true
  end
  
  gadgetHandler:AddChatAction("rain", ChatAction,
    ':  [0|1]  [speed val]  [scale val]  [density val]  [texture name]'
  )
end


function gadget:Shutdown()
  FreeResources()  
  gadgetHandler:RemoveChatAction("rain")
end


function ReloadResources()
  FreeResources()
  if ((not CreateParticleList()) or
      (not CreateRainList())     or
      (not CreateShader()))    then
    gadgetHandler:RemoveGadget()
    return false
  end
  return true
end


function FreeResources()
  gl.DeleteList(rainList)
  gl.DeleteList(particleList)
  if (gl.DeleteShader) then
    gl.DeleteShader(shader)
  end
  shader = nil
  rainList = nil
  particleList = nil
end


function ChatAction(cmd, line, words, player)
	Spring.Echo(cmd,' : ',line ' : ',words, ':',player)
  if (player ~= 0) then
    Spring.Echo('Only the host can control the weather')
    return true
  end
  if (#words == 0) then
    enabled = not enabled
    Spring.Echo("rain is " .. (enabled and 'enabled' or 'disabled'))
    return
  end
  if (words[1] == '0') then
    enabled = false
    Spring.Echo("rain is disabled")
  elseif (words[1] == '1') then
    enabled = true
    Spring.Echo("rain is enabled")
  elseif (words[1] == 'scale') then
    local value = tonumber(words[2])
    if (value and (value > 0)) then
      rainScale = value
      ReloadResources()
    end
  elseif (words[1] == 'speed') then
    local value = tonumber(words[2])
    if (value) then
      rainSpeed = value
      ReloadResources()
    end
  elseif (words[1] == 'density') then
    local value = tonumber(words[2])
    if (value and (value > 0) and (value <= 1000000)) then
      rainDensity = value
      ReloadResources()
    end
  elseif (words[1] == 'texture') then
    if (type(words[2]) == 'string') then
      rainTexture = words[2]
      ReloadResources()
    end
  end
  return true
end


function CreateParticleList()
  particleList = gl.CreateList(function()
    local tmpRand = math.random()
    math.randomseed(1)
    gl.BeginEnd(GL.POINTS, function()
      for i = 1, rainDensity do
        local x = math.random()
        local y = math.random()
        local z = math.random()
        local w = math.random()
        gl.Vertex(x, y, z, w)
      end
    end)
    math.random(1e9 * tmpRand)
  end)

  if (particleList == nil) then
    return false
  end
  return true
end


function CreateRainList()
  rainList = gl.CreateList(function()
    gl.Color(0, 0, 1, 1)

    gl.PointSprite(true, true)
    gl.PointSize(50.0)
    gl.PointParameter(0, 0, .001, 0, 1e9, 1)

    gl.DepthTest(true)
    gl.Blending(GL.SRC_ALPHA, GL.ONE)
    gl.Texture(rainTexture)

    gl.CallList(particleList)

    gl.Texture(false)
    gl.Blending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
    gl.DepthTest(false)

    gl.PointParameter(1, 0, 0, 0, 1e9, 1)
    gl.PointSize(1.0)
    gl.PointSprite(false, false)
  end)

  if (rainList == nil) then
    return false
  end
  return true
end


function CreateShader()
  shaderNeedLocs = true
  
  shader = gl.CreateShader({
    uniform = {
      time   = 0,
      scale  = rainScale,
      speed  = rainSpeed,
      camPos = { 0, 0, 0 },
    },
    vertex = [[
      uniform float time;
      uniform float scale;
      uniform float speed;
      uniform vec3 camPos;

      void main(void)
      {
        const vec3 scalePos = vec3(gl_Vertex) * scale;

        gl_FrontColor = vec4(0.75 + 0.15 * cos(scalePos.x),
                             0.75 + 0.15 * cos(scalePos.y),
                             0.80 + 0.15 * cos(scalePos.z),
                             gl_Color.a);

        const vec3 eye = camPos;

        vec3 pos = scalePos - mod(camPos, scale);
        pos.y -= time * 0.5 * (speed * (2.0 + gl_Vertex.w));
		pos.x += sin(time)*10;
		pos.z += cos(time)*10;
        pos = mod(pos, scale) - (scale * 0.5) + camPos;
        if (pos.y < 0.0) {
          gl_FrontColor *= 1.0 + 2.0 * (pos.y / scale);
          pos.y = 0.0;
        }
        const vec4 eyePos = gl_ModelViewMatrix * vec4(pos, 1.0);
                
        gl_PointSize = (1 + gl_Vertex.w) * 5000 / length(eyePos);

        gl_Position = gl_ProjectionMatrix * eyePos;
      }
    ]],
  })

  if (shader == nil) then
    print(gl.GetShaderLog())
    return false
  end
  return true
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local startTimer = Spring.GetTimer()
local diffTime = 0


function GetShaderLocations()
  shaderTimeLoc   = gl.GetUniformLocation(shader, 'time')
  shaderCamPosLoc = gl.GetUniformLocation(shader, 'camPos')
end


function gadget:DrawWorld()
  if (not enabled) then
    return
  end
    
  diffTime = Spring.DiffTimers(Spring.GetTimer(), startTimer)

  gl.UseShader(shader)

  if (shaderNeedLocs) then
    GetShaderLocations()
    shaderNeedLocs = false
  end
  gl.Uniform(shaderTimeLoc,   diffTime * 1)
  gl.Uniform(shaderCamPosLoc, Spring.GetCameraPosition())

  gl.CallList(rainList)

  gl.UseShader(0)
end
              

DrawWorldReflection = DrawWorld  --  draw reflections too


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
