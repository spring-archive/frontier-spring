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
SpawnResourceField (821 , 140, 3, 300)   -- starter
SpawnResourceField (471 , 220, 3, 300)   -- starter
SpawnResourceField (306 , 462, 3, 300)   -- starter
SpawnResourceField (7682 , 7539, 3, 300)   -- starter
SpawnResourceField (7631 , 7850, 3, 300)   -- starter
SpawnResourceField (7298 , 7992, 3, 300)   -- starter
SpawnResourceField (7362 , 138, 3, 300)   -- starter
SpawnResourceField (7908 , 144, 3, 300)   -- starter
SpawnResourceField (7977 , 695, 3, 300)   -- starter
SpawnResourceField (201 , 7265, 3, 300)   -- starter
SpawnResourceField (262 , 7803, 3, 300)   -- starter
SpawnResourceField (758 , 7970, 3, 300)   -- starter
SpawnResourceField (8030 , 5261, 3, 300)   -- starter
SpawnResourceField (7643 , 5283, 3, 300)   -- starter
SpawnResourceField (7797 , 4210, 3, 300)   -- starter
SpawnResourceField (168 , 2844, 3, 300)   -- starter
SpawnResourceField (147 , 3088, 3, 300)   -- starter
SpawnResourceField (120 , 3398, 3, 300)   -- starter
SpawnResourceField (2336 , 2086, 4, 300)   -- big expansion
SpawnResourceField (3995 , 1282, 2, 300)   -- small expansion
SpawnResourceField (4464 , 4978, 4, 300)   -- big expansion
SpawnResourceField (5727 , 6330, 3, 300)   -- medium expansion
SpawnResourceField (2161 , 838, 3, 300)   -- medium expansion
SpawnResourceField (1964 , 6312, 3, 300)   -- medium expansion
SpawnResourceField (6653 , 1877, 3, 300)   -- medium expansion
SpawnResourceField (5869 , 3736, 3, 300)   -- medium expansion
SpawnResourceField (1708 , 3623, 3, 300)   -- medium expansion
SpawnResourceField (4898 , 2198, 2, 300)   -- small expansion
SpawnResourceField (4397 , 6208, 2, 300)   -- small expansion
SpawnResourceField (2916 , 2679, 2, 300)   -- small expansion
SpawnResourceField (7681 , 2670, 2, 300)   -- small expansion
SpawnResourceField (341 , 5925, 2, 300)   -- small expansion
SpawnResourceField (1359 , 2141, 2, 300)   -- small expansion

---coordinates go in between here---
 
return {lolfactor=95, res=res, meteorstorm_interval=120, meteorstorm_firsttime=120, meteorstorm_number=6}