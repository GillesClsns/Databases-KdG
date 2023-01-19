-- EX. 1A
SELECT project_id
FROM tasks
WHERE hours IS NOT NULL
GROUP BY project_id
HAVING count(employee_id) >= 3;

-- EX. 1B
SELECT project_id, project_name
FROM projects
WHERE project_id IN (SELECT project_id
                     FROM tasks
                     WHERE hours IS NOT NULL
                     GROUP BY project_id
                     HAVING count(employee_id) >= 3);

-- EX. 2
SELECT employee_id, last_name
FROM employees
WHERE employee_id IN (SELECT employee_id FROM projects WHERE location = 'Eindhoven')
ORDER BY employee_id DESC;

