WITH anzSchauspieler AS (
    SELECT m.title, COUNT (a.name) AS anz FROM actor a, movie m WHERE movie_id = m.mid GROUP BY m.title
), anzSchauspielerinnen AS (
    SELECT m.title, COUNT (a.name) AS anz FROM actress a, movie m WHERE movie_id = m.mid GROUP BY m.title
), unionSchau AS (
    (SELECT * FROM anzSchauspieler) UNION ALL (SELECT * FROM anzSchauspielerinnen)
)

SELECT title, SUM(anz) AS AnzahlSchauspielerUndSchauspielerinnen
FROM unionSchau
GROUP BY title
ORDER BY AnzahlSchauspielerUndSchauspielerinnen DESC
FETCH FIRST 3 ROWS ONLY;

-----------------------

--fix weird syntax error in code below
SELECT title, person_count FROM
        (
            SELECT movie_id, SUM(person_count) as person_count FROM
                (                     
                    SELECT COUNT(actor.name) AS person_count, movie_id 
                    FROM actor GROUP BY movie_id
                UNION ALL
                    SELECT COUNT(actress.name) AS person_count, movie_id 
                    FROM actress GROUP BY movie_id
                ) AS person_movie_count
            GROUP BY movie_id
        ) as persons_per_movie
    JOIN movie ON persons_per_movie.movie_id = movie.mid
ORDER BY person_count DESC
FETCH FIRST 3 ROWS ONLY;
