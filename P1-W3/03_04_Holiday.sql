--***************************************
-- Exercises on outer joins and auto-joins
--***************************************

-- EX. 1
SELECT p2.*
FROM parks p1
         JOIN parks p2
              ON p1.country_code = p2.country_code
WHERE UPPER(p1.park_name) = 'WEERTERBERGEN'
  AND p2.code != p1.code;

-- EX. 2
SELECT p2.park_name, p2.sport
FROM parks p1
         JOIN parks p2
              ON (p1.sport = p2.sport)
WHERE UPPER(p1.park_name) = 'FENIX'
  AND p1.code != p2.code;

-- EX. 3a
SELECT k1.last_name,
       k1.street || ' ' || k1.houseno || ' ' || k1.postcode || ' ' || k1.city adres1,
       k2.street || ' ' || k2.houseno || ' ' || k2.postcode || ' ' || k2.city adres2
FROM clients k1
         JOIN clients k2
              ON UPPER(k1.last_name) = UPPER(k2.last_name)
where k1.clientno != k2.clientno
order by k1.last_name;

-- EX. 3b
SELECT k1.last_name,
       k1.street || ' ' || k1.houseno || ' ' || k1.postcode || ' ' || k1.city adres1,
       k2.street || ' ' || k2.houseno || ' ' || k2.postcode || ' ' || k2.city adres2
FROM clients k1
         JOIN clients k2
              ON UPPER(k1.last_name) = UPPER(k2.last_name)
where k1.clientno < k2.clientno;

-- EX. 4
SELECT t2.typeno, t2.no_bedrooms
FROM cottagetypes t1
         JOIN cottagetypes t2
              ON t2.no_bedrooms > t1.no_bedrooms
WHERE t1.park_code = 'MD'
  AND t1.typeno = '31'
  AND t2.park_code = t1.park_code;

-- EX. 5
SELECT DISTINCT v1.typeno || v1.houseno huisje1, v2.typeno || v2.houseno huisje2
FROM cottages v1
         JOIN cottages v2 ON v1.park_code = v2.park_code
WHERE UPPER(v1.park_code) = 'LB'
  AND UPPER(v1.corner) = UPPER(v2.corner)
  AND UPPER(v1.quiet) = UPPER(v2.quiet)
  AND UPPER(v1.playground) = UPPER(v2.playground)
  AND UPPER(v1.typeno || v1.houseno) < UPPER(v2.typeno || v2.houseno)
ORDER BY 1;

-- EX. 6
SELECT tp2.typeno, v.houseno, to_char(tp2.price_weekend + tp2.price_midweek, 'L9999.00') weekprijs
FROM cottype_prices tp1
         JOIN cottype_prices tp2 ON tp1.park_code = tp2.park_code
         JOIN cottages v ON tp2.park_code = v.park_code AND tp2.typeno = v.typeno
WHERE tp1.park_code = 'WB'
  AND tp1.typeno = 'FC'
  AND tp1.season_code = 4
  AND tp2.season_code = 4
  AND tp1.price_weekend + tp1.price_midweek = tp2.price_weekend + tp2.price_midweek
  AND tp2.typeno != tp1.typeno;

-- EX. 7
SELECT DISTINCT k.clientno, last_name, first_name, ta_name
FROM clients k
         LEFT OUTER JOIN reservations r ON k.clientno = r.clientno
         LEFT OUTER JOIN travelagencies rb ON r.tano = rb.tano
WHERE k.postcode BETWEEN '2000' AND '2100'
ORDER BY 2;

-- EX. 8
SELECT t.typeno "type huis", COUNT(v.typeno) as aantal
FROM cottagetypes t
         LEFT OUTER JOIN cottages v ON v.typeno = t.typeno
    AND v.park_code = t.park_code
         JOIN parks ON code = t.park_code
WHERE UPPER(park_name) = 'HET VENNENBOS'
GROUP BY t.typeno
ORDER BY 1;

-- EX. 9
SELECT t.park_code, t.typeno
FROM cottagetypes t
         LEFT OUTER JOIN cottages v ON t.typeno = v.typeno
WHERE v.typeno IS NULL;

-- EX. 10
SELECT v.typeno, v.houseno
FROM cottages v
         LEFT OUTER JOIN reservations r ON r.typeno = v.typeno
    AND r.houseno = v.houseno
WHERE r.tano IS NULL
  AND v.park_code = 'SF'
ORDER BY 1, 2;