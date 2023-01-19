-- EX. 1a - WHERE -> HAVING
SELECT *
FROM employees
GROUP BY employee_id
HAVING AVG(salary) > 30000;

-- EX. 1b - GROUP BY
SELECT employee_id, SUM(hours)
FROM tasks
GROUP BY employee_id;

-- EX. 2a
SELECT hours
FROM tasks
WHERE employee_id = '999444444';

-- EX. 2b - Fieldcount
SELECT COUNT(hours)
FROM tasks
WHERE employee_id = '999444444';

-- EX. 2c - Sum of field content
SELECT SUM(hours)
FROM tasks
WHERE employee_id = '999444444';

-- EX. 3 - Sum of salaries and fieldcount
SELECT SUM(salary)
FROM employees;

SELECT COUNT(salary)
FROM employees;

-- EX. 4 - '*' counts NULL
SELECT COUNT(*)
FROM tasks;

SELECT COUNT(hours)
FROM tasks;

-- EX. 5
SELECT COUNT(department_id) count_projects
FROM projects;

-- EX. 6
SELECT AVG(hours)
FROM tasks
WHERE project_id = 30;

-- EX. 7
SELECT COUNT(DISTINCT employee_id) employee_with_kids
FROM family_members
WHERE relationship <> 'PARTNER';

-- EX. 8
SELECT MAX(hours) "highest amount hours"
FROM tasks
WHERE project_id = 20;

-- EX. 9
SELECT MAX(birth_date) youngest_child
FROM family_members
WHERE employee_id = '999111111';

-- EX. 10
SELECT AVG(LENGTH(last_name)) "Average length last_name"
FROM employees;