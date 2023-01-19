-- EX. 1
SELECT to_char((birth_date), 'yyyy/mm/dd') "birth date"
FROM employees
UNION ALL
SELECT to_char((birth_date), 'yyyy/mm/dd') "birth date"
FROM family_members
ORDER BY "birth date";

-- EX. 2
SELECT birth_date
FROM employees
UNION
SELECT birth_date
FROM family_members;

-- EX. 3
SELECT employee_id
FROM employees
EXCEPT
SELECT employee_id
FROM family_members;

-- EX. 4
SELECT employee_id
FROM employees
EXCEPT
SELECT manager_id
FROM employees