SELECT * FROM (
    SELECT Name FROM (
        Land NATURAL JOIN Geographie
    )
    EXCEPT 
    SELECT Name FROM (
        Land 
        NATURAL JOIN 
        (SELECT * FROM  Geographie as G1, 
        (SELECT urbar FROM Geographie as G2 ) as G2
        WHERE G1.urbar < G2.urbar
        )
    )
) as urbanesZeug;