-- EX. 1
SELECT typeno, price_weekend
FROM cottype_prices
WHERE park_code = 'SF'
  AND season_code = 1
  AND price_weekend > (SELECT avg(price_weekend) FROM cottype_prices)

-- EX. 2
SELECT typeno, price_weekend
FROM cottype_prices cp
         JOIN parks p ON cp.park_code = p.code
WHERE upper(p.park_name) = 'WEERTERBERGEN'
  AND price_weekend = (SELECT max(price_weekend) FROM cottype_prices);

-- EX. 3
SELECT park_name, ctp.typeno, s.description, price_midweek
FROM parks p
         JOIN cottagetypes ct ON p.code = ct.park_code
         JOIN cottype_prices ctp ON ct.typeno = ctp.typeno AND ct.park_code = ctp.park_code
         JOIN seasons s on ctp.season_code = s.code
WHERE ct.no_bedrooms = 3
  AND season_code IN (SELECT code
                      FROM seasons
                      WHERE UPPER(description) LIKE
                            'OFF%')
  AND price_midweek = (SELECT MAX(price_midweek)
                       FROM cottype_prices ctp
                                JOIN cottagetypes ct ON ctp.typeno = ct.typeno AND ct.park_code = ctp.park_code
                       WHERE ct.no_bedrooms = 3
                         AND season_code in
                             (SELECT code
                              FROM seasons
                              WHERE UPPER(description) LIKE
                                    'OFF%'));

-- EX. 4
SELECT distinct c.last_name,
                to_char(r.start_date, 'dd monthyyyy') begin,
                park_name,
                r.typeno,
                r.houseno,
                ctp.price_midweek
FROM clients c
         JOIN reservations r ON c.clientno = r.clientno
         JOIN cottype_prices ctp ON r.typeno = ctp.typeno AND r.park_code = ctp.park_code
         JOIN parks p ON p.code = r.park_code
WHERE r.end_date < current_date
  AND ctp.price_midweek =
      (SELECT MIN(price_midweek)
       FROM cottype_prices);

-- EX. 5
SELECT c.clientno, c.last_name, count(r.clientno) aantal
FROM clients c
         JOIN reservations r ON c.clientno = r.clientno
GROUP BY c.clientno, c.last_name
HAVING count(r.clientno) > (SELECT AVG(x.count_x)
                            FROM (SELECT COUNT(clientno) as count_x
                                  FROM reservations
                                  GROUP BY clientno) as x)
ORDER BY 3, 2;

-- EX. 6
SELECT park_name
FROM parks p
WHERE code IN (SELECT park_code
               FROM cottagetypes
               WHERE (park_code, typeno) NOT IN
                     (SELECT park_code, typeno
                      FROM cottages));

-- EX. 7
SELECT k.clientno, k.last_name, b.tano, ta_name
FROM reservations r
         JOIN travelagencies b ON r.tano = b.tano
         JOIN clients k ON r.clientno = k.clientno
WHERE b.tano IN
      (SELECT rb.tano
       FROM travelagencies rb
                JOIN reservations res ON res.tano = rb.tano
       GROUP BY rb.tano
       HAVING count(*) = (SELECT MAX(x.count_x)
                          FROM (SELECT COUNT(*) as count_x
                                FROM reservations
                                GROUP BY tano) as x))
GROUP BY k.clientno, k.last_name, b.tano, ta_name
ORDER BY k.clientno;

-- EX. 8
SELECT park_name
FROM parks p
         JOIN countries l ON l.country_code = p.country_code
WHERE UPPER(l.country_name) = 'NETHERLANDS'
  AND code IN (SELECT park_code
               FROM cottagetypes
               GROUP BY park_code
               HAVING COUNT(*) >= 7);

/*
 Holiday Park: Views (Copied from solutions)
 */

--EX. 1A
CREATE OR REPLACE VIEW v_reservations
AS
SELECT resno,
       tano,
       clientno,
       park_code,
       typeno,
       houseno,
       start_date,
       end_date
FROM reservations
WHERE UPPER(park_code) = 'EP';

SELECT *
FROM reservations;

-- EX. 1B
UPDATE v_reservations
SET status = 'PAID'
WHERE resno = 4
  AND tano = 2;

-- EX. 1C
DELETE
FROM v_reservations
WHERE UPPER(park_code) = 'VB';
--DML via een view is beperkt tot de rijen en kolommen
--die door de view geselecteerd worden.

-- EX. 2A
CREATE OR REPLACE VIEW v_overview_reservations
AS
SELECT r.*, c.last_name
FROM reservations r
         JOIN clients c
              ON r.clientno = c.clientno
                  AND start_date > '15-01-2020';

SELECT *
FROM v_overview_reservations;

-- EX. 2B
ALTER TABLE reservations
    DROP COLUMN booking_date;
-- Je kan deze kolom niet laten vallen omdat er andere objecten van af hangen.
-- You can't drop this column because other objects depend on it.
-- You can solve this using DROP ... CASCADE

-- EX. 2C
CREATE OR REPLACE VIEW v_overview_clients
AS
SELECT *
FROM clients;

-- EX. 2D
ALTER TABLE clients
    ADD birth_date DATE;

SELECT *
FROM v_overview_clients;
-- In de view definitie staat * (omvat alle kolommen
-- op de moment van creatie van de view en niet alle kolommen die er nadien zijn toegevoegd).
-- Oplossen door de view opnieuw aan te maken!

-- EX. 3A
CREATE OR REPLACE VIEW v_vakantiehuizen_ep
AS
SELECT c.park_code,
       c.typeno,
       c.houseno,
       ct.no_bedrooms,
       ct.no_persons,
       ct.wifi,
       ct.surface,
       c.quiet,
       c.beach
FROM cottages c
         JOIN cottagetypes ct ON c.typeno = ct.typeno AND c.park_code = ct.park_code
WHERE c.park_code = 'EP'
  AND ct.no_bedrooms > 2;

-- EX. 3B
INSERT INTO V_VAKANTIEHUIZEN_EP
VALUES ('EP', 81, 53, 3, 8, 'J', 89, 'J', 'J');

-- EX. 4A
CREATE OR REPLACE VIEW V_OVERZICHT_RESERVATIES
AS
SELECT tano, count(*) Aantal
FROM reservations
GROUP BY tano;

-- EX. 4B
UPDATE V_OVERZICHT_RESERVATIES
SET aantal = 7
WHERE tano = 1;
--lukt niet door het group by statement

-- EX. 4C
-- Omdat niet alle NOT NULL kolommen uit reservations
-- zijn opgenomen in de view-definitie.  INSERT zal nooit lukken.
