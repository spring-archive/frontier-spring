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
SpawnResourceField (2671,4549, 3, 300)
SpawnResourceField (7488,4746, 3, 300)
SpawnResourceField (7472,445, 3, 300)
SpawnResourceField (2652,370, 3, 300)
SpawnResourceField (5027,227, 3, 300)
SpawnResourceField (5021,4770, 3, 300)
SpawnResourceField (354,2466, 3, 300)
SpawnResourceField (9758,2559, 3, 300)
SpawnResourceField (4546,2637, 3, 300)
SpawnResourceField (2724,2546, 3, 300)
SpawnResourceField (7415,2545, 3, 300)
SpawnResourceField (743,535, 3, 300)
SpawnResourceField (757,4463, 3, 300)
SpawnResourceField (9262,4348, 3, 300)
SpawnResourceField (9154,830, 3, 300)

SpawnResourceField (158 , 4525, 3, 300)   -- start
SpawnResourceField (534 , 4924, 3, 300)   -- start
SpawnResourceField (2355 , 4878, 3, 300)   -- start
SpawnResourceField (2823 , 4878, 3, 300)   -- start
SpawnResourceField (4651 , 4963, 3, 300)   -- start
SpawnResourceField (5442 , 4986, 3, 300)   -- start
SpawnResourceField (6955 , 4878, 3, 300)   -- start
SpawnResourceField (7869 , 4878, 3, 300)   -- start
SpawnResourceField (9252 , 4932, 3, 300)   -- start
SpawnResourceField (10058 , 4425, 3, 300)   -- start
SpawnResourceField (10028 , 2943, 3, 300)   -- start
SpawnResourceField (10052 , 2236, 3, 300)   -- start
SpawnResourceField (9968 , 830, 3, 300)   -- start
SpawnResourceField (9223 , 230, 3, 300)   -- start
SpawnResourceField (7955 , 107, 3, 300)   -- start
SpawnResourceField (7171 , 107, 3, 300)   -- start
SpawnResourceField (5534 , 69, 3, 300)   -- start
SpawnResourceField (4589 , 84, 3, 300)   -- start
SpawnResourceField (3329 , 115, 3, 300)   -- start
SpawnResourceField (2299 , 153, 3, 300)   -- start
SpawnResourceField (762 , 123, 3, 300)   -- start
SpawnResourceField (171 , 569, 3, 300)   -- start
SpawnResourceField (133 , 1890, 3, 300)   -- start
SpawnResourceField (95 , 2828, 3, 300)   -- start
SpawnResourceField (5466 , 2618, 3, 300)   -- start
SpawnResourceField (4965 , 2971, 3, 300)   -- start
SpawnResourceField (5075 , 1384, 2, 300)   -- small
SpawnResourceField (5060 , 3592, 2, 300)   -- small
SpawnResourceField (1751 , 2441, 2, 300)   -- small
SpawnResourceField (8459 , 2463, 2, 300)   -- small

---coordinates go in between here---
 
return {lolfactor=95, res=res, meteorstorm_interval=120, meteorstorm_firsttime=120, meteorstorm_number=6}