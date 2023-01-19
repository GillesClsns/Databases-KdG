-------------------
-- SET OPERATORS --
-------------------

-- EX. 1A
SELECT park_code, typeno
FROM cottagetypes
EXCEPT
SELECT park_code, typeno
FROM cottages;

-- EX. 1B
SELECT code
FROM parks
EXCEPT
SELECT park_code
FROM cottagetypes;

-- EX. 1C
SELECT clientno as "customer number"
FROM clients
EXCEPT
SELECT clientno
FROM reservations
ORDER BY 1;

-- EX. 1D
SELECT city, postcode
FROM clients
INTERSECT
SELECT city, postcode
FROM travelagencies;

-- EX. 1E
SELECT city, postcode
FROM clients
UNION
SELECT city, postcode
FROM travelagencies;

-- EX. 1F
SELECT park_code, typeno, houseno
FROM cottages
WHERE park_code = 'EP'
EXCEPT
SELECT park_code, typeno, houseno
FROM reservations
ORDER BY typeno;

-- EX. 1G
SELECT attraction_code
FROM parkattractiontypes
EXCEPT
SELECT attraction_code
FROM parkattractions
ORDER BY attraction_code;

-------------------
-- Tekstfuncties --
-------------------

-- EX. 2A
SELECT *
FROM parks
WHERE (UPPER(substr(sport, 6, 1)) = 'V') AND country_code = '2'
   OR (UPPER(substr(sport, 4, 1)) = 'S')
ORDER BY country_code, park_name;

-- EX. 2B.
-- ** Vraag: Zijn er haakjes nodig in de conditie? Leg uit.
-- ** Antwoord: Als je de AND operator eerst zette, zijn geen haakjes nodig, omdat AND voorrang heeft op OR

-- EX. 3
SELECT park_name, sport
FROM parks
WHERE upper(sport) LIKE '_F_S___H_';

-- EX. 4
SELECT *
FROM cottages
WHERE upper(corner) = 'Y'
  AND upper(playground) = 'Y'
  AND (upper(beach) != 'Y' or beach is null);

-- EX. 5
SELECT clientno, first_name, last_name, postcode, city
FROM clients
WHERE ((upper(first_name) LIKE '%Y%' OR upper(last_name) LIKE '%Y%')
    AND postcode = '9100')
   OR (SUBSTR(city, 1, 1) BETWEEN 'A' AND 'D');

-- EX. 6
SELECT *
FROM cottype_prices
WHERE price_midweek < 250
  AND length(typeno) = 3
  AND season_code = 1;

-- EX. 7
SELECT DISTINCT last_name, LENGTH(last_name)
FROM clients
WHERE UPPER(last_name) LIKE '_O%'
ORDER BY LENGTH(last_name);

-- EX. 8
SELECT first_name, street
FROM clients
WHERE upper(first_name) LIKE '%Y'
  AND upper(substr(street, 1, 1)) BETWEEN 'A' AND 'M';

-- EX. 9
SELECT code, LENGTH(REPLACE(sport, ' ', '')) "# sports"
FROM parks;

-- EX. 10A
SELECT first_name, last_name, street
FROM clients
WHERE lower(street) NOT LIKE '%straat';

-- EX. 10B
SELECT first_name, last_name, Initcap(street) as street
FROM clients
WHERE lower(street) NOT LIKE '%straat';

-- EX. 10C
SELECT DISTINCT CONCAT(RPAD(first_name || ' ' || last_name, 25, '.'),
                       LPAD(street || houseno, 25, '.')) as "Name and street"
FROM clients
ORDER BY 1;


----------------------------
-- Conditionele functies  --
----------------------------

-- EX. 11
SELECT c.TYPENO,
       c.houseno,
       nullif(corner, 'N')  corner,
       nullif(central, 'N') central,
       nullif(quiet, 'N')   quiet
FROM cottages c
WHERE park_code = 'BF';

-- EX. 12A
SELECT houseno,
       case WHEN cast(corner as text) = 'Y' THEN 'Located on corner. ' else '' end ||
       case WHEN cast(central as text) = 'Y' THEN 'Centrally located. ' else '' end ||
       case WHEN cast(quiet as text) = 'Y' THEN 'Quiet environment.' else '' end
           as location
FROM cottages
WHERE park_code = 'BF'
order by houseno;

-- EX. 12B
SELECT houseno,
       coalesce(case
                    WHEN cast(corner as text) = 'Y' THEN 'Located on corner. '
                    WHEN cast(central as text) = 'Y' THEN 'Centrally located. '
                    WHEN cast(quiet as text) = 'Y' THEN 'Quiet environment.'
           END) as location
FROM cottages
WHERE park_code = 'BF'
order by houseno;

-- EX. 13
SELECT park_code,
       typeno,
       CASE
           WHEN price_extra_day BETWEEN 51 AND 69
               THEN 'Cheap'
           WHEN price_extra_day BETWEEN 45 AND 50
               THEN 'Very Cheap'
           WHEN price_extra_day < 45
               THEN 'Dirt Cheap'
           END price_extra_day
FROM cottype_prices
WHERE price_extra_day < 70
  AND season_code = '1';

-- EX. 14
SELECT typeno,
       round(price_extra_day * 0.9)                                                 dag,
       round(price_weekend / 3)                                                     weekend,
       round(price_midweek / 2)                                                     midweek,
       round(least(price_extra_day * 0.9, price_weekend / 3, price_midweek / 2)) as "Best promotion"
FROM cottype_prices
WHERE season_code = 1
  AND park_code = 'WB';