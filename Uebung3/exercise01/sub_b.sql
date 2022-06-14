SELECT name FROM (
    producer
    LEFT OUTER JOIN 
    movie
    ON movie_id = mid
) as producer_name
WHERE title IS NULL 
ORDER BY name ASC;