 -- create table for departments
 CREATE TABLE departments (
    dept_no VARCHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE (dept_name)
    );
	
	select * from departments;
	
-- employes table	
CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title VARCHAR NOT NULL,
	birth_date DATE NOT NULL, 
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
	

);

select * from employees limit 10;
-- department managers
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
		PRIMARY KEY (emp_no, dept_no)
);
select * from dept_manager;
-- salaries
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
		PRIMARY KEY (emp_no)
);

SELECT * FROM salaries LIMIT 10;

CREATE TABLE dept_employees (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
		FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
		FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
			PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM dept_employees LIMIT 1;







