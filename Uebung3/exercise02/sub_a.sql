SELECT * FROM
(
    (SELECT name, movie_id FROM actor WHERE name LIKE 'T%') as actor_T 
JOIN 
    movie
ON actor_T.movie_id = movie.mid) 
as actor_T_movie

WHERE actor_T_movie.movie_id IN 
(SELECT movie_id FROM genre WHERE genre='Action');
