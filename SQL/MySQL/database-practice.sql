use employees;
-- select statement

SELECT 
    first_name, last_name
FROM
    employees;
    
SELECT 
    *
FROM
    employees;
    
SELECT 
    dept_no
FROM
    departments;

SELECT 
    *
FROM
    departments;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';      -- case does not matter even inside quotes
    
-- where clause    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';  



-- and          used for conditions set on different col
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M'; 
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';
    
    
    
 -- or        mostly used for conditions set on same col
 SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        OR first_name = 'Elvis';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna';
        
        
        
-- operator precedence   AND > OR

SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');
    
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');
        
        
        
-- in          fetch duration time is reduced

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie' , 'Mark', 'Nathan');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');
    
 
 
-- like        pattern matching; % - sequence of char, _ - single char
 
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%as_');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('2000%');
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');   



-- wildcard characters *, %, _

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%jack%');    
    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%jack%');   
    
 
 
-- between and
 
SELECT 
    *
FROM
    employees
WHERE
    hire_date NOT BETWEEN '1900=01=01' AND '2000=01=01';           -- both values are exclusive
    
SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';
    
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

    
    
-- is null
 
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no IS NOT NULL;
    

    
 -- comparison operators
 
SELECT 
    *
FROM
    employees
WHERE
    hire_date < '1985-02-01';
    
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND hire_date >= '2000-01-01';
        
SELECT 
    *
FROM
    salaries
WHERE
    salary > 150000;
    
    
    
-- select distinct		-- should always come after select directly

SELECT DISTINCT
    gender
FROM
    employees;

SELECT DISTINCT
    hire_date
FROM
    employees
LIMIT 100;
    
    

-- aggregate func          return single value; ignore null values unless specified

-- count

SELECT 
    COUNT(emp_no)
FROM
    employees;               -- parenthesis must be placed right after count keyword
    
SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;               -- distinct must be placed inside count otherwise wrong output shown

SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;
    
SELECT 
    COUNT(*)
FROM
    titles
WHERE
    title = 'Manager';
 -- OR   
 SELECT 
    COUNT(*)
FROM
    dept_manager;   



-- order by    
SELECT 
    *
FROM
    employees
ORDER BY first_name , last_name DESC;

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;



-- group by           using order where, group by, order by

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;           
-- as a rule of thumb always include the field used in the group by clause in the select statement



-- alias

SELECT 
    first_name, COUNT(first_name) as names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name;
-- as keyword can be skipped

SELECT 
    salary, COUNT(salary) emps_with_same_salary
FROM
    salaries
GROUP BY salary
HAVING salary > 80000
ORDER BY salary;
-- filter salary after grouping; thus very slow!!!!!!

SELECT
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;
-- filter before grouping; thus much faster



-- having       aggregate func can be used in its conditions
-- precedence order -> where, group by, having, order by

SELECT 
    first_name, COUNT(first_name) as names_count
FROM
    employees
GROUP BY first_name
HAVING names_count > 250
ORDER BY first_name;
-- alias names can be used in having because select statement is executed before having

SELECT 
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;



-- where vs having

SELECT 
    first_name, COUNT(first_name) names_count
FROM
    employees
WHERE
    hire_date > '1990-01-01'
GROUP BY first_name
HAVING names_count < 200
ORDER BY first_name DESC;

SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;



-- limit

SELECT 
    *
FROM
    dept_emp
LIMIT 100;          -- always written at last


-- insert into values

INSERT INTO employees
(emp_no,
birth_date,
first_name,
last_name,
gender,
hire_date)
VALUES
(999901,
'1986-04-21',
'John',
'Smith',
'M',
'2011-01-01');
-- integers can be written in quotes too

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;             -- to test data a high value is inserted

INSERT INTO employees
(emp_no,
first_name,
last_name,
gender,
birth_date,
hire_date)
VALUES
(999902,
'Patricia',
'Lawrence',
'M',
'1973-03-26',
'2005-01-01');

INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC
LIMIT 10;

INSERT INTO `employees`.`titles`
(`emp_no`,
`title`,
`from_date`)
VALUES
(999903,
'Senior Engineer',
'1997-10-01');

INSERT INTO `employees`.`dept_emp`
(`emp_no`,
`dept_no`,
`from_date`,
`to_date`)
VALUES
(999903,
'd005',
'1997-10-01',
'9999-01-01');

SELECT 
    *
FROM
    employees.dept_emp
ORDER BY emp_no DESC
LIMIT 10;



-- insert into select

CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

SELECT 
    *
FROM
    departments_dup;

INSERT INTO departments_dup
SELECT 
	* 
FROM 
	departments;

INSERT INTO departments
VALUES
('d010', 
'Business Analysis');
    
    
    
-- update set where

UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999901;  
    
SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;   
    
UPDATE employees 
SET 
    first_name = 'Stella'
WHERE
    emp_no = 999909;  -- code will work since syntax is correct, but 0 rows will be affected
    
-- if where not written, all rows of the table will be affected   
-- once we execute commit changes cannot be reversed
SELECT * FROM departments_dup;
COMMIT;
UPDATE departments_dup 
SET 
    dept_name = 'Quality Control';
ROLLBACK;
COMMIT;    

UPDATE departments 
SET 
    dept_name = 'Data Analysis'
WHERE
    dept_name = 'Business Analysis';



-- delete from where

COMMIT;

DELETE FROM employees 
WHERE
    emp_no = '999903';
-- since the constraint has on delete cascade, record from both tables will be deleted

SELECT 
    *
FROM
    titles
WHERE
    emp_no = '999903';
    
ROLLBACK;

DELETE FROM departments 
WHERE
    dept_no = 'd010';
    
-- drop		can't rollback
-- truncate		delete without where, auto-increment values reset
-- delete		auto-increment values not reset
-- truncate faster than delete since not row by row        



-- aggregate func		return a single result row

-- count		applicable for both numeric and non-numeric data

SELECT 
    COUNT(from_date)
FROM
    salaries;

SELECT 
    COUNT(DISTINCT from_date)
FROM
    salaries;		-- counts distinct values
    
SELECT 
    COUNT(*)
FROM
    salaries;		-- null values will be included
-- only count doesn't ignore null values
    
SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;    
 
-- sum

SELECT 
    SUM(salary)
FROM
    salaries;

SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
-- min, max

SELECT 
    MIN(salary), MAX(salary)
FROM
    salaries;

SELECT 
    MIN(emp_no), MAX(emp_no)
FROM
    employees;

-- avg

SELECT 
    AVG(salary)
FROM
    salaries;

SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date = '1997-01-01';


-- round

SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries;

SELECT 
    ROUND(AVG(salary))
FROM
    salaries
WHERE
    from_date = '1997-01-01';
    


-- ifnull      ifnull( (if not null), (if null) )

SELECT 
    dept_no,
    IFNULL(dept_name,
            'Department name not provided') dept_name
FROM
    departments_dup;


-- coalesce		ifnull with more than 1 parameter

-- for 2 arguments ifull = coalesce

SELECT 
    dept_no,
    COALESCE(dept_name,
            'Department name not provided') dept_name
FROM
    departments_dup;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') dept_manager
FROM
    departments_dup
ORDER BY dept_no;
-- both ifnull and coalesce do not make changes in the dataset

-- coalesce can have 1 argument too

SELECT 
    dept_no,
    dept_name,
    COALESCE('Department manager name') fake_col
FROM
    departments_dup
ORDER BY dept_no;		-- used for substituting hypothetical values

SELECT 
    dept_no, dept_name, COALESCE(dept_no, dept_name) dept_info
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    IFNULL(dept_no, 'N/A') dept_no,
    IFNULL(dept_name,
            'Department name not provided') dept_name,
    COALESCE(dept_no, dept_name) dept_info
FROM
    departments_dup
ORDER BY dept_no;



-- join on		shows result set from fields joining two or more tables
-- tables need not be logically adjacent


CREATE TABLE dept_manager_dup (
    `emp_no` INT(11) NOT NULL,
    `dept_no` CHAR(4) NULL,
    `from_date` DATE NOT NULL,
    `to_date` DATE NULL
);

insert into dept_manager_dup
select * from dept_manager;

-- inner join		default join
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no;		-- related col need not have same name
-- null values are not displayed in inner join
-- related col are generally displayed in the select statement too

SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager_dup m ON e.emp_no = m.emp_no;



-- duplicate rows

# Creating duplicate rows
insert into dept_manager_dup 
values ('110228', 'd003', '1992-03-21', '9999-01-01');

insert into departments_dup 
values ('d009', 'Customer Service');

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY emp_no;
-- group by filters or removes duplicate records

# removing duplicate records
DELETE FROM dept_manager_dup 
WHERE
    emp_no = '110228';
DELETE FROM departments_dup 
WHERE
    dept_no = 'd009';

-- inserting them again
insert into dept_manager_dup 
values ('110228', 'd003', '1992-03-21', '9999-01-01');
insert into departments_dup 
values ('d009', 'Customer Service');



-- left join on 

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY emp_no
ORDER BY emp_no;
-- group by on col which differs most

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE
    dept_name IS NULL
GROUP BY emp_no
ORDER BY emp_no;

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON d.dept_no = m.dept_no
GROUP BY emp_no
ORDER BY emp_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager m ON e.emp_no = m.emp_no
WHERE
    last_name = 'Markovitch'
ORDER BY dept_no DESC , emp_no;



-- right join		seldom applied in practice

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY emp_no;
-- linking col = matching col
-- left and right joins are examples of one to many relationships
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY emp_no;		-- dept_no from right table used



-- old join syntax using where

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m,
    departments_dup d
WHERE
    m.dept_no = d.dept_no;		-- where followed by connection point
-- where clause more time consuming 
-- cannot apply left and right joins easily

SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    employees e,
    dept_manager m
WHERE
    e.emp_no = m.emp_no;

select @@global.sql_mode;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');



-- join on where 
-- good practice to add connection point and condition col in select statement

SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000;

SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch';



-- cross join		cartesian product
-- used on tables which are not well connected

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- same output using old syntax without where 
SELECT 
    dm.*, d.*
FROM
    dept_manager dm, departments d 
ORDER BY dm.emp_no , d.dept_no;

-- same output without on or where
-- not a good coding practice, always use keyword cross

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    dm.dept_no <> d.dept_no
ORDER BY dm.emp_no , d.dept_no;

-- cross join on more than 2 tables			result might be too big

SELECT 
    e.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    dm.dept_no <> d.dept_no
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_name;

SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no, d.dept_no;



-- aggregate func with joins

SELECT 
    e.gender, AVG(s.salary) as average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender;		-- do not include linking col here



-- join more than 2 tables

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no;
    
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date AS start_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Manager'
ORDER BY first_name;
		
-- tips

SELECT 
    d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary;
    
select e.gender, count(e.emp_no) as Number_Of_Managers
from 
	employees e
		join
	titles t on e.emp_no = t.emp_no
where t.title = 'Manager'
group by gender;
-- OR
SELECT
    e.gender, COUNT(m.emp_no)
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
GROUP BY gender;
    


-- union all and union		-- used to combine select statements
-- col should have same name, same col and related data types

-- union		better results, more computational power
-- union all		optimize resources
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    emp_no = '10001' 
UNION ALL SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;

SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;



-- subquery = inner query = nested query = inner select
-- inner query executed before outer query

-- where in

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            emp_no
        FROM
            dept_manager);		-- e. not required here, but good coding practice

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01=01');
            
            
-- where exists
-- checks certain row found in subquery row by row
-- if exists returns true and corresponding record of the outer query extracted

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY emp_no;		-- order by should be used in outer query by convention
-- exists		faster for retrieving large data fast
-- in		faster for retrieving small data fast

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.title = 'Assistant Engineer'
                AND t.emp_no = e.emp_no);

SELECT 
    e.*
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Assistant Engineer'
ORDER BY e.emp_no;

-- subquery in from 

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10021
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;


CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);

INSERT INTO emp_manager
SELECT
	U.*
FROM
(SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10021
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B
UNION SELECT
    C.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS C
UNION SELECT
    D.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS D) AS U;
	
SELECT 
    *
FROM
    (SELECT 
        first_name, LENGTH(first_name)
    FROM
        employees
    WHERE
        LENGTH(first_name) = (SELECT 
                MAX(LENGTH(first_name))
            FROM
                employees
            ORDER BY first_name)
    LIMIT 1) AS A 
UNION SELECT 
    *
FROM
    (SELECT 
        first_name, LENGTH(first_name)
    FROM
        employees
    WHERE
        LENGTH(first_name) = (SELECT 
                MIN(LENGTH(first_name))
            FROM
                employees
            ORDER BY first_name)
    LIMIT 1) AS B;

-- self join
-- using alias is a must

SELECT-- DISTINCT
    e2.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;

SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);

-- view		virtual table
-- data only stored in base table

SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS num
FROM
    dept_emp
GROUP BY emp_no
HAVING num > 1;

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;

CREATE OR REPLACE VIEW v__manager_avg_salary AS
    SELECT 
        ROUND(AVG(s.salary), 2) average_salary
    FROM
        dept_manager dm
            JOIN
        salaries s ON dm.emp_no = s.emp_no;
        
        
        
-- stored routines
-- 2 types		procedures and functions

-- procedures
-- insert, update, delete statements can be used in procedures unlike func

drop procedure if exists select_employees;

delimiter $$
create procedure select_employees()
begin

	SELECT * FROM employees 
    LIMIT 1000;
    
end$$
delimiter ;		-- change delimiter so that procedure doesn't end in between

call employees.select_employees();
call employees.select_employees;
call select_employees();

delimiter $$
create procedure avg_salary()
begin
	
    SELECT 
		AVG(salary)
	FROM
		salaries;
        
end$$
delimiter ;

call avg_salary();

drop procedure if exists select_employees;



-- stored procedure with input parameter
-- input represented by IN

DELIMITER $$
create procedure emp_salary(IN p_emp_no INT)
BEGIN
	SELECT 
		e.first_name, e.last_name, s.salary, s.from_date, s.to_date
	FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE
		e.emp_no = p_emp_no;
END$$
DELIMITER ;

DELIMITER $$
create procedure emp_avg_salary(IN p_emp_no INT)
BEGIN
	SELECT 
		e.first_name, e.last_name, AVG(s.salary)
	FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE
		e.emp_no = p_emp_no;
END$$
DELIMITER ;

call emp_avg_salary(11300);



-- stored procedure with output parameter
-- use select into
-- can return multiple values unlike functions

drop procedure if exists emp_avg_salary_out;
DELIMITER $$
create procedure emp_avg_salary_out(IN p_emp_no INT, OUT p_avg_salary DECIMAL(10,2), OUT p_min_salary DECIMAL(10,2))
BEGIN
	SELECT 
		AVG(s.salary)
	INTO p_avg_salary FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE
		e.emp_no = p_emp_no;
        
	SELECT 
		MIN(s.salary)
	INTO p_min_salary FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE
		e.emp_no = p_emp_no;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar(14),in p_last_name varchar(16), out p_emp_no int)
BEGIN
	SELECT 
		emp_no
	INTO p_emp_no FROM
		employees
	WHERE
		first_name = p_first_name
			AND last_name = p_last_name;
END$$
DELIMITER ;



-- variables		set @

set @v_avg_salary = 0;
call emp_avg_salary_out(11300, @v_avg_salary);
select @v_avg_salary;

set @v_emp_no = 0;
call emp_info('Aruna', "Journel", @v_emp_no);
select @v_emp_no;



-- functions
-- all parameters are in, returns keyword needed for out variables
-- we can't call func but select it
-- can return only a single value
-- insert, update, delete statements can't be used in func

DELIMITER $$
create function f_emp_avg_salary_out(p_emp_no INT) RETURNS DECIMAL(10,2)		-- no var but data type
DETERMINISTIC
BEGIN
	DECLARE v_avg_salary DECIMAL(10,2);
    
	SELECT 
		AVG(s.salary)
	INTO v_avg_salary FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE
		e.emp_no = p_emp_no;
        
	RETURN v_avg_salary;
END$$
DELIMITER ;

select f_emp_avg_salary_out(11300);

DELIMITER $$
CREATE function emp_info(p_first_name varchar(14), p_last_name varchar(16)) RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_salary DECIMAL(10,2);
    
	SELECT 
		s.salary
	INTO v_salary FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE
		first_name = p_first_name
			AND last_name = p_last_name
	HAVING MAX(from_date);
    
    RETURN v_salary;
END$$
DELIMITER ;



-- scope = visibility

-- local variables		inside begin-end statements, using declare statement

DROP FUNCTION IF EXISTS f_emp_avg_salary_out;
DELIMITER $$
create function f_emp_avg_salary_out(p_emp_no INT) RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA NO SQL 
BEGIN
	DECLARE v_avg_salary DECIMAL(10,2);
    
	BEGIN
		DECLARE v_avg_salary_2 DECIMAL(10,2);
	END;
    
	SELECT 
		AVG(s.salary)
	INTO v_avg_salary_2 FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE
		e.emp_no = p_emp_no;
        
	RETURN v_avg_salary_2;
END$$
DELIMITER ;		-- v_avg_salary_2 is out of scope

-- select v_avg_salary;		-- local variable not visible outside func



-- session variable
-- defined on a server and lives there
-- visible only to the connection being used only

SET @var_1 = 3;		-- variable written using @ and set keyword
SELECT @var_1;
-- variable not visible in new connection tab



-- global variable		apply to all connection for a server
-- system variables are set as global
-- set @@global.var = value		or		set global var = value

-- var can be defined acc to the way they have been created
-- user-defined; manually; local var
-- system; pre-defined; global var
-- session var are both as some of them are user-defined too; ex - sql mode



-- triggers 

delimiter $$
create trigger before_salaries_insert
before insert on salaries
for each row
begin
	if new.salary < 0 then
		set new.salary = 0;
	end if;
end$$
delimiter ;

delimiter $$
create trigger trig_upd_salary
before update on salaries
for each row
begin
	if new.salary < 0 then
		set new.salary = old.salary;
	end if;
end$$
delimiter ;

select sysdate();
select date_format(sysdate(), '%d-%m-%y') as today;

delimiter $$
create trigger trig_hire_date
before insert 
on employees
for each row
begin
	if new.hire_date > date_format(sysdate(), '%y-%m-%d') then
		set new.hire_date = date_format(sysdate(), '%y-%m-%d');
	end if;
end$$
delimiter ;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01'); 

SELECT  
    *  
FROM  
    employees
ORDER BY emp_no DESC;



-- create index on
-- used only for large datasets; for smaller datasets index slows search ; faster search and filter
-- primary and unique are default index

show index from employees from employees;

SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';		-- much faster search after creating index

create index i_hire_date on employees(hire_date);

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';

create index i_composite on employees(first_name, last_name);		-- composite index
drop index i_composite on employees;

alter table employees
drop index i_hire_date;

SELECT 
    *
FROM
    salaries
WHERE
    salary > 85000;
    
create index i_salary on salaries(salary);

alter table salaries
drop index i_salary;



--  case when then

SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;


SELECT 
    emp_no,
    first_name,
    last_name,
    CASE gender
        WHEN 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;

-- below code will not work correctly as is null can't be compared to a value
/*
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE dm.emp_no
        WHEN NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;
*/

SELECT 
    emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM
    employees;		-- if can't have multiple conditional expressions

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(salary) > 30000 THEN 'Salary was raised by more than $30000'
        WHEN MAX(s.salary) - MIN(salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20000 but less than $30000'
        ELSE 'Salary was raised by less than $20000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(salary) > 30000 THEN 'Salary was raised by more than $30000'
        ELSE 'Salary was NOt raised by more than $30000'
    END AS salary_raise 
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(salary) > 30000,
        'Salary was raised by more than $30000',
        'Salary was NOt raised by more than $30000') AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;
    


-- final query questions

use employees;

SELECT 
    d.dept_name, e.gender, AVG(s.salary)
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
        JOIN
    dept_emp de ON s.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name , e.gender
ORDER BY d.dept_name;



SELECT 
    MIN(dept_no)
FROM
    dept_emp;
SELECT 
    MAX(dept_no)
FROM
    dept_emp;



SELECT 
    e.emp_no,
    (SELECT 
            MIN(de.dept_no)
        FROM
            dept_emp de
        WHERE
            e.emp_no = de.emp_no) dept_no,
    CASE
        WHEN e.emp_no <= 10020 THEN '110022'
        ELSE '110022'
    END AS manager
FROM
    employees e
WHERE
    e.emp_no <= 10040;


SELECT 
    *
FROM
    employees
WHERE
    YEAR(hire_date) = 2000;


SELECT 
    *
FROM
    titles
WHERE
    title LIKE ('%engineer%');
SELECT 
    *
FROM
    titles
WHERE
    title LIKE ('%senior engineer%');



drop procedure if exists last_dept;
delimiter $$
create procedure last_dept(IN p_emp_no INT)
begin
	SELECT 
		de.emp_no,
        de.dept_no,
        d.dept_name
	FROM
		dept_emp de
			JOIN
		departments d ON de.dept_no = d.dept_no
	WHERE
		emp_no = p_emp_no
			AND
		de.from_date = (SELECT 
            MAX(from_date)
        FROM
            dept_emp
        WHERE
            emp_no = p_emp_no);
end$$
delimiter ;
call employees.last_dept(10010);



SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000
        AND (to_date - from_date) >= (60 * 60 * 24 * 7 * 52);



drop trigger if exists trig_hire_date;
delimiter $$
create trigger trig_hire_date
before insert on employees
for each row
begin
	declare today date;
    set today = date_format(sysdate(), '%y-%m-%d');
	if new.hire_date > today then
		set new.hire_date = today;
	end if;
end$$
delimiter ;

commit;
rollback;



drop function if exists f_highest_salary;
delimiter $$
create function f_highest_salary(p_emp_no int) returns DECIMAL(10,2)
reads sql data deterministic no sql
begin
	declare v_highest_salary DECIMAL(10,2);
	SELECT 
		MAX(salary)
	INTO v_highest_salary FROM
		salaries
	WHERE
		emp_no = p_emp_no;
    return v_highest_salary;
end$$
delimiter ;
select f_highest_salary(11356);

drop function if exists f_lowest_salary;
delimiter $$
create function f_lowest_salary(p_emp_no int) returns decimal(10,2)
reads sql data deterministic no sql
begin
	declare v_lowest_salary decimal(10,2);
    SELECT 
		MIN(salary)
	INTO v_lowest_salary FROM
		salaries
	WHERE
		emp_no = p_emp_no;
	return v_lowest_salary;
end$$
delimiter ;
select f_lowest_salary(10356);



drop function if exists f_salary;
delimiter $$
create function f_salary(p_emp_no int, p_min_or_max varchar(40)) returns DECIMAL(10,2)
reads sql data deterministic no sql
begin
	declare v_salary_info DECIMAL(10,2);
	SELECT 
		CASE
			WHEN p_min_or_max = 'max' THEN MAX(salary)
			WHEN p_min_or_max = 'min' THEN MIN(salary)
			ELSE MAX(salary) - MIN(salary)
		END AS salary_info
	INTO v_salary_info FROM
		salaries
	WHERE
		emp_no = p_emp_no;
    return v_salary_info;
end$$
delimiter ;
select f_salary(11356, 'min');
select f_salary(11356, 'max');
select f_salary(11356, 'abcd');