-- 来源：SQLZoo 9 Self Join
-- 技术点：自连接

-- 1
SELECT COUNT(id)
FROM stops;

-- 2
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 3
SELECT s.id, s.name
FROM stops s
JOIN route r ON s.id = r.stop
WHERE r.num = '4' AND r.company = 'LRT';

-- 4
SELECT company, num, COUNT(*)
FROM route
WHERE stop = 149
    OR stop = 53
GROUP BY company, num
HAVING COUNT(*) =2;

-- 5
SELECT a.company, a.num, a.stop, b.stop
FROM route a
JOIN route b 
    ON a.num = b.num 
    AND a.company = b.company
WHERE a.stop = 53 
    AND b.stop = 149;

-- 6
SELECT a.company, a.num, s1.name, s2.name
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
JOIN stops s1 ON a.stop = s1.id
JOIN stops s2 ON b.stop = s2.id
WHERE s1.name = 'Craiglockhart'
    AND s2.name = 'London Road';

-- 7
SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b
    ON a.company = b.company AND a.num = b.num
WHERE a.stop = 115
    AND b.stop = 137;

-- 8
SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
JOIN stops s1 ON a.stop =s1.id
JOIN stops s2 ON b.stop = s2.id
WHERE s1.name = 'Craiglockhart'
    AND s2.name = 'Tollcross';

-- 9
SELECT DISTINCT s2.name, r2.company, r2.num
FROM stops s1
JOIN route r1 ON s1.id = r1.stop
JOIN route r2 ON r1.company = r2.company AND r1.num = r2.num
JOIN stops s2 ON r2.stop = s2.id
WHERE s1.name = 'Craiglockhart';

-- 10
-- 方案1
WITH bus1 AS (
    SELECT r1.num, r1.company
    FROM route r1
    JOIN stops s1 ON r1.stop = s1.id
    WHERE s1.name = 'Craiglockhart'
),
    bus2 AS (
        SELECT r2.num, r2.company
        FROM route r2
        JOIN stops s2 ON r2.stop = s2.id
        WHERE s2.name = 'Sighthill'
)

SELECT DISTINCT 
    b1.num, b1.company,
    transfer.name,
    b2.num, b2.company
FROM bus1 b1
JOIN route r3 ON b1.num = r3.num AND b1.company = r3.company
JOIN stops transfer oN r3.stop= transfer.id
JOIN route r4 ON r3.stop = r4.stop
JOIN bus2 b2 ON r4.num = b2.num AND r4.company = b2.company
WHERE NOT (b1.num = b2.num AND b2.company = b2.company)
ORDER BY b1.num, b1.company, b2.num, b2.company, transfer.name;


-- 方案2
SELECT DISTINCT 
    r1.num, r1.company,
    transfer.name,
    r2.num, r2.company
FROM route r1
JOIN stops s1 ON r1.stop = s1.id
JOIN route tr1 ON r1.num = tr1.num AND r1.company = tr1.company
JOIN stops transfer ON tr1.stop = transfer.id
JOIN route tr2 ON tr1.stop = tr2.stop
JOIN route r2 ON tr2.num = r2.num AND tr2.company = r2.company
JOIN stops s2 ON r2.stop = s2.id
WHERE s1.name = 'Craiglockhart' 
    AND s2.name = 'Sighthill'
    AND NOT (r1.num = r2.num AND r1.company = r2.company)
ORDER BY r1.num, r1.company, r2.num, r2.company, transfer.name;
    











