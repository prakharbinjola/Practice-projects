use employees_mod;

-- Task 1

SELECT 
    YEAR(de.from_date) AS calender_year,
    e.gender AS gender,
    COUNT(*) AS num_of_employees
FROM
    t_employees e
        JOIN
    t_dept_emp de ON e.emp_no = de.emp_no
WHERE
    de.from_date >= '1990-01-01'
GROUP BY YEAR(de.from_date) , e.gender 
ORDER BY de.from_date , e.gender;


SELECT 
    YEAR(d.from_date) AS calender_year,
    e.gender AS gender,
    COUNT(e.emp_no) AS num_of_employees
FROM
    t_employees e
        JOIN
    t_dept_emp d ON e.emp_no = d.emp_no
GROUP BY calender_year , e.gender
HAVING calender_year >= '1990'
ORDER BY d.from_date , e.gender;



-- Task 2

SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calender_year,
    CASE
        WHEN e.calender_year BETWEEN YEAR(dm.from_date) AND YEAR(dm.to_date) THEN '1'
        ELSE '0'
    END AS `active`
FROM
    (SELECT 
        YEAR(hire_date) AS calender_year
    FROM
        t_employees
    GROUP BY calender_year) e
        CROSS JOIN
    t_dept_manager dm
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        JOIN
    t_employees ee ON dm.emp_no = ee.emp_no
WHERE
    dm.from_date >= '1990-01-01'
ORDER BY emp_no , e.calender_year;



-- Task 3

SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS salary,
    YEAR(s.from_date) AS calender_year
FROM
    t_employees e
        JOIN
    t_dept_emp de ON e.emp_no = de.emp_no
        JOIN
    t_departments d ON de.dept_no = d.dept_no
        JOIN
    t_salaries s ON e.emp_no = s.emp_no
WHERE
    YEAR(s.from_date) <= '2002'
GROUP BY calender_year , d.dept_name , e.gender
ORDER BY calender_year;



-- Task 4

drop procedure if exists filter_salary;
delimiter $$
create procedure filter_salary(IN p_min_salary float, IN p_max_salary float)
begin
	SELECT 
		e.gender, d.dept_name, ROUND(AVG(s.salary), 2) AS avg_salary
	FROM
		t_employees e
			JOIN
		t_dept_emp de ON e.emp_no = de.emp_no
			JOIN
		t_departments d ON de.dept_no = d.dept_no
			JOIN
		t_salaries s ON e.emp_no = s.emp_no
	WHERE s.salary BETWEEN p_min_salary AND p_max_salary
	GROUP BY d.dept_name , e.gender
	ORDER BY d.dept_name;
end$$
delimiter ;		-- float data type in the standard choice for professionals for currency

call filter_salary(50000, 90000);