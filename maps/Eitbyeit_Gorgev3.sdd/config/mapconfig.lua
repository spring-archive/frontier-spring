local cfg = {}
local SGetMapOptions
	if Spring.GetMapOptions then 
	
		SGetMapOptions	=	Spring.GetMapOptions() 
--		cfg.AtmoSDefs	= {}
--		cfg.WaterDefs	= {}
		cfg.voidwater	= {}
		
		--general config
		cfg = VFS.Include("config/map/general.lua")
		
		--options
--		cfg.day = VFS.Include("config/map/day.lua")
--		cfg.night = VFS.Include("config/map/night.lua")

--		if (SGetMapOptions.wc == "1")	then
--			if (SGetMapOptions.alt == "1") then
--				cfg.AtmoSDefs = cfg.night.weather.snow
--				cfg.WaterDefs = cfg.night.water
--				else 
--					cfg.AtmoSDefs = cfg.day.weather.snow
--					cfg.WaterDefs = cfg.day.water		
--			end
--			else	-- clear skies
--				if (SGetMapOptions.alt == "1") then
--					cfg.AtmoSDefs = cfg.night.weather.clear
--					cfg.WaterDefs = cfg.night.water
--					else 
					--Settings day.
--						cfg.AtmoSDefs = cfg.day.weather.clear
--						cfg.WaterDefs = cfg.day.water
--				end
--		end
		

		
		if (SGetMapOptions.inv == "1" ) then	
			tempminheight 		= 	cfg.minheight
			tempmaxheight 		=  	cfg.maxheight
			
			cfg.minheight 		= 	tempmaxheight
			cfg.maxheight 		=  	tempminheight
			cfg.waterheight		=	cfg.invertedwaterheight
		end	
		
		if (SGetMapOptions.dry == "1" ) then
			cfg.voidwater		=	true
		elseif (SGetMapOptions.dry == "0" ) then
		
			cfg.voidwater		=	false
			cfg.minheight		=	cfg.minheight - cfg.waterheight
			cfg.maxheight		=	cfg.maxheight - cfg.waterheight
		end
	end
return cfg