WITH filmSchauspieler AS (
    SELECT title, name FROM movie JOIN actor ON mid = movie_id
)

SELECT DISTINCT fs1.title, fs2.title FROM filmSchauspieler fs1, filmSchauspieler fs2
WHERE fs1.title < fs2.title
AND fs1.name = fs2.name
ORDER BY fs2.title
LIMIT 10;

--------------

SELECT DISTINCT title1, title2 FROM
        (SELECT actor1.movie_id AS id1, actor2.movie_id AS id2 
        FROM actor AS actor1, actor AS actor2 
        WHERE actor1.name = actor2.name 
        AND actor1.movie_id < actor2.movie_id) AS actors
    JOIN 
        (SELECT movie1.title AS title1, movie2.title AS title2, 
        movie1.mid AS mid1, movie2.mid AS mid2
        FROM movie AS movie1, movie AS movie2
        WHERE movie1.mid < movie2.mid) AS movies
    ON id1 = mid1
    AND id2 = mid2
ORDER BY title2 ASC
LIMIT 10;
