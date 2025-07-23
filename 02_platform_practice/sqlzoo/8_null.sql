-- 来源：SQLZoo 8 NULL
-- 技术点：NULL、COALESCE

-- Using NULL
-- 1
SELECT name
FROM teacher
WHERE dept IS NULL;

-- 2
-- 不需要做

-- 3
SELECT t.name, d.name
FROM teacher t 
LEFT JOIN dept d 
    ON t.dept = d.id;

-- 4
SELECT t.name, d.name
FROM teacher t
RIGHT JOIN dept d
    ON t.dept = d.id;

-- 5
SELECT name, COALESCE(mobile, '07986 444 2266') AS mob
FROM teacher;

-- 6
SELECT t.name, COALESCE(d.name, 'None') AS d_name
FROM teacher t
LEFT JOIN dept d
    ON t.dept = d.id;

-- 7
SELECT COUNT(teacher), COUNT(mobile)
FROM teacher;

-- 8
SELECT d.name, COUNT(t.name)
FROM teacher t
RIGHT JOIN dept d ON t.dept = d.id
GROUP BY d.name;

-- 9
SELECT name, 
    CASE
        WHEN dept IN (1, 2) THEN 'Sci'
        ELSE 'Art'
    END AS followed
FROM teacher;

-- 10
SELECT name, 
    CASE
        WHEN dept IN (1, 2) THEN 'Sci'
        WHEN dept = 3 THEN 'Art'
        ELSE 'None'
    END AS followed
FROM teacher;





-- Scottish Parliament
-- 1
SELECT name
FROM msp
WHERE party IS NULL;

-- 2
SELECT name, leader
FROM party;

-- 3
SELECT name, leader
FROM party
WHERE leader IS NULL;

-- 4
SELECT DISTINCT p.name
FROM party p
JOIN msp m ON p.code = m.party
WHERE m.name IS NOT NULL;

-- 5
SELECT m.name, p.name
FROM msp m
LEFT JOIN party p ON m.party = p.code
ORDER BY m.name;

-- 6
SELECT COALESCE(p.name, 'Unknown') AS party_name, 
    COUNT(m.name) AS member_count
FROM msp m
LEFT JOIN party p ON m.party = p.code
GROUP BY p.name;

-- 7
SELECT p.name, COUNT(m.name)
FROM msp m
RIGHT JOIN party p ON m.party = p.code
GROUP BY p.name;

