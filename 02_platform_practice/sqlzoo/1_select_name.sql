-- 来源：SQLZoo 1 SELECT name
-- 技术点：SELECT + LIKE

-- 1
SELECT name
FROM world
WHERE name LIKE 'Y%';

-- 2
SELECT name
FROM world
WHERE name LIKE '%Y';

-- 3
SELECT name
FROM world
WHERE name LIKE '%x%';

-- 4
SELECT name
FROM world
WHERE name LIKE '%land';

-- 5
SELECT name
FROM world
WHERE name LIKE 'C%ia';

-- 6
SELECT name
FROM world
WHERE name LIKE '%oo%';

-- 7
SELECT name
FROM world
WHERE name LIKE '%a%a%a%';

-- 8
SELECT name
FROM world
WHERE name LIKE '_t%';

-- 9
SELECT name
FROM world
WHERE name LIKE '%o__o%';

-- 10
SELECT name
FROM world
WHERE name LIKE '____';

-- 11
SELECT name
FROM world
WHERE capital = name;

-- 12
SELECT name
FROM world
WHERE capital = CONCAT(name, ' City');

-- 13
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT('%', name, '%');

-- 14
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT(name, '%')
    AND capital <> name;

-- 15
SELECT name, REPLACE(capital, name, '')
FROM world
WHERE capital LIKE CONCAT(name, '%')
    AND capital <> name;















