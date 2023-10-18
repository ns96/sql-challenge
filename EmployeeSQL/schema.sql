/*
Create table for Pewlett Hackard
*/

-- Drop the table if they exist. This is also the order of csv imports
-- use the CASCADE functionality to get around the foreign key constraints
DROP TABLE IF EXISTS titles CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS salary CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS dept_emp CASCADE;

CREATE TABLE departments (
    dept_no CHAR(4)   NOT NULL,
    dept_name VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
    dept_no CHAR(4)   NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (
        emp_no, dept_no
     )
);

CREATE TABLE dept_manager (
    dept_no CHAR(4)   NOT NULL,
    emp_no INT   NOT NULL,
    CONSTRAINT pk_dept_manager PRIMARY KEY (
        dept_no, emp_no
     )
);

CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id CHAR(5)   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR(30)   NOT NULL,
    last_name VARCHAR(30)   NOT NULL,
    sex CHAR(1)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE titles (
    title_id CHAR(5)   NOT NULL,
    title VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id
     )
);

CREATE TABLE salary (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    CONSTRAINT pk_salary PRIMARY KEY (
        emp_no
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

-- Add a CHECK contraint for valid sex values which can only be 'M' or 'F'
ALTER TABLE "employees" ADD CONSTRAINT "sex_vals" CHECK ("sex" IN ('M','F'));

ALTER TABLE "salary" ADD CONSTRAINT "fk_salary_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");