CREATE OR REPLACE VIEW v_emp_parking_spot
AS
SELECT parking_spot, employee_id, first_name, last_name
FROM employees
ORDER BY 1;

SELECT *
FROM public.v_emp_parking_spot;

----

CREATE OR REPLACE VIEW v_dep_salary
AS
SELECT e.department_id, d.department_name, min(e.salary) min_salary, max(e.salary) max_salary
FROM departments d
         JOIN employees e on d.department_id = e.department_id
GROUP BY e.department_id, d.department_name;

SELECT *
FROM v_dep_salary

----

