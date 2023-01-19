-- EX. 1
SELECT d.department_id, d.department_name, p.project_id, p.project_name, p.location
FROM departments d
         JOIN projects p on d.department_id = p.department_id
ORDER BY department_id;

-- EX. 2
SELECT distinct e.department_id, d.manager_id, e.last_name, e.salary, e.parking_spot
FROM departments d
         JOIN employees e on d.manager_id = e.employee_id
ORDER BY department_id;

-- EX. 3
SELECT project_name, p.location, concat_ws(' ', e.first_name, e.infix, e.last_name) full_name, e.department_id
FROM projects p
         JOIN tasks t on p.project_id = t.project_id
         JOIN employees e on t.employee_id = e.employee_id
order by department_id, e.last_name;

-- EX. 4
SELECT p.project_name,
       p.location,
       concat_ws(' ', e.first_name, e.infix, e.last_name) full_name,
       e.department_id                                    "Department of Employee",
       p.department_id
FROM projects p
         JOIN tasks t on p.project_id = t.project_id
         JOIN departments d on p.department_id = d.department_id
         JOIN employees e on t.employee_id = e.employee_id
WHERE p.location = 'Eindhoven'
   OR d.department_name = 'Administration'
order by department_id, e.last_name;

-- EX. 5
SELECT distinct e.first_name, e.last_name, COUNT(p.project_name) "number of PROJECTS"
FROM employees e
         JOIN tasks t on e.employee_id = t.employee_id
         JOIN projects p on t.project_id = p.project_id
GROUP BY e.first_name, e.last_name
ORDER BY "number of PROJECTS";

-- EX. 6
SELECT concat_ws(' ', first_name, infix, last_name), fm.name, fm.gender, fm.birth_date
FROM employees
         JOIN family_members fm on employees.employee_id = fm.employee_id
WHERE relationship <> 'PARTNER'
ORDER BY birth_date;

-- EX. 7
SELECT concat_ws(' ', first_name, last_name), COUNT(fm.name)
FROM employees
         JOIN family_members fm on employees.employee_id = fm.employee_id
WHERE relationship <> 'PARTNER'
GROUP BY first_name, last_name;