WITH belGenre AS (
    SELECT genre FROM genre GROUP BY genre HAVING COUNT(movie_id) >= 200
), belFilme AS (
    SELECT g.movie_id FROM genre g, belGenre bg WHERE bg.genre = g.genre
), filmeJahr AS (
    SELECT m.mid FROM movie m, belFilme f WHERE m.mid = f.movie_id AND m.year = 2001
)

SELECT p.name FROM producer p WHERE p.movie_id IN (SELECT mid FROM filmeJahr) GROUP BY p.name; 

-----------------unten producer nicht gruppiert, mid nicht gefordert

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
