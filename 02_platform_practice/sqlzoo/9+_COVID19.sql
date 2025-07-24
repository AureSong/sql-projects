-- 来源：SQLZoo 9+ COVID 19
-- 技术点：

-- 1
SELECT name, DAY(whn), confirmed, deaths, recovered
FROM covid
WHERE name = 'Spain'
    AND YEAR(whn) = 2020
    AND MONTH(whn) = 3
ORDER BY whn;

-- 2
SELECT name, DAY(whn), confirmed,
    LAG(confirmed) OVER (PARTITION BY name ORDER BY whn) AS confirmed_lag
FROM covid
WHERE name = 'Italy'
    AND YEAR(whn) = 2020
    AND MONTH(whn) = 3
ORDER BY DAY(whn);

-- 3
SELECT name, DAY(whn),
    (confirmed - (LAG(confirmed) OVER (PARTITION BY name ORDER BY whn))) AS new_cases
FROM covid
WHERE name = 'Italy'
    AND YEAR(whn) = 2020
    AND MONTH(whn) = 3
ORDER BY whn;

-- 4
SELECT name, DATE_FORMAT(whn, '%Y-%m-%d'),
    (confirmed - (LAG(confirmed) OVER (PARTITION BY name ORDER BY whn))) AS new_cases
FROM covid
WHERE name = 'Italy'
    AND YEAR(whn) = 2020
    AND WEEKDAY(whn) = 0
ORDER BY whn;

-- 5
SELECT 
    name, 
    DATE_FORMAT(whn, '%Y-%m-%d') AS report_date,
    (confirmed - (LAG(confirmed) OVER(PARTITION BY name ORDER BY whn))) AS new_cases
FROM (
    SELECT *
    FROM covid
    WHERE WEEKDAY(whn) = 0
) AS covid2
WHERE name = 'Italy'
ORDER BY whn;

SELECT 
    tw.name, 
    DATE_FORMAT(tw.whn, '%Y-%m-%d') AS report_date,
    (tw.confirmed - lw.confirmed) AS new_cases
FROM covid tw
LEFT JOIN covid lw
    ON tw.name = lw.name
    AND lw.whn = DATE_ADD(tw.whn, INTERVAL -7 DAY)
WHERE tw.name = 'Italy'
    AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;

-- 6
SELECT 
    name,
    confirmed,
    RANK() OVER (ORDER BY confirmed DESC) AS rn1,
    deaths,
    RANK() OVER (ORDER BY deaths DESC) AS rn2
FROM covid
WHERE DATE_FORMAT(whn, '%Y-%m-%d') = '2020-04-20'
ORDER BY confirmed DESC;

-- 7
-- 答案1
SELECT name, infection_rate,
    RANK() OVER (ORDER BY infection_rate DESC) AS infection_rank
FROM (
    SELECT 
        c.name,
        ROUND(MAX(c.confirmed) / w.population * 100000, 2) AS infection_rate
    FROM covid c
    JOIN world w ON c.name = w.name
    WHERE w.population >= 10000000
    GROUP BY c.name, w.population
) AS starts
ORDER BY infection_rank;

-- 答案2
SELECT name, infection_rate,
  RANK() OVER (ORDER BY infection_rate DESC) AS infection_rank
FROM (
  SELECT 
    DISTINCT c.name,
    ROUND(
      LAST_VALUE(c.confirmed) OVER (
        PARTITION BY c.name 
        ORDER BY c.whn 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) / w.population * 100000, 2
    ) AS infection_rate
  FROM covid c
  JOIN world w ON c.name = w.name
  WHERE w.population >= 10000000
) AS t
ORDER BY infection_rank;

-- 答案3
WITH latest_confirmed AS (
  SELECT 
    c.name, 
    c.confirmed,
    w.population,
    ROW_NUMBER() OVER (
      PARTITION BY c.name 
      ORDER BY c.whn DESC
    ) AS rn
  FROM covid c
  JOIN world w ON c.name = w.name
  WHERE w.population >= 10000000
)
SELECT 
  name,
  ROUND(confirmed / population * 100000, 2) AS infection_rate,
  RANK() OVER (ORDER BY confirmed / population DESC) AS infection_rank
FROM latest_confirmed
WHERE rn = 1
ORDER BY infection_rank;






-- 8
WITH new_cases AS(
SELECT
    c.name,
    c.whn,
    (c.confirmed - c2.confirmed) AS new_cases_num,
    RANK() OVER(PARTITION BY name ORDER BY (c.confirmed - c2.confirmed) DESC) AS new_cases_rank
FROM covid c
LEFT JOIN covid c2
    ON c.name = c2.name
    AND c2.whn = DATE_ADD(c.whn, INTERVAL -1 DAY)
WHERE (c.confirmed - c2.confirmed) >= 20000
)

SELECT 
    name,
    DATE_FORMAT(whn, '%Y-%m-%d') AS peak_time,
    new_cases_num
FROM new_cases
WHERE new_cases_rank = 1;



