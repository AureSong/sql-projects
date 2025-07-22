-- 来源：SQLZoo 6 JOIN
-- 技术点：JOIN

-- 1
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- 2
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- 3
SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE goal.teamid = 'GER';

-- 4
SELECT team1, team2, player
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE player LIKE 'Mario%';

-- 5
SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam
ON goal.teamid = eteam.id
WHERE gtime <= 10;

-- 6
SELECT mdate, teamname
FROM game
JOIN eteam
ON game.team1 = eteam.id
WHERE coach = 'Fernando Santos';

-- 7
SELECT player
FROM game 
JOIN goal
ON game.id = goal.matchid
WHERE stadium = 'National Stadium, Warsaw';

-- 8
SELECT DISTINCT player
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE (team1 = 'GER' OR team2 = 'GER')
    AND teamid <> 'GER';

-- 9
SELECT teamname, COUNT(*)
FROM goal
JOIN eteam
ON goal.teamid = eteam.id
GROUP BY teamname;

-- 10
SELECT stadium, COUNT(*)
FROM game
JOIN goal
ON game.id = goal.matchid
GROUP BY stadium;

-- 11
SELECT matchid, mdate, COUNT(*)
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;

-- 12
SELECT matchid, mdate, COUNT(*)
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE teamid = 'GER'
GROUP BY matchid, mdate;

-- 13
SELECT 
    g.mdate,
    g.team1,
    COALESCE(SUM(CASE WHEN goal.teamid = g.team1 THEN 1 ELSE 0 END), 0) AS score1,
    g.team2,
    COALESCE(SUM(CASE WHEN goal.teamid = g.team2 THEN 1 ELSE 0 END), 0) AS score2
FROM game g
LEFT JOIN goal
  ON g.id = goal.matchid
GROUP BY g.mdate, g.id, g.team1, g.team2
ORDER BY g.mdate, g.id, g.team1, g.team2;




-- Music Tutorial
-- 1
SELECT title, artist
FROM album JOIN track
    ON album.asin = track.album
WHERE song = 'Alison';

-- 2
SELECT artist
FROM album JOIN track
    ON album.asin = track.album
WHERE song = 'Exodus';

-- 3
SELECT song
FROM album JOIN track
    ON album.asin = track.album
WHERE album.title = 'Blur';

-- 4
SELECT title, COUNT(song)
FROM album JOIN track
    ON album.asin = track.album
GROUP BY title;

-- 5
SELECT title, COUNT(song)
FROM album JOIN track
    ON album.asin = track.album
WHERE song LIKE '%Heart%'
GROUP BY title
HAVING COUNT(song) > 0;

-- 6
SELECT song
FROM album JOIN track
    ON album.asin = track.album
WHERE title = song;

-- 7
SELECT title
FROM album
WHERE title = artist;

-- 8
SELECT song, COUNT(DISTINCT asin)
FROM album JOIN track
    ON album.asin = track.album
GROUP BY song
HAVING COUNT(DISTINCT asin) > 2;

-- 9
SELECT title, price, COUNT(song)
FROM album JOIN track
    ON album.asin = track.album
GROUP BY title, price
HAVING price/COUNT(song) < 0.5;

-- 10
SELECT title, COUNT(song) AS count_song
FROM album
JOIN track
    ON album.asin = track.album
GROUP BY title, asin
ORDER BY count_song DESC;

