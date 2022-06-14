WITH ActionFilm AS (
    SELECT genre, movie_id FROM genre WHERE genre='Action'
), TSchau AS (
    SELECT movie_id, name FROM actor WHERE name LIKE 'T%'
), ActionSchau AS (
    SELECT * FROM TSchau t LEFT OUTER JOIN ActionFilm a ON t.movie_id = a.movie_id
), NoActionFilm AS (
    SELECT genre, movie_id FROM genre WHERE genre<>'Action' AND movie_id NOT IN (SELECT movie_id FROM ActionFilm)
), NoActionSchau AS (
    SELECT * FROM TSchau t LEFT OUTER JOIN NoActionFilm a ON t.movie_id = a.movie_id
)

SELECT * FROM (
    SELECT name FROM ActionSchau WHERE genre IS NOT NULL
    EXCEPT
    SELECT name FROM NoActionSchau WHERE genre IS NOT NULL
) as result ORDER BY name ASC;

--------------------

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
