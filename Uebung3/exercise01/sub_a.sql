SELECT  COUNT(*) as AnzahlSchauspielerinnen FROM 
(SELECT DISTINCT name FROM actress) as actress;