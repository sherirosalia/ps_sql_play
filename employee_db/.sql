select * from employees limit 5;
select * from dept_manager limit 5;
select * from salaries limit 5;
select * from departments limit 5;
select * from titles limit 5;

-- test query from my own curiosity
SELECT salaries.emp_no, salaries.salary, employees.emp_no, employees.first_name, employees.last_name, employees.hire_date
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

--	SECOND PROMPT:
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


-- List the manager of each department along with their 
-- department number, department name, employee number, last name, and first name.



-- List the department number for each employee along with that 
-- employee’s employee number, last name, first name, and department name.


-- List first name, last name, and sex of each employee 
-- whose first name is Hercules and whose last name begins with the letter B.


-- List each employee in the Sales department, 
-- including their employee number, last name, and first name.


-- List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.


-- List the frequency counts, in descending order, 
-- of all the employee last names (that is, how many employees share each last name).







