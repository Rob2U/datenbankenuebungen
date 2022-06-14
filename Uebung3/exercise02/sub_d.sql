SELECT * FROM ((SELECT jahr, COUNT(mid) as filmzahl FROM (SELECT max(year) as jahr FROM movie) as maxjahr, movie WHERE movie.year = jahr GROUP BY jahr)
UNION ALL
SELECT year as jahr, filmzahl FROM
(SELECT COUNT(mid) as filmzahl, year FROM movie GROUP BY year) as filmanzahl_year
WHERE filmzahl = (SELECT max(filmzahl) 
FROM (SELECT COUNT(mid) as filmzahl, year FROM movie GROUP BY year) as filmanzahl_year)
) as filmejahr;