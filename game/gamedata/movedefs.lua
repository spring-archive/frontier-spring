local moveDefs =
{
	        {
	                name = "Engineer2x2",			
	                footprintx = 2,
	                footprintz = 2,
	                maxwaterdepth = 30,
	                maxslope = 36,
					slopemod = 0.1,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,
	                crushstrength = 50,
	        },
			
	        {
	                name = "Engineer3x3",
	                footprintx = 3,
	                footprintz = 3,
	                maxwaterdepth = 30,
	                maxslope = 36,
					slopemod = 0.1,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,					
	                crushstrength = 50,
	        },			

	        {
	                name = "Mech3x3",
	                footprintx = 3,
	                footprintz = 3,
	                maxwaterdepth = 22,
	                maxslope = 36,
					slopemod = 0.1,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,
	                crushstrength = 50,
	        },
	
	        {
	                name = "Mech4x4",
	                footprintx = 4,
	                footprintz = 4,
	                maxwaterdepth = 22,
	                maxslope = 36,
					slopemod = 0.1,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 0,
					heatmod = 50,					
	                crushstrength = 50,
	        },
			
	        {
	                name = "Mech6x6",
	                footprintx = 6,
	                footprintz = 6,
	                maxwaterdepth = 22,
	                maxslope = 36,
					slopemod = 0.1,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 0,
					heatmod = 50,
	                crushstrength = 500,
	        },			

	        {
	                name = "TANK2x2",
	                footprintx = 2,
	                footprintz = 2,
	                maxwaterdepth = 22,
	                maxslope = 18,
					slopemod = 0.2,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,					
	                crushstrength = 50,
	        },
			
	        {
	                name = "TANK3x3",
	                footprintx = 3,
	                footprintz = 3,
	                maxwaterdepth = 22,
	                maxslope = 18,
					slopemod = 0.2,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,						
	                crushstrength = 50,
	        },			

	        {
	                name = "TANK4x4",
	                footprintx = 4,
	                footprintz = 4,
	                maxwaterdepth = 22,
	                maxslope = 18,
					slopemod = 0.2,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 0,
					heatmod = 50,
	                crushstrength = 500,
	        },

	        {
	                name = "TANK5x5",
	                footprintx = 5,
	                footprintz = 5,
	                maxwaterdepth = 22,
	                maxslope = 18,
					slopemod = 0.2,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 0,
					heatmod = 50,
	                crushstrength = 1000,
	        },

	        {
	                name = "SHIP3x3",
	                footprintx = 3,
	                footprintz = 3,
	                minwaterdepth = 5,
					maxslope = 60,
					slopemod = 0.07,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,					
	                crushstrength = 50,
	        },

	        {
	                name = "SHIP4x4",
	                footprintx = 4,
	                footprintz = 4,
	                minwaterdepth = 5,
					maxslope = 60,
					slopemod = 0.07,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,					
	                crushstrength = 50,
	        },

	        {
	                name = "SHIP5x5",
	                footprintx = 5,
	                footprintz = 5,
	                minwaterdepth = 5,
					maxslope = 60,
					slopemod = 0.07,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,					
	                crushstrength = 50,
	        },
			
	        {
	                name = "SHIP6x6",
	                footprintx = 6,
	                footprintz = 6,
	                minwaterdepth = 5,
					maxslope = 60,
					slopemod = 0.07,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,
	                crushstrength = 50,
	        },			

	        {
	                name = "SHIP7x7",
	                footprintx = 7,
	                footprintz = 7,
	                minwaterdepth = 10,
					maxslope = 60,
					slopemod = 0.07,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,					
	                crushstrength = 500,
	        },
			
	        {
	                name = "SHIP8x8",
	                footprintx = 8,
	                footprintz = 8,
	                minwaterdepth = 10,
					maxslope = 60,
					slopemod = 0.07,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,					
	                crushstrength = 500,
	        },			

	        {
	                name = "SHIP10x10",
	                footprintx = 10,
	                footprintz = 10,
	                minwaterdepth = 15,
					maxslope = 60,
					slopemod = 0.07,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,					
	                crushstrength = 1000,
	        },

	        {
	                name = "HOVER2x2",
	                footprintx = 2,
	                footprintz = 2,
	                maxwaterdepth = 22,
	                maxslope = 18,
					slopemod = 0.2,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,
	                crushstrength = 50,
	        },

	        {
	                name = "HOVER4x4",
	                footprintx = 4,
	                footprintz = 4,
	                maxwaterdepth = 22,
	                maxslope = 18,
					slopemod = 0.2,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,
	                crushstrength = 500,
	        },

	        {
	                name = "HOVER8x8",
	                footprintx = 8,
	                footprintz = 8,
	                maxwaterdepth = 22,
	                maxslope = 18,
					slopemod = 0.2,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 22,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,
	                crushstrength = 1000,
	        },

	        {
	                name = "SubBOAT4x4",
	                footprintx = 4,
	                footprintz = 4,
	                minwaterdepth = 45,
	                crushstrength = 500,
					maxslope = 60,
					slopemod = 0.07,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,
	                subMarine = 1,
	        },
			
	        {
	                name = "SubBOAT5x5",
	                footprintx = 5,
	                footprintz = 5,
	                minwaterdepth = 45,
	                crushstrength = 500,
					maxslope = 60,
					slopemod = 0.07,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 30,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,					
	                subMarine = 1,
	        },			
 		
	        {
	                name = "kdrone",
	                footprintx = 3,
	                footprintz = 3,
	                maxwaterdepth = 99999999,
	                maxslope = 99999999,
					slopemod = 4,
                    depthModParams = {
                        minHeight      = 0.0,
                        maxHeight      = 99999999,
                        maxScale       = 2,
                        quadraticCoeff = 0.0,
                        linearCoeff    = 0.1,
                        constantCoeff  = 1.0,
                    },
					minwaterdepth = 10,
					heatproduced = 60,
					heatmapping = 1,
					heatmod = 50,
	                crushstrength = 50,
	        },	
}

return moveDefs