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