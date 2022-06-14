SELECT name, movie_id FROM producer WHERE movie_id IN
(
    SELECT mid FROM movie WHERE year=2001 
    AND mid IN   
    (SELECT movie_id FROM (
        (SELECT genre FROM genre GROUP BY genre HAVING COUNT(*) >=200)
        AS pop_genre
        JOIN 
        (SELECT movie_id,genre FROM genre) as genre
        ON pop_genre.genre = genre.genre
        ) as movies_in_pop_genre)
);