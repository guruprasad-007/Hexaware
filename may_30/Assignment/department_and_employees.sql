CREATE TABLE departments
(
department_id INT PRIMARY KEY,
department_name VARCHAR(50),
location VARCHAR(50)
);

CREATE TABLE employees
(
employee_id INT PRIMARY KEY,
employee_name VARCHAR(50),
department_id INT,
salary DECIMAL(10,2),
city VARCHAR(50),
manager_id INT
);

INSERT INTO departments VALUES
(10, 'IT', 'Hyderabad'),
(20, 'HR', 'Bangalore'),
(30, 'Finance', 'Mumbai'),
(40, 'Sales', 'Delhi'),
(50, 'Marketing', NULL);

INSERT INTO employees VALUES
(101, 'Rahul Sharma', 10, 75000, 'Hyderabad', 201),
(102, 'Priya Reddy', 10, 85000, 'Bangalore', 201),
(103, 'Amit Kumar', 20, 55000, NULL, 202),
(104, 'Sneha Patel', 30, 65000, 'Mumbai', 203),
(105, 'Arjun Verma', NULL, 60000, 'Chennai', 204),
(106, 'Neha Singh', 60, 50000, 'Delhi', NULL),
(107, 'Farhan Ali', 40, NULL, 'Hyderabad', 205),
(108, 'Meera Nair', 10, 90000, 'Pune', 201);

SELECT e.employee_name, e.salary, d.department_name, d.location
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

SELECT e.employee_name, e.salary, d.department_name, d.location
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

SELECT e.employee_name 
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

SELECT d.department_name, d.location, e.employee_name, e.salary
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

SELECT d.department_name 
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

SELECT * FROM employees 
WHERE salary IS NULL;

SELECT * FROM employees 
WHERE city IS NULL;

SELECT * FROM departments 
WHERE location IS NULL;

SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

SELECT d.department_name, AVG(e.salary) AS average_salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 2;

SELECT d.department_name, MAX(e.salary) AS highest_salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;