-- 来源：SQLZoo 4 SELECT within SELECT
-- 技术点：SELECT + Subquary

-- 1
SELECT name
FROM world
WHERE population > (
    SELECT population
    FROM world
    WHERE name = 'Russia'
);

-- 2
SELECT name, gdp/population
FROM world
WHERE continent = 'Europe'
    AND gdp/population > (
        SELECT gdp/population
        FROM world
        WHERE name = 'United Kingdom'
    );

-- 3
SELECT name, continent
FROM world
WHERE continent IN (
    SELECT continent
    FROM world
    WHERE name IN ('Argentina', 'Australia')
)
ORDER BY name;

-- 4
SELECT name, population
FROM world
WHERE population > (
    SELECT population
    FROM world
    WHERE name = 'Canada')
AND population < (
    SELECT population 
    FROM world
    WHERE name = 'Poland');

-- 5
SELECT name,
    CONCAT( ROUND(population/(
        SELECT population
        FROM world
        WHERE name = 'Germany') * 100, 0), '%')
        AS pop_percent
FROM world
WHERE continent = 'Europe';

-- 6
SELECT name
FROM world
WHERE gdp > ALL(
   SELECT gdp
   FROM world
   WHERE continent = 'Europe' 
       AND gdp >0
);

-- 7
SELECT continent, name, area
FROM world
WHERE (continent, area) IN (
    SELECT continent, MAX(area)
    FROM world 
    WHERE area IS NOT NULL
    GROUP BY continent
);

SELECT x.continent, x.name, x.area
FROM world x
JOIN (
    SELECT continent, MAX(area) AS max_area
    FROM world
    WHERE area IS NOT NULL
    GROUP BY continent
) AS y
ON x.continent = y.continent AND x.area = y.max_area;

-- 8
SELECT continent, name
FROM world
WHERE (continent, name) IN (
    SELECT continent, MIN(name)
    FROM world
    GROUP BY continent
);

SELECT w.contiennt, w.name
FROM world w
JOIN (
    SELECT continent, MIN(name) AS min_name
    FROM world
    GROUP BY continent
) AS sub
WHERE w.continent = sub.continent AND w.name = sub.min_name;

-- 9
SELECT name, continent, population
FROM world
WHERE continent IN (
    SELECT continent
    FROM world
    GROUP BY continent
    HAVING MAX(population) <= 25000000
);

-- 10
SELECT a.name, a.continent
FROM world a
JOIN world b
ON a.continent = b.continent
    AND a.name <> b.name
WHERE a.population >= 3 * b.population
GROUP BY a.name, a.continent
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM world c
    WHERE c.continent = a,continent 
        AND c.name <> a.name);



-- The nobel table can be used to practice more subquery
-- 1
SELECT winner, yr
FROM nobel
WHERE yr IN (
    SELECT yr
    FROM nobel
    WHERE winner = 'International Committee of the Red Cross'
)
    AND subject = 'Literature';

-- 2
SELECT winner
FROM nobel
WHERE yr = (
 SELECT yr
 FROM nobel
 WHERE winner = 'Toshihide Maskawa'
)
    AND subject = 'Physics'
    AND winner <> 'Toshihide Maskawa';

-- 3
SELECT winner
FROM nobel
WHERE subject = 'Economics'
    AND yr = (
        SELECT MIN(yr)
        FROM nobel
        WHERE subject = 'Economics'
    );

-- 4
SELECT DISTINCT yr
FROM nobel n1
WHERE subject = 'Physics'
    AND NOT EXISTS (
        SELECT 1
        FROM nobel n2
        WHERE subject = 'Chemistry'
            AND n1.yr = n2.yr
    );

-- 5
SELECT yr, subject, winner
FROM nobel
WHERE yr IN (
    SELECT yr
    FROM nobel
    GROUP BY yr
    HAVING COUNT(*) > 12
);

-- 6
SELECT winner, yr, subject
FROM nobel
WHERE winner IN (
    SELECT winner
    FROM nobel
    GROUP BY winner
    HAVING COUNT(*) > 1
)
ORDER BY winner, yr;








