-- EX. 1
CREATE OR REPLACE VIEW v_emp_sal_dep AS
SELECT d.department_id, sum(salary) as "Total salary cost per department"
FROM departments d
         JOIN employees e on d.department_id = e.department_id
GROUP BY d.department_id;

SELECT *
FROM v_emp_sal_dep

-- EX. 2
CREATE OR REPLACE VIEW v_emp_child AS
SELECT e.employee_id, concat_ws(' ', first_name, last_name) name_emp, e.birth_date, name
FROM employees e
         JOIN family_members fm on e.employee_id = fm.employee_id
WHERE fm.relationship <> 'PARTNER';

SELECT *
FROM v_emp_child;

-- EX. 3A
CREATE OR REPLACE VIEW v_emp_salary AS
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary desc;

SELECT *
FROM v_emp_salary;

-- EX. 3B
CREATE OR REPLACE VIEW v_emp_salary AS
SELECT employee_id, first_name, last_name, salary, department_id
FROM employees
ORDER BY salary desc;

SELECT *
FROM v_emp_salary;

-- EX. 4A
CREATE OR REPLACE VIEW v_department AS
SELECT *
FROM departments;

-- EX. 4B
ALTER TABLE departments
    ADD COLUMN dept_telnr CHAR(9)

-- EX. 4C
SELECT *
FROM v_department;
SELECT *
FROM departments;

SELECT view_definition
FROM INFORMATION_SCHEMA.views
WHERE table_name = 'v_department';

-- EX. 4D
CREATE OR REPLACE VIEW v_department AS
SELECT *
FROM departments;

-- EX. 4E
ALTER TABLE departments
    DROP COLUMN dept_telnr cascade;

-- EX. 4F
CREATE OR REPLACE VIEW v_department AS
SELECT *
FROM departments;

-- EX. 5
CREATE OR REPLACE VIEW v_emp_salary AS
SELECT employee_id, first_name, last_name, salary, department_id
FROM employees
WHERE department_id = 7
ORDER BY salary desc;

-- EX. 6
--< Look it up yourself >--

-- EX. 7
INSERT INTO v_emp_salary
VALUES ('999999999', 'Jan', 'Janssens', 35000, 3);
SELECT *
FROM v_emp_salary;

-- EX. 8
--< Look it up yourself >--

-- EX. 9
CREATE OR REPLACE VIEW v_percentage_proportion AS
SELECT employee_id,
       project_id,
       round((hours / (SELECT sum(hours) FROM tasks WHERE project_id = t.project_id GROUP BY project_id)) * 100)
FROM tasks t
ORDER BY project_id, employee_id;

SELECT * FROM v_percentage_proportion;





