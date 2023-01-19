--*************************************************
-- Exercises on data- and number functions
--*************************************************

-- EX. 1
SELECT *
FROM reservations;

SELECT tano,
       houseno,
       clientno,
       to_char(start_date, 'day dd month yyyy') start_date,
       end_date - start_date                    "Aantal dagen"
FROM reservations
WHERE tano = 3
   OR houseno IS NULL AND to_char(start_date, 'YYYY') = '2020'
ORDER BY to_char(start_date, 'MM'), 5, clientno;

-- EX. 2
SELECT now();
SELECT to_char(current_date, 'dd////mm////yyyy');
SELECT date_part('dow', TIMESTAMP '2023-01-01 20:38:40');

-- EX. 3A
SELECT park_code, typeno, to_char(price_midweek / 1.21, 'L9999D99') promotion
FROM cottype_prices
WHERE season_code = 9
  AND UPPER(park_code) = 'WB';

-- EX. 3B
SELECT park_code, typeno, to_char(round((price_midweek / 1.21), 1), 'L9999D99') promotion
FROM cottype_prices
WHERE season_code = 9
  AND UPPER(park_code) = 'WB';

-- EX. 4
SELECT p.park_name,
       pr.typeno,
       s.description,
       pr.price_weekend,
       to_char((pr.price_midweek - pr.price_weekend) * 100 / pr.price_weekend, 'S99') || '%' "verschil midweek"
FROM cottype_prices pr
         JOIN parks p on p.code = pr.park_code
         JOIN seasons s on s.code = pr.season_code
WHERE lower(p.park_name) = 'erperheide'
order by s.start_date;