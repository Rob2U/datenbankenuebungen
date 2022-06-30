WITH EoN AS (
    SELECT mid FROM movie WHERE title = 'Edge of Night, The'
), Prod AS (
    SELECT p.name as name FROM producer p, EoN e 
    WHERE e.mid = p.movie_id  
), Actor AS (
    SELECT a.name as name FROM actor a, EoN e 
    WHERE e.mid = a.movie_id  
)

-- Mengensemantik
SELECT * FROM Actor
UNION 
SELECT * FROM Prod
ORDER BY name ASC
FETCH FIRST 10 ROWS ONLY;

-- Multimengensemantik
WITH EoN AS (
    SELECT mid FROM movie WHERE title = 'Edge of Night, The'
), Prod AS (
    SELECT p.name as name FROM producer p, EoN e 
    WHERE e.mid = p.movie_id  
), Actor AS (
    SELECT a.name as name FROM actor a, EoN e 
    WHERE e.mid = a.movie_id  
)

SELECT * FROM Actor 
UNION ALL
SELECT * FROM Prod
ORDER BY name ASC
FETCH FIRST 10 ROWS ONLY;

-----

SELECT name FROM 
    (
        (SELECT name FROM producer 
        WHERE movie_id=(SELECT mid FROM movie WHERE title='Edge of Night, The'))
    UNION
        (SELECT name FROM actor 
        WHERE movie_id=(SELECT mid FROM movie WHERE title='Edge of Night, The'))
    ) as contributors
ORDER BY name ASC
FETCH FIRST 10 ROWS ONLY;
-- above is set and below is multiset
SELECT name FROM 
    (
        (SELECT name FROM producer 
        WHERE movie_id=(SELECT mid FROM movie WHERE title='Edge of Night, The'))
    UNION ALL
        (SELECT name FROM actor 
        WHERE movie_id=(SELECT mid FROM movie WHERE title='Edge of Night, The'))
    ) as contributors
ORDER BY name ASC
FETCH FIRST 10 ROWS ONLY;
