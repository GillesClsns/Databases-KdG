-- EX. 1
SELECT distinct 'Jochems', 'maastricht', e2.last_name, initcap(e2.location)
FROM employees e
         JOIN employees e2 on e.last_name = e2.last_name
WHERE upper(e2.location) != 'MAASTRICHT'
  and e2.gender = 'M';

-- EX. 2
SELECT e.employee_id, e.last_name, e.birth_date
FROM employees e
         JOIN employees e2 on e.birth_date <> e2.birth_date
WHERE date_part('month', e2.birth_date) = date_part('month', e.birth_date)
ORDER BY date_part('month', e2.birth_date);

-- EX. 3
SELECT p.project_id, p.project_name, p.location, p.department_id
FROM projects p
         JOIN projects p1 on p.department_id = p1.department_id;
