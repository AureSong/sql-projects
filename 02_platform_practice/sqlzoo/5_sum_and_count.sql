-- 来源：SQLZoo 5 SUM and COUNT
-- 技术点：群组函数

-- 1
SELECT SUM(population)
FROM world;

-- 2
SELECT DISTINCT continent
FROM world;

-- 3
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

-- 4
SELECT COUNT(name)
FROM world
WHERE area >= 1000000;

-- 5
SELECT SUM(population)
FROM world
WHERE name IN ('France', 'Germany', 'Spain');

-- 6
SELECT continent, COUNT(name)
FROM world
GROUP BY continent;

-- 7
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- 8
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;




-- The nobel table can be used to practice more SUM and COUNT functions
-- 1
SELECT COUNT(*)
FROM nobel;

-- 2
SELECT DISTINCT subject
FROM nobel;

-- 3
SELECT COUNT(*)
FROM nobel
WHERE subject = 'Physics';

-- 4
SELECT subject, COUNT(*)
FROM nobel
GROUP BY subject;

-- 5
SELECT subject, MIN(yr)
FROM nobel
GROUP BY subject;

-- 6
SELECT subject, COUNT(*)
FROM nobel
WHERE yr = 2000
GROUP BY subject;

-- 7
SELECT subject, COUNT(DISTINCT winner)
FROM nobel
GROUP BY subject;

-- 8
SELECT subject, COUNT(DISTINCT yr)
FROM nobel
GROUP BY subject;

-- 9
SELECT yr
FROM nobel
WHERE subject = 'Physics'
GROUP BY yr
HAVING COUNT(*) = 3;

-- 10
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(*) > 1;

-- 11
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(DISTINCT subject) > 1;

-- 12
SELECT yr, subject
FROM nobel
WHERE yr >= 2000
GROUP BY yr, subject
HAVING COUNT(*) = 3;










