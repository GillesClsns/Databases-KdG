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
