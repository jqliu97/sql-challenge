CREATE TABLE titles (
    title_id VARCHAR(5) PRIMARY KEY,
    title VARCHAR(255)
);

INSERT INTO titles (title_id, title) VALUES
('s0001', 'Staff'),
('s0002', 'Senior Staff'),
('e0001', 'Assistant Engineer'),
('e0002', 'Engineer'),
('e0003', 'Senior Engineer'),
('e0004', 'Technique Leader'),
('m0001', 'Manager');

select * from employees

drop table employees

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id CHAR(255),
    birth_date DATE,
    first_name CHAR(255),
    last_name CHAR(255),
    sex CHAR(1),
    hire_date DATE
);

select * from employees

CREATE TABLE salaries (
    emp_no INT PRIMARY KEY,
    salary INT
);

select * from salaries

CREATE TABLE dept_manager (
    dept_no VARCHAR(5) PRIMARY KEY,
    emp_no INT[]
);

-- Insert data into the "dept_manager" table, merging emp_no values for duplicate dept_no
INSERT INTO dept_manager (dept_no, emp_no)
SELECT dept_no, ARRAY_AGG(emp_no) AS emp_no
FROM (
    VALUES
        ('d001', 110022),
        ('d001', 110039),
        ('d002', 110085),
        ('d002', 110114),
        ('d003', 110183),
        ('d003', 110228),
        ('d004', 110303),
        ('d004', 110344),
        ('d004', 110386),
        ('d004', 110420),
        ('d005', 110511),
        ('d005', 110567),
        ('d006', 110725),
        ('d006', 110765),
        ('d006', 110800),
        ('d006', 110854),
        ('d007', 111035),
        ('d007', 111133),
        ('d008', 111400),
        ('d008', 111534),
        ('d009', 111692),
        ('d009', 111784),
        ('d009', 111877),
        ('d009', 111939)
) AS data(dept_no, emp_no)
GROUP BY dept_no;

-- Update the "dept_manager" table to resequence emp_no values in chronological order
UPDATE dept_manager
SET emp_no = (
    SELECT ARRAY_AGG(e ORDER BY e)
    FROM unnest(emp_no) AS e
);

CREATE TABLE dept_emp (
    emp_no INTEGER,  
    dept_no VARCHAR(5)
);

-- Insert the data
INSERT INTO dept_emp (emp_no, dept_no)
VALUES (10001, 'd005');

select * from dept_emp

drop table departments

CREATE TABLE departments(
    dept_no CHAR(5),
    dept_name CHAR(50)
);

INSERT INTO departments (dept_no, dept_name)
VALUES
    ('d001', 'Marketing'),
    ('d002', 'Finance'),
    ('d003', 'Human Resources'),
    ('d004', 'Production'),
    ('d005', 'Development'),
    ('d006', 'Quality Management'),
    ('d007', 'Sales'),
    ('d008', 'Research'),
    ('d009', 'Customer Service');

select * from departments

-- Create the foreign key constraint in the "departments" table
ALTER TABLE departments
ADD CONSTRAINT fk_dept_emp
FOREIGN KEY (dept_no) REFERENCES dept_emp (dept_no);
