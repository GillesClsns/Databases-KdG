--***************************************
-- Exercises on inner joins
--***************************************

-- EX. 1
SELECT *
FROM reservations;
SELECT *
FROM travelagencies;

SELECT DISTINCT ta_name, start_date, end_date, to_char(r.start_date, 'YYYY'), to_char(r.end_date, 'YYYY')
FROM reservations r
         JOIN travelagencies ta ON r.tano = ta.tano
WHERE to_char(r.start_date, 'YYYY') = '2020'
  and to_char(r.end_date, 'YYYY') = '2020'
ORDER BY 1;

-- EX. 2
SELECT *
FROM parks;
SELECT *
FROM cottagetypes;

SELECT DISTINCT park_name, country_code, no_bedrooms aantal_slaapkamers, surface
FROM parks p
         JOIN cottagetypes c ON (p.code = c.park_code)
WHERE p.country_code NOT IN ('1', '6')
  AND ((no_bedrooms >= 3) OR (surface >= 80))
ORDER BY 1;

-- EX. 3
SELECT *
FROM clients;
SELECT *
FROM reservations;

SELECT DISTINCT r.tano, ta.ta_name, c.first_name, c.last_name, r.status
FROM travelagencies ta
         JOIN reservations r ON (r.tano = ta.tano)
         JOIN clients c ON (c.clientno = r.clientno)
WHERE (r.tano IN (1, 2) AND r.status = 'PAID')
   OR (r.tano = 3)
ORDER BY c.last_name ASC, r.tano DESC;

-- EX. 4
SELECT DISTINCT c.first_name || ' ' || c.last_name name, ta.ta_name
FROM reservations r
         JOIN clients c ON (c.clientno = r.clientno)
         JOIN travelagencies ta ON (r.tano = ta.tano)
WHERE UPPER(ta.ta_name) = 'NECKERMANN'
ORDER BY name;

-- Alternatief met USING
SELECT DISTINCT c.first_name || ' ' || c.last_name name, ta.ta_name
FROM reservations r
         JOIN clients c using (clientno)
         JOIN travelagencies ta using (tano)
WHERE UPPER(ta.ta_name) = 'NECKERMANN'
ORDER BY name;

-- EX. 5
SELECT *
FROM promotions;
SELECT *
FROM reservations;
SELECT *
FROM cottagetypes;
SELECT *
FROM cottype_prices;

SELECT clientno,
       r.start_date,
       r.end_date,
       round((pr.price_weekend - (pr.price_weekend * p.percentage / 100)), 2) "discounted_price"
FROM reservations r
         JOIN promotions p ON (p.promo_code = r.promo_code)
         JOIN cottagetypes ct ON (p.park_code = ct.park_code AND
                                  p.typeno = ct.typeno)
         JOIN cottype_prices pr ON (pr.park_code = ct.park_code AND
                                    pr.typeno = ct.typeno)
         JOIN seasons s ON (s.code = pr.season_code)
WHERE (r.start_date BETWEEN s.start_date AND s.end_date);