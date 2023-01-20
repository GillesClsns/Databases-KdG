-- EX. 1A
SELECT t.project_id, p.project_name
FROM tasks t
         JOIN projects p on t.project_id = p.project_id
WHERE hours IS NOT NULL
GROUP BY t.project_id, p.project_name
HAVING count(hours) >= 3;

-- EX. 1B
SELECT project_id, project_name
FROM projects
WHERE project_id IN (SELECT project_id FROM tasks WHERE hours IS NOT NULL GROUP BY project_id HAVING count(hours) >= 3);

-- EX. 2
SELECT employee_id, last_name
FROM employees
WHERE employee_id IN (SELECT employee_id
                      FROM tasks t
                               JOIN projects p on t.project_id = p.project_id
                      WHERE p.location ILIKE 'Eindhoven')
ORDER BY employee_id desc;

-- EX. 3
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (SELECT employee_id
                      FROM tasks
                      WHERE project_id = (SELECT project_id FROM projects WHERE upper(project_name) = 'ORDERMANAGEMENT')
                        AND hours > 10);

-- EX. 4
SELECT employee_id, last_name
FROM employees
WHERE employee_id IN (SELECT employee_id
                      FROM family_members
                      WHERE relationship SIMILAR TO 'DAUGHTER|SON'
                      GROUP BY employee_id
                      HAVING count(*) >= 2);

-- EX. 5
SELECT department_id, sum(salary)
FROM employees
GROUP BY department_id
ORDER BY sum(salary) DESC
    FETCH FIRST ROW ONLY;


SELECT department_id, department_name
FROM departments
WHERE department_id =
      (SELECT department_id FROM employees GROUP BY department_id ORDER BY sum(salary) DESC FETCH FIRST ROW ONLY);

-- EX. 6
SELECT *
FROM EMPLOYEES
WHERE employee_id NOT IN (SELECT manager_id
                          FROM EMPLOYEES);
-- 6.1
SELECT employee_id
FROM employees
WHERE employee_id NOT IN (SELECT DISTINCT coalesce(manager_id, '') FROM employees);

-- 6.2
SELECT employee_id
FROM employees
WHERE employee_id NOT IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id NOTNULL);

-- 6.3
SELECT e.employee_id
FROM employees e
         LEFT OUTER JOIN employees e2 ON e.employee_id = e2.manager_id
WHERE e2.employee_id IS NULL;

-- 6.4
SELECT employee_id
FROM employees e
WHERE NOT exists(SELECT 'a' FROM employees WHERE e.employee_id = employees.manager_id);

-- EX. 7
SELECT f.employee_id, e.last_name, count(relationship) aantal
FROM family_members f
         JOIN employees e ON e.employee_id = f.employee_id
WHERE lower(relationship) IN ('son', 'daughter')
  AND lower(last_name) != 'bock'
GROUP BY f.employee_id, e.employee_id
HAVING count(relationship) = (SELECT count(relationship)
                              FROM family_members
                              WHERE lower(relationship) IN ('son', 'daughter')
                                AND employee_id = (SELECT employee_id FROM employees WHERE lower(last_name) = 'bock')
                              GROUP BY employee_id);
