-- EX. 1
SELECT e.last_name AS "last_name JOCHEMS",
       e.location  AS "city JOCHEMS",
       e2.last_name,
       e2.location AS city
FROM employees e,
     employees e2
WHERE e.last_name = 'Jochems'
  AND e.location != e2.location
  AND e2.gender = 'M';

-- EX. 2
SELECT e.employee_id, e.last_name, e2.birth_date
FROM employees e,
     employees e2
WHERE e.employee_id <> e2.employee_id
  AND DATE_PART('mon', e.birth_date) = DATE_PART('mon', e2.birth_date)
ORDER BY DATE_PART('mon', e.birth_date);

-- EX. 3
SELECT p.project_id, p.project_name, p.location, p.department_id
FROM projects p,
     projects p1
WHERE p.project_id <> 3
  AND p1.project_id = 3
  AND p.department_id = p1.department_id;

-- EX. 4
SELECT e.last_name  AS employee,
       e1.last_name AS boss,
       e2.last_name AS uberboss
FROM employees e,
     employees e1,
     employees e2
WHERE e.manager_id = e1.employee_id
  AND e1.manager_id = e2.employee_id;