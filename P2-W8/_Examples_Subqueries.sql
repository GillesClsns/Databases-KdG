-- Welke medewerkers hebben het laagste salaris?
SELECT first_name, last_name
FROM employees
WHERE salary = (SELECT min(salary) FROM employees);

-- Welke employees hebben hetzelfde loon als medewerker 999555555?
-- Geef first_name en last_name
SELECT first_name, last_name, employee_id
FROM employees
WHERE employee_id != '999555555'
  AND salary = (SELECT salary FROM employees WHERE employee_id = '999555555');

-- Zelfde resultaat, maar dan met een join:
SELECT e.first_name, e.last_name, e.employee_id
FROM employees e
         JOIN employees e2 on e.salary = e2.salary
WHERE e.employee_id != '999555555'
  and e2.employee_id = '999555555';

-- Welke employees verdienen meer dan wat men gemiddeld
-- in afdeling 3 verdient? Geef emp_id, last_name en salary
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT avg(salary)
                FROM employees
                WHERE department_id = 3);

-- Welke employees werken in de afdeling production?
-- Geef employee_id en last_name
SELECT employee_id, last_name
FROM employees
WHERE employee_id IN (SELECT departments.department_id
                      FROM departments
                      WHERE upper(department_name) = 'PRODUCTION');

-- Geef een overzicht van de employees die gezinsleden hebben.
-- Geef emp_id en last_name
SELECT employee_id, last_name
FROM employees
WHERE employee_id IN (SELECT DISTINCT(employee_id) FROM family_members);

-- Geef een overzicht van de employees die geen gezinsleden hebben.
-- Geef emp_id en last_name
SELECT employee_id, last_name
FROM employees
WHERE employee_id NOT IN (SELECT DISTINCT(employee_id) FROM family_members);

-- Wie verdient er meer dan iedereen in afdeling 7?
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT max(salary)
                FROM employees
                WHERE department_id = 7);

-- Wie verdient er meer dan minstens één iemand in afdeling 7?
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 7);

-- Hoeveel familymembers hebben de werknemers?
SELECT e.employee_id, e.last_name, sq.aantal
FROM employees e,
     (SELECT employee_id, count(relationship) aantal FROM family_members GROUP BY employee_id) as sq
WHERE sq.employee_id = e.employee_id;

-- Wat is het hoogste aantal uren dat er aan elk project is gewerkt?
-- Geef telkens ook de projectnaam.
SELECT x.project_id, y.project_name, x.max_hours
FROM (SELECT project_id, max(hours) AS max_hours
      FROM tasks
      GROUP BY project_id) AS X
         JOIN projects AS y ON x.project_id = y.project_id;

-- Geef een overzicht van de werknemersnaam en hun salaris.
-- Zet ter vergelijking het gemiddelde salaris van iedereen naast deze gegevens.
SELECT employee_id, last_name, salary, (SELECT avg(salary) FROM employees as "AVG")
FROM employees;