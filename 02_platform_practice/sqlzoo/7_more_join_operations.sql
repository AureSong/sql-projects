-- 来源：SQLZoo 7 More JOIN operations
-- 技术点：JOIN

-- 1
SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;

-- 4
SELECT title
FROM movie
WHERE id IN (11768, 11955, 21191);

-- 5
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 6
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 7
SELECT name
FROM actor
JOIN casting
    ON actor.id = casting.actorid
WHERE casting.movieid = 11768;

-- 8
SELECT name
FROM actor
JOIN casting 
    ON actor.id = casting.actorid
JOIN movie
    ON casting.movieid = movie.id
WHERE title = 'Alien';

-- 9
SELECT title
FROM movie
JOIN casting
    ON movie.id = casting.movieid
JOIN actor
    ON casting.actorid = actor.id
WHERE name = 'Harrison Ford';

-- 10
SELECT title
FROM movie
JOIN casting
    ON movie.id = casting.movieid
JOIN actor
    ON casting.actorid = actor.id
WHERE name = 'Harrison Ford'
    AND ord <> 1;

-- 11
SELECT title, name
FROM movie
JOIN casting
    ON movie.id = casting.movieid
JOIN actor
    ON casting.actorid = actor.id
WHERE yr = 1962
    AND ord = 1;

-- 12
SELECT yr, COUNT(DISTINCT movie.id)
FROM movie 
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE name = 'John Travolta'
    AND yr = (
        SELECT yr
        FROM movie
        JOIN casting ON movie.id = casting.movieid
        JOIN actor ON casting.actorid = actor.id
        WHERE name = 'John Travolta'
        GROUP BY yr
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
GROUP BY yr;

-- 13
SELECT DISTINCT m.title, a.name
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE c.ord = 1
    AND m.id IN (
        SELECT m2.id
        FROM movie m2
        JOIN casting c2 ON m2.id = c2.movieid
        JOIN actor a2 ON c2.actorid = a2.id
        WHERE a2.name = 'Julie Andrews'
    );

-- 14
SELECT a.name
FROM actor a 
JOIN casting c ON a.id = c.actorid
WHERE ord = 1
GROUP BY a.name
HAVING COUNT(DISTINCT c.movieid) >= 30
ORDER BY a.name;

-- 15
SELECT m.title, COUNT(c.ord)
FROM movie m
JOIN casting c ON m.id = c.movieid
WHERE m.yr = 1978
GROUP BY m.title
ORDER BY COUNT(c.ord) DESC;

-- 16
SELECT DISTINCT a.name
FROM actor a
JOIN casting c ON a.id = c.actorid
WHERE a.name <> 'Art Garfunkel'
    AND c.movieid IN (
        SELECT c2.movieid
        FROM casting c2
        JOIN actor a2 ON a2.id = c2.actorid
        WHERE a2.name = 'Art Garfunkel'
    );












