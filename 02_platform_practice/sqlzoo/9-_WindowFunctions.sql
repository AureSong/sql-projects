-- 来源：SQLZoo 9- Window Funcitons
-- 技术点：窗口函数

-- 1
SELECT lastname, party, votes
FROM ge
WHERE constituency = 'S14000024' 
    AND yr = 2017
ORDER BY votes DESC;

-- 2
SELECT party, votes,
    RANK() OVER (ORDER BY votes DESC) AS rank_num
FROM ge
WHERE constituency = 'S14000024' 
    AND yr = 2017
ORDER BY votes DESC;
    
    
-- 3
SELECT yr, party, votes,
    RANK() OVER (PARTITION BY yr ORDER BY votes DESC) AS party_rank
FROM ge
WHERE constituency = 'S14000021'
ORDER BY yr, party_rank;

-- 4
SELECT constituency, party, votes,
    RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS constituency_rank
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
    AND yr = 2017
ORDER BY constituency_rank, constituency;

-- 5
SELECT constituency, party
FROM (
    SELECT constituency, party, votes,
        RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS constituency_rank
    FROM ge
    WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
        AND yr = 2017
) AS ge2
WHERE ge2.constituency_rank = 1
ORDER BY constituency;


-- 6
SELECT party, COUNT(*) AS seats_won
FROM (
    SELECT constituency, party,
        RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS rnk
    FROM ge
    WHERE yr = 2017
        AND constituency LIKE 'S%'
    ) AS ranked
WHERE rnk = 1
GROUP BY party
ORDER BY seats_won DESC;





