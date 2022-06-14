SELECT n_name, sum(l_extendedprice * (1 - l_discount)) as revenue
FROM customer, orders, lineitem, supplier, nation, region
WHERE
c_custkey = o_custkey
AND l_orderkey = o_orderkey
AND l_suppkey = s_suppkey
AND c_nationkey = s_nationkey
AND s_nationkey = n_nationkey
AND n_regionkey = r_regionkey
AND r_name = 'EUROPE'
AND o_orderdate >= date '1992-01-01'
AND o_orderdate < date '1992-01-01' + interval '1' year
GROUP BY n_name
ORDER BY revenue DESC;

-- Gebe den Gesamtumsatz pro Land der im Jahr 1992 mit Bestellungen erreicht wurde,
-- wobei nur die Bestellungen betrachtet werden, wo Kunde und Lieferant aus dem gleichen Land stammen.
-- Gleichzeitig sind nur die Länder die in Europa liegen von Interesse.