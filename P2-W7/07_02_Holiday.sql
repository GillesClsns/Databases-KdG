-- EX. 1
ALTER TABLE clients
    ADD email VARCHAR(15) DEFAULT 'Unknown' NOT NULL;

-- EX. 2
ALTER TABLE cottagetypes
    DROP CONSTRAINT dom_cottype_wifi;
ALTER TABLE cottagetypes
    ADD CONSTRAINT dom_cottype_wifi CHECK ( wifi SIMILAR TO 'Y|N');

-- EX. 3
ALTER TABLE parks
    ADD CONSTRAINT ch_park_upper CHECK ( sport = upper(sport) );

-- EX. 4
ALTER TABLE promotions
    ADD CONSTRAINT ch_dates CHECK ( start_date <= end_date );

-- EX. 5
ALTER TABLE cottagetypes
    ALTER COLUMN comments SET DATA TYPE VARCHAR(40);

-- EX. 6
ALTER TABLE clients
    ALTER COLUMN email DROP NOT NULL;

-- EX. 7
ALTER TABLE reservations
    ALTER COLUMN clientno SET DATA TYPE NUMERIC(5) USING clientno::numeric(5);

-- These must be run first to work without errors
ALTER TABLE reservations
    DROP CONSTRAINT fk_res_client;
ALTER TABLE clients
    ALTER clientno SET DATA TYPE NUMERIC(5) USING clientno::numeric(5);
ALTER TABLE reservations
    ALTER clientno SET DATA TYPE NUMERIC(5) USING clientno::numeric(5);

-- EX. 8
-- COUNTRY_CODE is primaire sleutel van de tabel COUNTRIES waarnaar
-- verwezen wordt in een vreemde sleutel in tabel PARKS.

-- Solution 1:
ALTER TABLE countries
    DROP CONSTRAINT pk_countries CASCADE;
ALTER TABLE countries
    DROP COLUMN country_code;

-- Solution 2:
ALTER TABLE countries
    DROP COLUMN country_code CASCADE;

-- EX. 9
ALTER TABLE reservations
    ADD CONSTRAINT c_booking_date
        CHECK ( booking_date <= start_date),
    ADD CONSTRAINT c_houseno
        CHECK ( houseno < 200 ) NOT VALID;

-- EX. 10
ALTER TABLE reservations
    DROP CONSTRAINT fk_res_client;

ALTER TABLE reservations

    ADD CONSTRAINT fk_res_client FOREIGN KEY (clientno) REFERENCES clients
        (clientno) ON DELETE CASCADE;

-- EX. 11
ALTER TABLE cottages
    DROP CONSTRAINT dom_corner,
    DROP CONSTRAINT dom_central,
    DROP CONSTRAINT dom_pet,
    DROP CONSTRAINT dom_quiet,
    DROP CONSTRAINT dom_playground
;

ALTER TABLE cottages -- Could use AND statements as it would be more readable and efficient.
    ADD CONSTRAINT dom_corner CHECK (corner SIMILAR TO ('Y|N')),
    ADD CONSTRAINT dom_central CHECK (central SIMILAR TO ('Y|N')),
    ADD CONSTRAINT dom_pet CHECK (pet SIMILAR TO ('Y|N')),
    ADD CONSTRAINT dom_quiet CHECK (quiet SIMILAR TO ('Y|N')),
    ADD CONSTRAINT dom_playground CHECK (playground SIMILAR TO ('Y|N'))
;

-- EX. 12
DROP TABLE payments;
DROP TABLE reservations;
DROP TABLE promotions;
DROP TABLE cottages;
DROP TABLE clients;
DROP TABLE cottype_prices;
DROP TABLE cottagetypes;
DROP TABLE parkattractions;
DROP TABLE parkattractiontypes;
DROP TABLE parks;
DROP TABLE travelagencies;
DROP TABLE seasons;
DROP TABLE countries;
