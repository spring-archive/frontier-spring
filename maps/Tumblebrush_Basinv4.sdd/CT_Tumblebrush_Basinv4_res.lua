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

SpawnResourceField (219 , 579, 3, 300)   -- resource
SpawnResourceField (386 , 879, 3, 300)   -- starting
SpawnResourceField (544 , 1221, 3, 300)   -- starting
SpawnResourceField (3484 , 637, 3, 300)   -- starting
SpawnResourceField (4411 , 740, 3, 300)   -- starting
SpawnResourceField (4244 , 95, 3, 300)   -- starting
SpawnResourceField (5570 , 634, 3, 300)   -- starting
SpawnResourceField (5957 , 1058, 3, 300)   -- starting
SpawnResourceField (6541 , 562, 3, 300)   -- starting
SpawnResourceField (8043 , 1351, 3, 300)   -- starting
SpawnResourceField (7274 , 760, 3, 300)   -- starting
SpawnResourceField (7637 , 1690, 3, 300)   -- starting
SpawnResourceField (8000 , 3700, 3, 300)   -- starting
SpawnResourceField (8009 , 2735, 3, 300)   -- starting
SpawnResourceField (7365 , 3120, 3, 300)   -- starting
SpawnResourceField (6762 , 5438, 3, 300)   -- starting
SpawnResourceField (6175 , 5904, 3, 300)   -- starting
SpawnResourceField (6855 , 6557, 3, 300)   -- starting
SpawnResourceField (6639 , 7954, 3, 300)   -- starting
SpawnResourceField (6227 , 8030, 3, 300)   -- starting
SpawnResourceField (5433 , 8048, 3, 300)   -- starting
SpawnResourceField (624 , 7503, 3, 300)   -- starting
SpawnResourceField (826 , 7776, 3, 300)   -- starting
SpawnResourceField (1487 , 7406, 3, 300)   -- starting
SpawnResourceField (438 , 5846, 3, 300)   -- starting
SpawnResourceField (999 , 6309, 3, 300)   -- starting
SpawnResourceField (594 , 6663, 3, 300)   -- starting
SpawnResourceField (176 , 4707, 3, 300)   -- starting
SpawnResourceField (577 , 4470, 3, 300)   -- 577
SpawnResourceField (577 , 4471, 3, 300)   -- starting
SpawnResourceField (861 , 3752, 3, 300)   -- starting
SpawnResourceField (3037 , 3748, 3, 300)   -- middle
SpawnResourceField (2681 , 3781, 3, 300)   -- middle
SpawnResourceField (2932 , 4180, 3, 300)   -- middle
SpawnResourceField (4578 , 2749, 3, 300)   -- middle
SpawnResourceField (4777 , 3067, 3, 300)   -- middle
SpawnResourceField (4275 , 2955, 3, 300)   -- middle
SpawnResourceField (3981 , 4875, 3, 300)   -- middle
SpawnResourceField (3473 , 4712, 3, 300)   -- middle
SpawnResourceField (3720 , 5132, 3, 300)   -- middle
SpawnResourceField (2637 , 5898, 3, 300)   -- middle
SpawnResourceField (3024 , 6038, 3, 300)   -- middle
SpawnResourceField (2625 , 6276, 3, 300)   -- middle
SpawnResourceField (4846 , 5907, 3, 300)   -- middle
SpawnResourceField (4749 , 5545, 3, 300)   -- middle
SpawnResourceField (4517 , 5891, 3, 300)   -- middle
SpawnResourceField (5359 , 4083, 3, 300)   -- resource
SpawnResourceField (5890 , 4354, 3, 300)   -- resource
SpawnResourceField (5372 , 4678, 3, 300)   -- resource


---coordinates go in between here---
 
return {lolfactor=95, res=res, meteorstorm_interval=120, meteorstorm_firsttime=120, meteorstorm_number=6}