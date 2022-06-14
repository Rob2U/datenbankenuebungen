SELECT name, movie_count FROM
    (
        
            SELECT COUNT(*) as movie_count, name 
            FROM actor GROUP BY name
        
        UNION ALL
        
            SELECT COUNT(*) as movie_count, name 
            FROM actress GROUP BY name 
        
    )
    AS count_actor_actress
ORDER BY movie_count DESC
LIMIT 3;
