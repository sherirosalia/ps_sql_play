SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	   
SELECT COUNT(first_name) AS occurences
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	   
-- SELECT first_name, last_name
-- INTO retirement_info
-- FROM employees
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info LIMIT 4;   

-- Let's create a query that will return each department name
-- from the Departments table as well as the employee numbers 
-- and the from- and to- dates from the dept_manager table. 

SELECT d.dept_name, e.emp_no, e.hire_date, e.first_name, e.last_name
FROM departments AS d
INNER JOIN  dept_employees AS de
	ON (d.dept_no = de.dept_no)
INNER JOIN employees as e
	ON (de.emp_no = e.emp_no)
GROUP BY d.dept_name, e.emp_no;

-- count of employees in each department left join
SELECT  d.dept_name, COUNT(e.emp_no) AS employee_count
FROM departments AS d
LEFT JOIN  dept_employees AS de
	ON (d.dept_no = de.dept_no)
LEFT JOIN employees as e
	ON (de.emp_no = e.emp_no)
GROUP BY d.dept_name
ORDER BY employee_count DESC;

-- count of employees in each department inner join
SELECT  d.dept_name, COUNT(e.emp_no) AS employee_count
FROM departments AS d
INNER JOIN  dept_employees AS de
	ON (d.dept_no = de.dept_no)
INNER JOIN employees as e
	ON (de.emp_no = e.emp_no)
GROUP BY d.dept_name
ORDER BY employee_count DESC;
	