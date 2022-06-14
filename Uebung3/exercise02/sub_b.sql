SELECT name FROM 
(
        (
            (SELECT DISTINCT name FROM  actor)
            EXCEPT
            SELECT DISTINCT name FROM
            (
                (
                SELECT DISTINCT movie_id FROM genre
                EXCEPT
                SELECT movie_id FROM genre WHERE genre='Action'
                ) as not_action
                JOIN 
                (SELECT name,movie_id FROM actor) as actor
                ON not_action.movie_id = actor.movie_id
            )
        )
        EXCEPT 
        (
            SELECT actor.name FROM actor,genre 
            WHERE actor.movie_id NOT IN (SELECT movie_id FROM genre)
            ) 
) as actors_only_action
WHERE name LIKE 'T%'
ORDER BY name ASC;
