-- EX. 1
SELECT employee_id,
       name,
       relationship,
       CASE
           WHEN date_part('year', age(birth_date)) < 18 THEN 'Child'
           ELSE 'Adult'
           END "age_category"
FROM family_members
WHERE relationship <> 'PARTNER';

-- EX. 2
SELECT REPLACE(concat_ws(' ', first_name, infix, last_name), ' ', '/')
FROM employees;

-- EX. 3A
SELECT e.employee_id,
       e.first_name,
       e.birth_date,
       CASE
           WHEN fm.relationship = 'PARTNER' then fm.name
           else 'Single'
           END partner
FROM employees e
         LEFT JOIN family_members fm
                   on e.employee_id = fm.employee_id
WHERE fm.relationship = 'PARTNER'
   OR relationship IS NULL;

-- EX. 3B
SELECT e.employee_id,
       e.first_name,
       e.birth_date,
       CASE
           WHEN fm.relationship = 'PARTNER' then fm.name
           else 'Single'
           END partner,
       CASE
           WHEN fm.relationship = 'PARTNER' then fm.birth_date
           END birth_date_partner,
       CASE
           WHEN e.birth_date > fm.birth_date then fm.name
           else e.first_name
           END first_name
FROM employees e
         LEFT JOIN family_members fm
                   on e.employee_id = fm.employee_id
WHERE fm.relationship = 'PARTNER'
   OR relationship IS NULL
ORDER BY e.first_name