WITH proJahr AS (
    SELECT year, COUNT(mid) AS AnzahlFilme FROM movie GROUP BY year
), maxJahr AS (
    SELECT MAX(year) as year FROM movie
), anzMaxJahr AS (
    SELECT sj.year AS Jahr, j.AnzahlFilme AS AnzahlFilme FROM maxJahr sj, proJahr j WHERE sj.year = j.year
), maxFilmeJahr AS (
    SELECT j.year, j.AnzahlFilme 
    FROM proJahr j, (SELECT MAX(AnzahlFilme) AS AnzahlFilme FROM proJahr) AS maxFilme 
    WHERE j.AnzahlFilme = maxFilme.AnzahlFilme
)

SELECT * FROM anzMaxJahr
UNION ALL
SELECT * FROM maxFilmeJahr;

--------------------

SELECT * FROM ((SELECT jahr, COUNT(mid) as filmzahl FROM (SELECT max(year) as jahr FROM movie) as maxjahr, movie WHERE movie.year = jahr GROUP BY jahr)
UNION ALL
SELECT year as jahr, filmzahl FROM
(SELECT COUNT(mid) as filmzahl, year FROM movie GROUP BY year) as filmanzahl_year
WHERE filmzahl = (SELECT max(filmzahl) 
FROM (SELECT COUNT(mid) as filmzahl, year FROM movie GROUP BY year) as filmanzahl_year)
) as filmejahr;
