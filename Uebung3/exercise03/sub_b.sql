SELECT Name FROM (
    Stadt JOIN Land ON 
    Stadtname=Hauptstadt
    AND  Stadt.LandID=Land.LandID
) as capt_country
WHERE Bevoelkerung < 2*p1950 OR Bevoelkerung < 4*p2000;