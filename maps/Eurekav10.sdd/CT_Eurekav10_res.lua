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
SpawnResourceField (241,383, 3, 300)
SpawnResourceField (7932,790, 3, 300)
SpawnResourceField (6919,7796, 3, 300)
SpawnResourceField (690,7131, 3, 300)
SpawnResourceField (292,4168, 3, 300)
SpawnResourceField (7949,4345, 3, 300)
SpawnResourceField (3478,147, 3, 300)
SpawnResourceField (3601,7617, 3, 300)
SpawnResourceField (3212,2515, 3, 300)
SpawnResourceField (4718,5068, 3, 300)
SpawnResourceField (3399,5610, 3, 300)

SpawnResourceField (515 , 191, 2, 300)   -- starting
SpawnResourceField (238 , 632, 2, 300)   -- starting
SpawnResourceField (3124 , 255, 2, 300)   -- starting
SpawnResourceField (3788 , 255, 2, 300)   -- starting
SpawnResourceField (7509 , 206, 2, 300)   -- starting
SpawnResourceField (7901 , 398, 2, 300)   -- starting
SpawnResourceField (7813 , 3955, 2, 300)   -- starting
SpawnResourceField (7883 , 4683, 2, 300)   -- starting
SpawnResourceField (7361 , 7876, 2, 300)   -- starting
SpawnResourceField (7847 , 7830, 2, 300)   -- starting
SpawnResourceField (3274 , 7832, 2, 300)   -- starting
SpawnResourceField (4224 , 7818, 2, 300)   -- starting
SpawnResourceField (329 , 7880, 2, 300)   -- starting
SpawnResourceField (900 , 7907, 2, 300)   -- starting
SpawnResourceField (324 , 4494, 2, 300)   -- starting
SpawnResourceField (290 , 3833, 2, 300)   -- starting
SpawnResourceField (2578 , 1143, 3, 300)   -- small
SpawnResourceField (668 , 1972, 3, 300)   -- small
SpawnResourceField (5137 , 1067, 3, 300)   -- small
SpawnResourceField (7140 , 1860, 3, 300)   -- small
SpawnResourceField (5187 , 7312, 4, 300)   -- large
SpawnResourceField (7613 , 5645, 3, 300)   -- small
SpawnResourceField (495 , 5607, 3, 300)   -- small
SpawnResourceField (2274 , 3735, 3, 300)   -- small
SpawnResourceField (4996 , 2405, 3, 300)   -- small
SpawnResourceField (3923 , 4003, 3, 300)   -- small
SpawnResourceField (7112 , 2930, 3, 300)   -- small
SpawnResourceField (1800 , 6222, 3, 300)   -- more
SpawnResourceField (6342 , 5359, 3, 300)   -- more
SpawnResourceField (6215 , 3585, 3, 300)   -- more

---coordinates go in between here---
 
return {lolfactor=95, res=res, meteorstorm_interval=120, meteorstorm_firsttime=120, meteorstorm_number=6}