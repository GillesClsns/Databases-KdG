-- EX. 1 & 2
CREATE TABLE students
(
    student_id NUMERIC(10)  NOT NULL PRIMARY KEY,
    name       VARCHAR(50)  NOT NULL,
    street     VARCHAR(100) NOT NULL,
    nr         NUMERIC(4)   NOT NULL check ( nr > 0),
    postalcode NUMERIC(4)   NOT NULL check ( postalcode > 1000 AND postalcode < 9999 ),
    city       VARCHAR(30)  NOT NULL,
    birth_date  DATE         NOT NULL check ( birth_date < CURRENT_DATE )

);

-- EX. 3 & 4
CREATE TABLE class
(
    class_id   NUMERIC(4) PRIMARY KEY,
    building   CHAR(2) CHECK ( building SIMILAR TO ('GR|PH|SW') ),
    floor      NUMERIC(1) CHECK ( floor > 0 AND floor <= 5),
    roomnumber NUMERIC(2) CHECK ( roomnumber > 0)
);

-- EX. 5 & 6
CREATE TABLE students_classes
(
    studentnumber NUMERIC(10) REFERENCES students (student_id) ON DELETE CASCADE,
    classnumber   NUMERIC(4) REFERENCES class (class_id),
    PRIMARY KEY (studentnumber, classnumber)
);





INSERT INTO students
(student_id, name, street, nr, postalcode, city, birth_date)
VALUES
    ('100', 'Albert Einstein', 'Mercer Street', 112, 8540, ' Princeton, New Jersey', '1879-03-14');

INSERT INTO classes (class_id, building, floor, roomnumber)
VALUES (1, 'GR', '1', 13);

INSERT INTO students_classes (studentnumber, classnumner)
VALUES (100, 1);



