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

SpawnResourceField (1200 , 2125, 3, 300)   -- starterrocks
SpawnResourceField (1358 , 1742, 3, 300)   -- starterrocks
SpawnResourceField (1737 , 1578, 3, 300)   -- starterrocks
SpawnResourceField (5295 , 1525, 3, 300)   -- starterrocks
SpawnResourceField (5777 , 1576, 3, 300)   -- starterrocks
SpawnResourceField (5980 , 2028, 3, 300)   -- starterrocks
SpawnResourceField (3511 , 5782, 3, 300)   -- starterrocks
SpawnResourceField (3867 , 5957, 3, 300)   -- starterrocks
SpawnResourceField (4356 , 5895, 3, 300)   -- starterrocks
SpawnResourceField (6437 , 6236, 3, 300)   -- nookrocks
SpawnResourceField (6534 , 5979, 3, 300)   -- nookrocks
SpawnResourceField (3886 , 721, 3, 300)   -- nookrocks
SpawnResourceField (3307 , 717, 3, 300)   -- nookrocks
SpawnResourceField (598 , 6042, 3, 300)   -- nookrocks
SpawnResourceField (799 , 6562, 3, 300)   -- nookrocks
SpawnResourceField (3951 , 4366, 3, 300)   -- centerrocks
SpawnResourceField (3077 , 3482, 3, 300)   -- centerrocks
SpawnResourceField (4359 , 3383, 3, 300)   -- centerrocks
SpawnResourceField (4279 , 6944, 3, 300)   -- ridgerocks
SpawnResourceField (6938 , 6966, 3, 300)   -- ridgerocks
SpawnResourceField (6841 , 327, 3, 300)   -- ridgerocks
SpawnResourceField (537 , 181, 3, 300)   -- ridgerocks
SpawnResourceField (136 , 6830, 3, 300)   -- ridgerocks

SpawnResourceField (4093 , 3568, 3, 300)   -- 
SpawnResourceField (3820 , 3849, 3, 300)   -- 
SpawnResourceField (105 , 2984, 3, 300)   -- 
SpawnResourceField (98 , 3099, 3, 300)   -- 
SpawnResourceField (239 , 3029, 3, 300)   -- s:
SpawnResourceField (6936 , 2743, 3, 300)   -- 
SpawnResourceField (7097 , 2739, 3, 300)   -- 7097
SpawnResourceField (7097 , 2741, 3, 300)   -- 
SpawnResourceField (6999 , 2797, 3, 300)   -- 7001
SpawnResourceField (7001 , 2797, 3, 300)   -- 
SpawnResourceField (3506 , 91, 3, 300)   -- 
SpawnResourceField (3372 , 221, 3, 300)   -- 
SpawnResourceField (3668 , 215, 3, 300)   -- 


---coordinates go in between here---
 
return {lolfactor=95, res=res, meteorstorm_interval=120, meteorstorm_firsttime=480, meteorstorm_number=6, featurehandling="remove"}