-- EX. 1
SELECT *
FROM projects;

-- EX. 2
SELECT project_name, department_id
FROM projects;

-- EX. 3A
SELECT 'project' text, project_id, 'is handled by' text, department_id
FROM projects;

-- EX. 3B
SELECT concat_ws(' ', 'project', project_id, 'is handled by', department_id) "Projects with department"
FROM projects;

-- EX. 4
SELECT current_date - birth_date
FROM family_members;

-- EX. 5
--< Skipped >--

-- EX. 6
SELECT DISTINCT initcap(location)
FROM employees;

-- EX. 7
SELECT DISTINCT department_id, initcap(location) location
FROM employees
ORDER BY location;

-- EX. 8A
SELECT current_date date;

-- EX. 8B
SELECT 150 - (150 * 0.15) discount;

-- EX. 8C
SELECT concat_ws(' ', 'SQL', 'Data Retrieval', 'Chapter 3-4') as "Best course";

-- EX. 9
SELECT employee_id employee, name "NAME FAMILY MEMBER", relationship, gender
FROM family_members
WHERE employee_id = '999111111';

-- EX. 10
SELECT *
FROM departments
WHERE department_name ILIKE 'administration';

-- EX. 11
SELECT employee_id, last_name, location city
FROM employees
WHERE location ILIKE 'Maastricht';

-- EX. 12
SELECT employee_id, project_id, hours
FROM tasks
WHERE hours BETWEEN 20 AND 35
  AND project_id = 10;

-- EX. 13
SELECT project_id, hours
FROM tasks
WHERE employee_id = '999222222'
  AND hours < 10;

-- EX. 14
SELECT employee_id, last_name, province
FROM employees
WHERE province SIMILAR TO 'NB|GR|NB';

-- EX. 15
SELECT department_id, first_name
FROM employees
WHERE upper(first_name) SIMILAR TO 'SUZAN|MARTINA|HENK|DOUGLAS'
ORDER BY first_name;

-- EX. 16
SELECT last_name, salary, department_id
FROM employees
WHERE department_id = 7
    AND salary < 40000
   OR employee_id = '999666666';

-- EX. 17
SELECT last_name, department_id
FROM employees
WHERE lower(location) NOT SIMILAR TO 'maarssen|eindhoven';

-- EX. 18
SELECT employee_id, project_id, hours
FROM tasks
ORDER BY hours NULLS FIRST;
-- NULLS LAST for next exercise.

-- EX. 19
SELECT last_name, location, salary
FROM employees
WHERE lower(location) SIMILAR TO 'm%|o%'
  AND salary > 30000;

-- EX. 20
SELECT name
FROM family_members
WHERE date_part('year', birth_date) = 1988;