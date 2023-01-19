-- OEF. 1A
SELECT first_name || ' ' || last_name as naam
FROM employees;

-- OEF. 1B
SELECT concat(first_name, ' ', last_name) as naam
FROM employees;

-- OEF. 1C
SELECT concat(first_name, lpad(last_name, length(last_name) + 1))
FROM employees;

-- OEF. 2
SELECT RPAD(REPLACE(lower(street), 'z', ''), 30, '*')
FROM employees;

-- OEF. 3
SELECT first_name, last_name
FROM employees
WHERE first_name ~ 'o'
  AND last_name ~ 'o';

-- OEF. 4
SELECT last_name
FROM employees
WHERE last_name ~ 'oo';