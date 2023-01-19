-- << NOT MY EXERCISES >>
-- EX. 3A
SELECT *
FROM pg_indexes;

-- EX. 3B
SELECT *
FROM pg_indexes
WHERE schemaname = 'lesW10'
  AND tablename = 'employees';

-- EX. 4A
SELECT *
FROM employees
WHERE department_id = 3;

-- EX. 4B
explain analyse
SELECT *
FROM employees
WHERE department_id = 3;

-- EX. 5
create index idx_department_id on departments (department_id)

explain analyse
SELECT *
FROM employees
WHERE department_id = 3;

--TIP: Je kan ook sequentieel scannen (= full range scan) ook uitzetten door gebruik te maken van volgende statement:
SET enable_seqscan TO off;
set enable_bitmapscan to off;

SET enable_seqscan TO on;
set enable_bitmapscan to on;


-- EX. 6
explain analyse
SELECT *
FROM tasks
WHERE project_id = 2;

explain analyse
SELECT *
FROM tasks
WHERE project_id = 2;

-- bit heap scan
-- EX. 7
EXPLAIN
SELECT DISTINCT e.first_name, e.last_name
FROM employees e
         JOIN tasks t ON (e.employee_id = t.employee_id)
         JOIN projects p ON (t.project_id = p.project_id)
WHERE lower(p.location) LIKE '%e%'
  AND parking_spot IS NOT NULL;

