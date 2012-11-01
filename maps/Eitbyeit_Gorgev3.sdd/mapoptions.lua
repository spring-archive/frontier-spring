----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

--  File:    MapOptions.lua
--  Description:   Custom MapOptions file that makes possible to set up variable options before game starts, like ModOptions.lua
--  Author:  SirArtturi, Lurker, Smoth


----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

--[[  OPTION DEFINITION FILES

  CustomMapOptions.lua
  - belongs in the map archive
  - options that get used by LuaGaia

  CustomModOptions.lua
  - belongs in the mod archive
  - options that get used by LuaRules

--]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--  NOTES:
--  - using an enumerated table lets you specify the options order

--
--  These keywords must be lowercase for LuaParser to read them.
--
--  key:      the string used in the script.txt
--  name:     the displayed name
--  desc:     the description (could be used as a tooltip)
--  type:     the option type
--  def:      the default value
--  min:      minimum value for number options
--  max:      maximum value for number options
--  step:     quantization step, aligned to the def value
--  maxlen:   the maximum string length for string options
--  items:    array of item strings for list options
--  scope:    'all', 'player', 'team', 'allyteam'      <<< not supported yet >>>
--

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local options = {
	{
		key = 'Terrain',
		name = 'Changes terrain',
		desc = 'alter the world you play in',
		type = 'section',
	},
--	{
--		key="dry",
--		name="Wetness",
--		desc="How wet do you like it?",
--		type="list",
--		def="1",
--		section= 'Terrain',
--		items = {
--			{ key = "0", name = "Wet", desc = "water"  },
--			{ key = "1", name = "Dry", desc = "no water" }
--		},
--	},	
		
	{
		key = 'inv',
		name = 'Inverts the world',
		desc = "flips things",
		type = 'bool',
		section = 'Terrain',
		def = false,
	},
		
	{
		key = 'Atmosphere',
		name = 'Atmosphere settings',
		desc = 'Weather and time',
		type = 'section',
	},
		
--	{
--		key="alt",
--		name="Time of day",
--		desc="Night or day?",
--		type="list",
--		def="0",
--		section= 'Atmosphere',
--		items = {
--			{ key = "0", name = "Day", desc = "Day Time"  },
--			{ key = "1", name = "Night", desc = "Night Time" }
--		},
--	},
	
	-- {
		-- key="wc",
		-- name="Weather conditions",
		-- desc="Look outside",
		-- type="list",
		-- def="0",
		-- section= 'Atmosphere',
		-- items = {
			-- { key = "0", name = "None", desc = "no weather"  },
			-- { key = "1", name = "Snowing", desc = "snowy day" }
		-- },
	-- },
	
--	{
--		key = 'fog',
--		name = 'want fog?',
--		desc = "enable a dense fog",
--		type = 'bool',
--		section = 'Atmosphere',
--		def = false,
--	},
}
return options