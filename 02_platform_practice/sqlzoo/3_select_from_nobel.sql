-- 来源：SQLZoo 3 SELECT from Nobel
-- 技术点：SELECT + ORDER BY

-- 1
SELECT *
FROM nobel
WHERE yr = 1950;

-- 2
SELECT winner
FROM nobel
WHERE yr = 1962
    AND subject = 'Literature';

-- 3
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- 4
SELECT winner
FROM nobel
WHERE yr >= 2000
    AND subject = 'Peace';

-- 5
SELECT *
FROM nobel
WHERE (yr BETWEEN 1980 AND 1989)
    AND subject = 'Literature';

-- 6
SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter');

-- 7
SELECT winner
FROM nobel
WHERE winner LIKE 'John%';

-- 8
SELECT *
FROM nobel
WHERE (yr = 1980 AND subject = 'Physics')
    OR (yr = 1984 AND subject = 'Chemistry');

-- 9
SELECT *
FROM nobel
WHERE yr = 1980
    AND NOT subject IN ('Chemistry', 'Medicine');

-- 10
SELECT *
FROM nobel
WHERE (yr < 1910 AND subject = 'Medicine')
    OR (yr >= 2004 AND subject = 'Literature');

-- 11
SELECT *
FROM nobel
WHERE winner = 'PETER GRÜNBERG';

-- 12
SELECT *
FROM nobel
WHERE winner = 'EUGENE O''NEILL';

-- 13
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner;

-- 14
SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('Chemistry', 'Physics'), subject, winner;


