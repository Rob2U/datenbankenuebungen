WITH ActionFilm AS (
    SELECT genre, movie_id FROM genre WHERE genre='Action'
), TSchau AS (
    SELECT movie_id, name FROM actor WHERE name LIKE 'T%'
), ActionSchau AS (
    SELECT * FROM TSchau t LEFT OUTER JOIN ActionFilm a ON t.movie_id = a.movie_id
)

SELECT DISTINCT name FROM ActionSchau WHERE genre IS NOT NULL ORDER BY name ASC;

----

SELECT name FROM
(
    (SELECT name, movie_id FROM actor WHERE name LIKE 'T%') as actor_T 
JOIN 
    movie
ON actor_T.movie_id = movie.mid) 
as actor_T_movie

WHERE actor_T_movie.movie_id IN 
(SELECT movie_id FROM genre WHERE genre='Action')
ORDER BY name ASC;
