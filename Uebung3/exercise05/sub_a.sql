WITH nation_supp AS
    (
        SELECT s_suppkey, n_name FROM supplier, nation WHERE s_nationkey = n_nationkey
    ), lineitem_nation_supp AS
    (
        SELECT l_extendedprice, l_discount, l_quantity, l_partkey, EXTRACT(YEAR FROM l_shipdate) AS l_year, s_suppkey, n_name 
        FROM lineitem, nation_supp 
        WHERE lineitem.l_suppkey = s_suppkey
    ), part_partsupp AS
    (
        SELECT p_name, ps_suppkey, ps_partkey, ps_supplycost
        FROM part, partsupp
        WHERE p_partkey = ps_partkey
    ),nation_profit_year_pname AS
    (
        SELECT n_name,  ((l_extendedprice*(1-l_discount)) - (ps_supplycost * l_quantity)) AS profit, l_year, p_name
        FROM lineitem_nation_supp, part_partsupp
        WHERE lineitem_nation_supp.l_partkey = ps_partkey 
        AND lineitem_nation_supp.s_suppkey = ps_suppkey
    )

SELECT n_name,l_year, SUM(profit) FROM nation_profit_year_pname
WHERE p_name LIKE '%chocolate%'
GROUP BY n_name,l_year
ORDER BY n_name ASC, l_year DESC;