SELECT name FROM 
    (
        (SELECT name FROM producer 
        WHERE movie_id=(SELECT mid FROM movie WHERE title='Edge of Night, The'))
    UNION
        (SELECT name FROM actor 
        WHERE movie_id=(SELECT mid FROM movie WHERE title='Edge of Night, The'))
    ) as contributors
ORDER BY name ASC;
LIMIT 10;
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
LIMIT 10;