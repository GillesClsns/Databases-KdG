CREATE TABLE "DEPARTMENTS"
(
    department_id   NUMERIC(2) PRIMARY KEY,
    department_name VARCHAR(20) NOT NULL,
    manager_id      CHAR(9),
    mgr_start_date  DATE
);

CREATE TABLE "EMPLOYEES"
(
    employee_id   CHAR(9) PRIMARY KEY,
    last_name     VARCHAR(25) NOT NULL,
    first_name    VARCHAR(25) NOT NULL,
    infix         VARCHAR(25),
    street        VARCHAR(50),
    city          VARCHAR(25),
    province      CHAR(2),
    postalcode    VARCHAR(7),
    birth_date    DATE,
    salary        NUMERIC(7, 2) CHECK ( salary <= 85000),
    parking       NUMERIC(4) UNIQUE,
    gender        VARCHAR(50) NOT NULL,
    department_id NUMERIC(2) REFERENCES "DEPARTMENTS" (department_id),
    mananager_id  CHAR(9) REFERENCES "EMPLOYEES" (employee_id)
);

CREATE TABLE "PROJECTS"
(
    project_id    NUMERIC(2) PRIMARY KEY,
    proj_name     VARCHAR(25) NOT NULL,
    location      VARCHAR(25),
    department_id NUMERIC(2) REFERENCES "DEPARTMENTS" (department_id)
);

CREATE TABLE "LOCATIONS"
(
    department_id NUMERIC(2) REFERENCES "DEPARTMENTS" (department_id),
    location      VARCHAR(20) NOT NULL,
    PRIMARY KEY (department_id, location)
);

CREATE TABLE "TASKS"
(
    employee_id CHAR(9) REFERENCES "EMPLOYEES" (employee_id),
    project_id  NUMERIC(2) REFERENCES "PROJECTS" (project_id),
    hours       NUMERIC(4, 1),
    PRIMARY KEY (employee_id, project_id)

);

CREATE TABLE "FAMILYMEMBERS"
(
    employee_id  CHAR(9) REFERENCES "EMPLOYEES" (employee_id) NOT NULL,
    name         VARCHAR(50)                                  NOT NULL,
    gender       VARCHAR(50)                                  NOT NULL,
    birth_date   DATE CHECK ( birth_date BETWEEN '1950-03-20' AND '2018-01-01'),
    relationship VARCHAR(10)                                  NOT NULL,
    PRIMARY KEY (employee_id, name)
)


