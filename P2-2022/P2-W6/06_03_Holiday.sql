CREATE TABLE travelagencies
(

    tano     NUMERIC(2) PRIMARY KEY,
    ta_name  VARCHAR(10) CHECK ( ta_name = UPPER(ta_name)),
    street   VARCHAR(40) CHECK ( street = UPPER(street) ),
    houseno  VARCHAR(5),
    postcode VARCHAR(6),
    city     VARCHAR(20) CHECK ( city = UPPER(city) )
);

CREATE TABLE clients
(
    clientno   VARCHAR(5) PRIMARY KEY,
    last_name  VARCHAR(25) CHECK ( last_name = UPPER(last_name) ),
    first_name VARCHAR(25) CHECK ( first_name = UPPER(first_name) ),
    street     VARCHAR(40) CHECK ( street = UPPER(street) ),
    houseno    VARCHAR(5),
    postcode   VARCHAR(6),
    city       VARCHAR(20) CHECK ( city = UPPER(city) ),
    status     VARCHAR(10)

);

CREATE TABLE countries
(
    country_code VARCHAR(3) UNIQUE PRIMARY KEY,
    country_name VARCHAR(50),
    tel_code     VARCHAR(4)
);


CREATE TABLE parks
(
    park_name    VARCHAR(15) CHECK ( park_name = UPPER(park_name) ),
    sport        VARCHAR(9) CHECK ( sport SIMILAR TO 'T|F|P|S|Q|V|K|H|A'),
    country_code VARCHAR(3) REFERENCES countries (country_code),
    code         VARCHAR(2) CHECK ( code = UPPER(code) ) PRIMARY KEY
);

CREATE TABLE seasons
(
    code        NUMERIC(2) UNIQUE PRIMARY KEY,
    description VARCHAR(30),
    start_date  DATE,
    end_date    DATE
);

CREATE TABLE parkattractiontypes
(
    attraction_code NUMERIC(4) PRIMARY KEY,
    description     VARCHAR(100)
);

CREATE TABLE parkattractions
(
    park_code       VARCHAR(2) REFERENCES parks (code),
    attraction_code NUMERIC(4) REFERENCES parkattractiontypes (attraction_code),
    PRIMARY KEY (park_code, attraction_code)
);

CREATE TABLE cottagetypes
(
    park_code    VARCHAR(2) REFERENCES parks (code),
    typeno       VARCHAR(4) CHECK ( typeno = UPPER(typeno) ) UNIQUE,
    no_bedrooms  NUMERIC(1),
    no_persons   NUMERIC(2),
    no_bathrooms NUMERIC(1),
    cot          VARCHAR(1) CHECK ( upper(cot) SIMILAR TO 'Y|N'),
    comments     VARCHAR(30),
    wifi         VARCHAR(1) CHECK ( upper(wifi) SIMILAR TO 'Y|N'),
    surface      NUMERIC(3),
    PRIMARY KEY (park_code, typeno)
);

CREATE TABLE cottages
(
    park_code  VARCHAR(2) CHECK ( park_code = UPPER(park_code) ) REFERENCES parks (code) ON DELETE CASCADE,
    typeno     VARCHAR(4) REFERENCES cottagetypes (typeno),
    houseno    NUMERIC(3) UNIQUE,
    corner     VARCHAR(1) CHECK ( corner = UPPER(corner) ),
    central    VARCHAR(1) CHECK ( central = UPPER(central) ),
    pet        VARCHAR(1) CHECK ( pet = UPPER(pet) ),
    quiet      VARCHAR(1) CHECK ( quiet = UPPER(quiet) ),
    playground VARCHAR(1) CHECK ( playground = UPPER(playground) ),
    beach      VARCHAR(1) CHECK ( beach = UPPER(beach) ),
    PRIMARY KEY (park_code, typeno, houseno)
);

CREATE TABLE reservations
(
    resno        NUMERIC(4),
    tano         NUMERIC(2) REFERENCES travelagencies (tano) ON DELETE CASCADE,
    clientno     VARCHAR(5) REFERENCES clients (clientno),
    park_code    VARCHAR(2) CHECK ( park_code = UPPER(park_code) ) REFERENCES parks (code),
    typeno       VARCHAR(5) CHECK ( typeno = UPPER(typeno) ) REFERENCES cottagetypes (typeno) ON DELETE SET NULL,
    houseno      NUMERIC(3) REFERENCES cottages (houseno),
    booking_date DATE,
    start_date   DATE,
    end_date     DATE CHECK ( end_date >= start_date ),
    reser_code   NUMERIC(1) CHECK ( reser_code IN (1, 2) ),
    status       VARCHAR(6) CHECK ( status SIMILAR TO 'OPEN|BETAALD|GESLOTEN'),
    promo_code   VARCHAR(9),
    PRIMARY KEY (resno, tano),
    CONSTRAINT fk_res_cottype FOREIGN KEY (park_code, typeNo) REFERENCES cottageTypes (park_code, typeNo) on delete set null,
    CONSTRAINT fk_res_cottage FOREIGN KEY (park_code, typeNo, houseNo) REFERENCES cottages (park_code, typeNo, houseNo) ON DELETE CASCADE
);

CREATE TABLE cottype_prices
(
    park_code       VARCHAR(2) CHECK ( park_code = UPPER(park_code) ),
    typeno          VARCHAR(4),
    season_code     NUMERIC(2) REFERENCES seasons (code),
    price_weekend   NUMERIC(5),
    price_midweek   NUMERIC(5),
    price_extra_day NUMERIC(5),
    PRIMARY KEY (park_code, typeno, season_code),
    CONSTRAINT fk_cottype_prices FOREIGN KEY (park_code, typeno) REFERENCES cottagetypes (park_code, typeno)
);

CREATE TABLE promotions
(
    promo_code VARCHAR(9) PRIMARY KEY,
    percentage NUMERIC(3, 1),
    start_date DATE,
    end_date   DATE,
    park_code  VARCHAR(2) CHECK ( park_code = UPPER(park_code) ),
    typeno     VARCHAR(4) UNIQUE,
    CONSTRAINT fk_test FOREIGN KEY (park_code, typeno) REFERENCES cottagetypes (park_code, typeno)
);

CREATE TABLE payments
(
    paymentno      NUMERIC(9) PRIMARY KEY,
    resno          NUMERIC(3),
    tano           NUMERIC(2),
    payment_date   DATE,
    amount         NUMERIC(8, 2),
    payment_method VARCHAR(1) CHECK ( payment_method SIMILAR TO ('V|M|O|B')),
    CONSTRAINT fk_test FOREIGN KEY (resno, tano) REFERENCES reservations (resno, tano)
);
