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

SpawnResourceField (110 , 86, 3, 300)   -- starterrocks
SpawnResourceField (304 , 145, 3, 300)   -- startterrocks
SpawnResourceField (104 , 322, 3, 300)   -- starterrocks
SpawnResourceField (2639 , 108, 3, 300)   -- starterrocks
SpawnResourceField (2646 , 329, 3, 300)   -- starterrocks
SpawnResourceField (2916 , 78, 3, 300)   -- starterrocks
SpawnResourceField (6927 , 101, 3, 300)   -- starterrocks
SpawnResourceField (7254 , 56, 3, 300)   -- starterrocks
SpawnResourceField (7547 , 86, 3, 300)   -- starterrocks
SpawnResourceField (9531 , 63, 3, 300)   -- starterrocks
SpawnResourceField (9923 , 56, 3, 300)   -- starterrocks
SpawnResourceField (10193 , 248, 3, 300)   -- starterrocks
SpawnResourceField (10125 , 3219, 3, 300)   -- starterrocks
SpawnResourceField (10152 , 3514, 3, 300)   -- starterrocks
SpawnResourceField (10091 , 3741, 3, 300)   -- starterrocks
SpawnResourceField (10124 , 6712, 3, 300)   -- starterrocks
SpawnResourceField (10127 , 6448, 3, 300)   -- starterrocks
SpawnResourceField (10124 , 6121, 3, 300)   -- starterrocks
SpawnResourceField (10180 , 9831, 3, 300)   -- starterrocks
SpawnResourceField (10165 , 10093, 3, 300)   -- starterrocks
SpawnResourceField (9830 , 10131, 3, 300)   -- starterrocks
SpawnResourceField (6176 , 9984, 3, 300)   -- starterrocks
SpawnResourceField (6554 , 10140, 3, 300)   -- starterrocks
SpawnResourceField (6923 , 9998, 3, 300)   -- starterrocks
SpawnResourceField (3998 , 10115, 3, 300)   -- starterrocks
SpawnResourceField (4372 , 10150, 3, 300)   -- starterrocks
SpawnResourceField (4741 , 10162, 3, 300)   -- starterrocks
SpawnResourceField (78 , 9595, 3, 300)   -- starterrocks
SpawnResourceField (97 , 10044, 3, 300)   -- starterrocks
SpawnResourceField (627 , 10126, 3, 300)   -- starterrocks
SpawnResourceField (96 , 7205, 3, 300)   -- starterrocks
SpawnResourceField (63 , 7461, 3, 300)   -- starterrocks
SpawnResourceField (115 , 7692, 3, 300)   -- starterrocks
SpawnResourceField (60 , 3073, 3, 300)   -- starterrocks
SpawnResourceField (37 , 3305, 3, 300)   -- starterrocks
SpawnResourceField (60 , 3624, 3, 300)   -- starterrocks

SpawnResourceField (1632 , 4977, 3, 300)   -- middle
SpawnResourceField (2921 , 5366, 3, 300)   -- middle
SpawnResourceField (1810 , 2480, 3, 300)   -- middle
SpawnResourceField (3950 , 2290, 3, 300)   -- middle
SpawnResourceField (5803 , 2372, 2, 300)   -- middle small
SpawnResourceField (2666 , 8170, 2, 300)   -- middle small
SpawnResourceField (5932 , 7400, 2, 300)   -- middle small
SpawnResourceField (7519 , 6044, 3, 300)   -- middle
SpawnResourceField (4353 , 6677, 3, 300)   -- middle
SpawnResourceField (6937 , 4379, 3, 300)   -- middle
SpawnResourceField (4553 , 3402, 2, 300)   -- middle small
SpawnResourceField (8327 , 7860, 2, 300)   -- middle small
SpawnResourceField (7730 , 2375, 3, 300)   -- middle

SpawnResourceField (2728 , 2591, 3, 300)   -- uptop
SpawnResourceField (5325 , 4214, 3, 300)   -- uptop
SpawnResourceField (3142 , 4558, 3, 300)   -- uptop
SpawnResourceField (3923 , 7694, 3, 300)   -- uptop
SpawnResourceField (6806 , 7596, 3, 300)   -- uptop
SpawnResourceField (7983 , 3628, 3, 300)   -- uptop

SpawnResourceField (3364 , 6661, 3, 300)   -- moar
SpawnResourceField (5049 , 5960, 3, 300)   -- moar!
SpawnResourceField (1769 , 3762, 3, 300)   -- moar
SpawnResourceField (6367 , 8617, 3, 300)   -- moar


---coordinates go in between here---
 
return {lolfactor=95, res=res, meteorstorm_interval=120, meteorstorm_firsttime=120, meteorstorm_number=6}