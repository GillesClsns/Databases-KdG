-- << NOT MY SOLUTIONS >> --
-- EX. 7
INSERT INTO departments
VALUES (2, 'Sales', '999555555', current_date);

SELECT *
FROM departments;

-- EX. 8
SELECT project_id, employee_id, hours
FROM tasks t
WHERE hours < (SELECT avg(hours)
               FROM tasks
               WHERE project_id = t.project_id)
ORDER BY 1;

-- EX. 9
SELECT manager_id, employee_id, salary
FROM employees e
WHERE salary = (SELECT max(salary)
                FROM employees
                WHERE manager_id = e.manager_id);

SELECT max(salary)
FROM employees
GROUP BY manager_id;

-- EX. 10
SELECT employee_id, first_name, last_name
FROM employees e
WHERE EXISTS(
              SELECT 'x'
              FROM employees
              WHERE e.employee_id = manager_id
          );

--EX. 11
SELECT department_id, department_name
FROM departments d
WHERE NOT exists(
        SELECT 'x'
        FROM projects
        WHERE d.department_id = department_id
    );

-- EX. 12
UPDATE employees
SET parking_spot=NULL
WHERE employee_id IN ('999666666', '999887777');

SELECT department_id
FROM employees e
WHERE NOT exists
    (
        SELECT 'x'
        FROM employees
        WHERE parking_spot NOTNULL
          AND e.department_id = department_id
    );