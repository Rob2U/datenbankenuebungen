WITH 
    german_supp AS
    (
        SELECT s_suppkey FROM supplier, nation 
        WHERE s_nationkey = n_nationkey AND n_name = 'GERMANY'
    ), 
    part_partsupp AS
    (
        SELECT p_name, ps_suppkey, ps_partkey, ps_availqty
        FROM part, partsupp
        WHERE p_partkey = ps_partkey
    ),
    
    ps_partkey_p_name_ps_availqty AS
    (
        SELECT ps_partkey, p_name, ps_availqty
        FROM part_partsupp, german_supp
        WHERE ps_suppkey = s_suppkey
        GROUP BY ps_partkey, p_name, ps_availqty
    )
SELECT count(*) FROM (SELECT ps_partkey, p_name, SUM(ps_availqty) as Teile
FROM ps_partkey_p_name_ps_availqty
GROUP BY ps_partkey, p_name
HAVING SUM(ps_availqty) >= ((SELECT SUM(ps_availqty) FROM ps_partkey_p_name_ps_availqty)*0.00001)
ORDER BY Teile DESC)as tabelle;