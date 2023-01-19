-- EX. 1
SELECT distinct clientno
FROM reservations;

-- EX. 2
SELECT clientno " ", 'travelled on', start_date date, 'to park', park_code " "
FROM reservations
WHERE date_part('year', start_date) >= 2021
ORDER BY start_date desc
    FETCH FIRST 5 ROWS ONLY;

-- EX. 3
SELECT CURRENT_DATE "today it's";

-- EX. 4
SELECT resno, tano, clientno, end_date + 2 "extension by 2 days"
FROM reservations
WHERE park_code = 'MD';

-- EX. 5
SELECT tano, clientno, start_date, end_date
FROM reservations
WHERE tano = '3'
  AND start_date > '2020-01-01'
ORDER BY start_date;

-- EX. 6
SELECT clientno, status
FROM reservations
WHERE status = 'OPEN'
LIMIT (SELECT (COUNT(*) / 4) FROM reservations WHERE status = 'OPEN');
-- EX. 7
SELECT clientno, status
FROM reservations
WHERE status = 'PAID'
  AND start_date >= '01-07-2020';

-- EX. 8
SELECT *
FROM cottages
WHERE houseno < 12
  AND (playground = 'Y' OR corner = 'Y')
ORDER BY park_code;

-- EX. 9
SELECT park_code, typeno, price_weekend weekend, price_midweek midweek
FROM cottype_prices
WHERE price_weekend * 1.20 < price_midweek

-- EX. 10
SELECT park_name parkcode, country_code
FROM parks
WHERE country_code IN ('2', '1');

-- EX. 11
SELECT resno, park_code, typeno, houseno, status
FROM reservations
WHERE (houseno is NULL OR typeno is NULL)
  AND status SIMILAR TO 'OPEN|PAID';

-- EX. 12
SELECT *
FROM clients
WHERE postcode IN ('2060', '2100', '2640');

-- EX. 13
SELECT *
FROM clients
WHERE (houseno = '106' AND postcode = '2640')
   OR city ~ '^[A-D]';

-- EX. 14
SELECT *
FROM cottype_prices
WHERE price_midweek < 250 AND price_extra_day is NULL
   OR price_extra_day < 30;

-- EX. 15
SELECT *
FROM payments
WHERE payment_method <> 'O'
  AND payment_date < '2020-02-01';

-- EX. 16
SELECT DISTINCT last_name
FROM clients
WHERE postcode = '2640'
ORDER BY clientno;
--> clientno staat niet in select.

-- EX. 17
SELECT *
FROM cottages
WHERE park_code = 'BF'
  AND pet = 'N'
  AND (beach = 'Y' OR NULL);

-- EX. 18
SELECT upper(country_name) country
FROM countries
WHERE country_name ~ '^N'
ORDER BY 1;

-- EX. 19
SELECT last_name, first_name, street
FROM clients
WHERE street ~ 'LAAN';

DROP DATABASE "Examen-P2"
