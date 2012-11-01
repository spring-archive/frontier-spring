local res = {}
 
local function SpawnResource  (x,y)
        newrock = {}
        newrock.x = x
        newrock.y = y
        table.insert (res, newrock)
end
 
local function SpawnResourceField (x,z,  number, spread)
        for i = 0, number, 1 do
                local sx = x+math.random (-spread/2,spread/2)
                local sz = z+math.random (-spread/2,spread/2)
                SpawnResource (sx,sz)
        end
end
 
 
---coordinates go in between here---

SpawnResourceField (3384 , 297, 3, 300)   -- startrocks
SpawnResourceField (3790 , 261, 3, 300)   -- startrocks
SpawnResourceField (3813 , 576, 3, 300)   -- startrocks
SpawnResourceField (582 , 3806, 3, 300)   -- startrocks
SpawnResourceField (269 , 3796, 3, 300)   -- startrocks
SpawnResourceField (252 , 3476, 3, 300)   -- startrocks
SpawnResourceField (3880 , 3684, 2, 300)   -- bigexpansion
SpawnResourceField (3896 , 3906, 2, 300)   -- bigexpansion
SpawnResourceField (3544 , 3804, 2, 300)   -- bigexpansion
SpawnResourceField (104 , 97, 2, 300)   -- bigexpansion
SpawnResourceField (426 , 113, 2, 300)   -- bigexpansion
SpawnResourceField (132 , 431, 2, 300)   -- bigexpansion
SpawnResourceField (2461 , 1598, 5, 400)   -- biggestexpansion
SpawnResourceField (2751 , 1806, 5, 400)   -- biggestexpansion
SpawnResourceField (1699 , 2187, 5, 400)   -- biggestexpansion
SpawnResourceField (2100 , 2321, 5, 400)   -- biggestexpansion
SpawnResourceField (563 , 2791, 1, 200)   -- smallexpansion
SpawnResourceField (1531 , 3606, 1, 200)   -- small expansion
SpawnResourceField (3479 , 1210, 1, 200)   -- small expansion
SpawnResourceField (2152 , 506, 1, 200)   -- small expansion


---coordinates go in between here---
 
return {lolfactor=95, res=res, meteorstorm_interval=120, meteorstorm_firsttime=480, meteorstorm_number=6}