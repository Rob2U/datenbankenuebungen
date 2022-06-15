SELECT supp_nation, cust_nation, l_year, sum(volume) as revenue
FROM (
SELECT
n1.n_name as supp_nation,
n2.n_name as cust_nation,
EXTRACT(YEAR FROM l_shipdate) as l_year,
l_extendedprice * (1 - l_discount) as volume
FROM supplier, lineitem, orders, customer, nation n1, nation n2
WHERE
s_suppkey = l_suppkey
AND o_orderkey = l_orderkey
AND c_custkey = o_custkey
AND s_nationkey = n1.n_nationkey
AND c_nationkey = n2.n_nationkey
AND (
(n1.n_name = 'GERMANY' AND n2.n_name = 'UNITED STATES')
OR (n1.n_name = 'UNITED STATES' AND n2.n_name = 'GERMANY')
)
AND l_shipdate between date '1995-01-01' and date '1996-12-31'
) as shipping
GROUP BY supp_nation, cust_nation,
l_year
ORDER BY supp_nation, cust_nation, l_year;

/*
Gebe das Land des Lieferanten und Kunden, das Lieferjahr
und der Gesamtumsatz aller Lieferungen, wo entweder Kunde aus Deutschland und Lieferant aus den USA
oder andersherum kommen. Die Lieferung soll dabei zwischen 1995 und 1996 (inkl.) erfolgt sein.
Sortiere nach Nation Zulieferer, bei Gleichheit nach Nation Kunde, bei Gleichheit nach Jahr.
