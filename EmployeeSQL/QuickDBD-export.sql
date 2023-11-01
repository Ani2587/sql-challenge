﻿-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/VmyapH
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" CHAR(5)   NOT NULL,
    "dept_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "titles" (
    "title_id" CHAR(5)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" CHAR(5)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(50)   NOT NULL,
    "last_name" VARCHAR(50)   NOT NULL,
    "sex" CHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" CHAR(5)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" CHAR(5)   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM titles;

--List the employee number, last name, first name, sex, and salary of each employee 
SELECT employees.emp_no,employees.last_name,employees.first_name,employees.sex,salaries.salary
FROM employees INNER JOIN salaries
ON employees.emp_no = salaries.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986

SELECT first_name,last_name,hire_date FROM employees  
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their department number,
--department name, employee number, last name, and first name

SELECT dept_manager.dept_no,dept_manager.emp_no,employees.first_name,employees.last_name,departments.dept_name
FROM dept_manager  
JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no


--List the department number for each employee along with that employee’s employee number,
--last name, first name, and department name


SELECT dept_emp.emp_no,dept_emp.dept_no,employees.last_name,employees.first_name,departments.dept_name
FROM dept_emp 
JOIN employees ON dept_emp.emp_no=employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no


--List first name, last name, and sex of each employee whose first name is Hercules
--and whose last name begins with the letter B

SELECT first_name,last_name,sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--List each employee in the Sales department, including their employee number, last name, and first name

SELECT dept_emp.emp_no,dept_emp.dept_no,employees.first_name,employees.last_name FROM dept_emp 
JOIN employees
ON dept_emp.emp_no=employees.emp_no
WHERE dept_no IN (SELECT dept_no FROM departments WHERE dept_name = 'Sales')

--List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name


SELECT dept_emp.emp_no,dept_emp.dept_no,employees.first_name,employees.last_name,departments.dept_name FROM dept_emp 
JOIN employees
ON dept_emp.emp_no=employees.emp_no
JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE dept_emp.dept_no IN (SELECT dept_no FROM departments WHERE dept_name = 'Sales'OR dept_name = 'Development')

--List the frequency counts, in descending order, 
--of all the employee last names (that is, how many employees share each last name) 



