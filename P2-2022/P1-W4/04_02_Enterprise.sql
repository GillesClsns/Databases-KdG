-- EX. 1
SELECT last_name, first_name, t.project_id
FROM employees e
         LEFT JOIN tasks t on t.employee_id = e.employee_id
ORDER BY last_name;

-- EX. 2
SELECT last_name, first_name
FROM employees e
         LEFT JOIN tasks t on t.employee_id = e.employee_id
WHERE project_id IS NULL;

-- EX. 3
SELECT first_name, last_name, COUNT(DISTINCT t.project_id)
FROM employees e
         LEFT JOIN tasks t on t.employee_id = e.employee_id
GROUP BY first_name, last_name
ORDER BY last_name;

-- EX. 4
SELECT department_name, project_name, location
FROM departments
         LEFT JOIN projects p on departments.department_id = p.department_id;

-- EX. 5
SELECT e.employee_id, last_name, department_name, name family_member
FROM employees e
         LEFT JOIN departments d on e.department_id = d.department_id
         LEFT JOIN family_members fm on e.employee_id = fm.employee_id
ORDER BY last_name;

-- EX. 6
SELECT last_name, first_name, project_name, hours
FROM employees
         LEFT JOIN projects p on employees.location = p.location
         LEFT JOIN tasks t on employees.employee_id = t.employee_id AND t.project_id <> p.project_id
GROUP BY last_name, first_name, project_name, hours
ORDER BY project_name;

-- EX. 7
SELECT DISTINCT e.employee_id, e.last_name
FROM employees e
WHERE e.employee_id NOT IN
      (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL)
ORDER BY e.last_name;

SELECT DISTINCT e.employee_id, e.last_name
FROM employees e
         RIGHT JOIN employees mgr ON mgr.employee_id = e.manager_id
WHERE e.manager_id IS NOT NULL
ORDER BY e.last_name;


-- EX. 8
SELECT e.last_name AS "Has no manager", mgr.last_name AS "Does not manage employees"
FROM employees e
         FULL JOIN employees mgr ON mgr.employee_id = e.manager_id
WHERE e.department_id IS NULL
   OR mgr.employee_id IS NULL
ORDER BY 1;

SELECT hnm.last_name AS "Has no manager", dnme.last_name AS "Does not manage employees"
FROM (SELECT employee_id, last_name
      FROM employees
      WHERE employee_id NOT IN (SELECT DISTINCT manager_id
                                FROM employees
                                WHERE manager_id IS NOT NULL)) dnme

         FULL JOIN (SELECT employee_id, last_name FROM employees WHERE manager_id IS NULL) hnm
                   ON hnm.employee_id = dnme.employee_id;