select * from employees limit 5;
select * from dept_manager limit 5;
select * from salaries limit 5;
select * from departments limit 5;
select * from titles limit 5;
SELECT * FROM dept_employees LIMIT 5;

-- test query from my own curiosity
SELECT salaries.emp_no, salaries.salary, employees.emp_no, 
employees.first_name, employees.last_name, employees.hire_date
FROM employees 
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE salaries.salary > 110000 AND employees.hire_date > '1998-01-01'
ORDER BY salaries.salary DESC, employees.hire_date ASC;

-- CURRICULUM PROMPTS

--	FIRST PROMPT:
-- List the employee number, last name, first name, sex, and salary of each employee.
-- inner join and left join return identical values
-- inner join approach
SELECT salaries.emp_no, salaries.salary, employees.emp_no, employees.last_name, employees.first_name, employees.sex
FROM employees 
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY salaries.emp_no;
-- left join approach
SELECT salaries.emp_no, salaries.salary, employees.emp_no, employees.last_name, employees.first_name, employees.sex
FROM employees 
LEFT JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY salaries.emp_no;

-- SECOND PROMPT:
-- List the first name, last name, and hire date for the employees who were hired in 1986.
-- select * from employees limit 1;
SELECT e.first_name, e.last_name, e.hire_date
FROM employees as e
WHERE
      e.hire_date >= '1986-01-01'
  AND e.hire_date <  '1987-01-01'
  ORDER BY e.hire_date DESC;
 
  
-- ALTERNATE:
-- Employees hired in 1986
-- SELECT first_name, last_name, hire_date
-- FROM employees
-- WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- THIRD PROMPT:
-- List the manager of each department along with their 
-- department number, department name, employee number, last name, and first name.
SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager
	INNER JOIN employees ON(employees.emp_no = dept_manager.emp_no)
	INNER JOIN departments ON (dept_manager.dept_no = departments.dept_no);
	
-- ALTERNATE
-- SELECT  dm.dept_no,
-- 		d.dept_name,
-- 		dm.emp_no,
-- 		e.last_name,
-- 		e.first_name
-- 	FROM dept_manager AS dm
-- 		INNER JOIN departments AS d
-- 			ON (dm.dept_no = d.dept_no)
-- 		INNER JOIN employees AS e
-- 		ON (dm.emp_no = e.emp_no);

-- FOURTH PROMPT:
-- List the department number for each employee along with that 
-- employee’s employee number, last name, first name, and department name.

SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_employees AS de
	LEFT JOIN employees as e
		ON (de.emp_no=e.emp_no)
	LEFT JOIN departments as d
		ON (de.dept_no=d.dept_no)
	ORDER BY e.emp_no;
	
-- ALTERNATE curriculum answer which is missing department number
-- BOTH STRATEGIES RETURN THE SAME NUMBER OF EMPLOYEES
-- SELECT  e.emp_no,
--         e.last_name,
--         e.first_name,
--         d.dept_name
-- FROM employees AS e
--     INNER JOIN dept_employees AS de
--         ON (e.emp_no = de.emp_no)
--     INNER JOIN departments AS d
--         ON (de.dept_no = d.dept_no)
-- ORDER BY e.emp_no;

-- FIFTH PROMPT
-- List first name, last name, and sex of each employee 
-- whose first name is Hercules and whose last name begins with the letter B.

SELECT e.first_name, e.last_name, e.sex
FROM employees as e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%';




-- SIXTH PROMPT
-- List each employee in the Sales department, 
-- including their employee number, last name, and first name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
	JOIN dept_employees as de
		ON e.emp_no = de.emp_no
	INNER JOIN departments as d
		ON d.dept_no = de.dept_no
		 WHERE 'Sales' ~ d.dept_name;




-- SEVENTH PROMPT
-- List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
	JOIN dept_employees as de
		ON e.emp_no = de.emp_no
	INNER JOIN departments as d
		ON d.dept_no = de.dept_no
		--  WHERE 'Marketing' ~ d.dept_name OR 'Finance' ~ d.dept_name
		WHERE 'Sales' ~ d.dept_name OR 'Development' ~ d.dept_name
		 ORDER BY e.emp_no ASC;

-- EIGTH PROMPT
-- List the frequency counts, in descending order, 
-- of all the employee last names (that is, how many employees share each last name).
SELECT employees.last_name, COUNT(employees.last_name) AS Occurences
FROM employees
GROUP BY employees.last_name
ORDER BY Occurences DESC;

-- ALTERNATE CURRICULUM SOLUTION:
-- The frequency of employee last names
-- SELECT last_name, COUNT(last_name)
-- FROM employees
-- GROUP BY last_name
-- ORDER BY COUNT(last_name) DESC;




