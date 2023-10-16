--JORDAN DUBE HW5 CMSC508--


-- website says different datatypes/sizes. 
--Is there a certain convention that they follow to reach these values? It wasnt mentioned anywhere 
--what the sizes or formats of the columns is/should be.

--MySQL Create Table--
--Q1--
--Write a SQL statement to create a simple table countries including columns country_id,country_name and region_id.--
CREATE TABLE countries(
	country_id 		INT(8),
	country_name 	VARCHAR(255), 
	region_id 		INT(16));

--Q2--
--Write a SQL statement to create a simple table countries including columns country_id,country_name and region_id which is already exists.--
CREATE TABLE IF NOT EXISTS countries(
	country_id 		INT(8),
	country_name 	VARCHAR(255), 
	region_id 		INT(16));

--Q3--
--Write a SQL statement to create the structure of a table dup_countries similar to countries.--
CREATE TABLE IF NOT EXISTS dup_countries LIKE countries;

--Q4--
--Write a SQL statement to create a duplicate copy of countries table including structure and data by name dup_countries.--
CREATE TABLE IF NOT EXISTS dup_countries 
	AS SELECT * FROM countries;

--Q5--
--Write a SQL statement to create a table countries set a constraint NULL.--
--NOTE: original question above ^ only says "NULL", not "NOT NULL", but the answer on the site uses "NOT NULL" instead
CREATE TABLE IF NOT EXISTS countries(
	country_id 		INT(8) NOT NULL,
	country_name 	VARCHAR(255) NOT NULL, 
	region_id 		INT(16) NOT NULL
	);

--Q6--
--Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, max_salary and check whether the max_salary amount exceeding the upper limit 25000.--
CREATE TABLE IF NOT EXISTS jobs(
	job_id VARCHAR(20) NOT NULL, 
	job_title VARCHAR(50) NOT NULL, 
	min_salary DECIMAL(10, 2), 
	max_salary DECIMAL(10, 2) CHECK (max_salary < 25000)
);

--Q7--
--Write a SQL statement to create a table named countries including columns country_id, country_name and region_id and make sure that no countries except Italy, India and China will be entered in the table.--
CREATE TABLE IF NOT EXISTS countries(
	country_id VARCHAR(2), 
	country_name ENUM('INDIA', 'CHINA', 'ITALY') NOT NULL,
	region_id NUMERIC(10)
);

--Q8--
--Write a SQL statement to create a table named job_histry including columns employee_id, start_date, end_date, job_id and department_id 
--	and make sure that the value against column end_date will be entered at the time of insertion to the format like '--/--/----'.--
CREATE TABLE job_history(
	employee_id NUMERIC(8) NOT NULL, 
	start_date DATE NOT NULL check (start_date LIKE "__/__/____"), -- "_" is the wildcard single char, which makes more sense than "-"
	end_date DATE NOT NULL check (end_date LIKE "__/__/____"), -- "_" is the wildcard single char, which makes more sense than "-"
	job_id VARCHAR(10) NOT NULL,
	department_id NUMERIC(4) NOT NULL
);

--Q9--
--Write a SQL statement to create a table named countries including columns country_id,country_name 
--	and region_id and make sure that no duplicate data against column country_id will be allowed at the time of insertion.--
CREATE TABLE IF NOT EXISTS countries(
	country_id VARCHAR(2) NOT NULL,
	country_name VARCHAR(20) NOT NULL,
	region_id NUMERIC(8) NOT NULL,
	UNIQUE(country_id)
);

--Q10--
--Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary and max_salary, 
--	and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will 
--	be entered automatically at the time of insertion if no value assigned for the specified columns. --
CREATE TABLE IF NOT EXISTS jobs(
	job_id VARCHAR(20) NOT NULL UNIQUE, 
	job_title VARCHAR(50) NOT NULL DEFAULT '', 
	min_salary DECIMAL(10, 2) DEFAULT 8000,
	max_salary DECIMAL(10, 2) DEFAULT NULL
);

--Q11--
--Write a SQL statement to create a table named countries including columns country_id, 
--	country_name and region_id and make sure that the country_id column will be a key field 
--	which will not contain any duplicate data at the time of insertion.--
CREATE TABLE IF NOT EXISTS countries(
	country_id VARCHAR(2) PRIMARY KEY,
	country_name VARCHAR(20),
	region_id INT(8)
);

--Q12--
-- Write a SQL statement to create a table countries including columns country_id, 
--	country_name and region_id and make sure that the column country_id will be unique and store an auto incremented value.--
CREATE TABLE IF NOT EXISTS countries(
	country_id INT(4) AUTO_INCREMENT UNIQUE NOT NULL,
	country_name VARCHAR(20) NOT NULL,
	region_id INT(8) NOT NULL
);

--Q13--
--Write a SQL statement to create a table countries including columns country_id, 
--	country_name and region_id and make sure that the combination of columns country_id and region_id will be unique.--
CREATE TABLE IF NOT EXISTS countries(
	country_id VARCHAR(2) NOT NULL UNIQUE DEFAULT '',
	country_name VARCHAR(40) DEFAULT NULL,
	region_id INT(10) NOT NULL,
	PRIMARY KEY (country_id, region_id)
);

--Q14--
--Write a SQL statement to create a table job_history including columns employee_id, start_date, 
--	end_date, job_id and department_id and make sure that, the employee_id column does not contain 
--	any duplicate value at the time of insertion and the foreign key column job_id contain only those 
--	values which are exists in the jobs table.
CREATE TABLE IF NOT EXISTS job_history(
	employee_id NUMERIC(8) NOT NULL PRIMARY KEY, 
	start_date DATE NOT NULL check (start_date LIKE "__/__/____"), 
	end_date DATE NOT NULL check (end_date LIKE "__/__/____"), 
	job_id VARCHAR(10) NOT NULL,
	department_id NUMERIC(4) DEFAULT NULL,
	FOREIGN KEY (job_id) references jobs(job_id)
);

--Q15--
--Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, 
--	email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure 
--	that, the employee_id column does not contain any duplicate value at the time of insertion and the 
--	foreign key columns combined by department_id and manager_id columns contain only those unique combination 
--	values, which combinations are exists in the departments table.--
CREATE TABLE IF NOT EXISTS employees(
	employee_id NUMERIC(6) PRIMARY KEY, 
	first_name VARCHAR(20) DEFAULT NULL, 
	last_name VARCHAR(20) NOT NULL, 
	email VARCHAR(20) NOT NULL, 
	phone_number VARCHAR(20) DEFAULT NULL,
	hire_date DATE NOT NULL, 
	job_id VARCHAR(10) NOT NULL, 
	salary DECIMAL(10, 2) DEFAULT NULL, 
	commission DECIMAL(2, 2) DEFAULT NULL, 
	manager_id NUMERIC(6) DEFAULT NULL, 
	department_id NUMERIC(4) DEFAULT NULL,
	FOREIGN KEY (department_id, manager_id) references departments(department_id, manager_id)
);

--Q16--
--Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, 
--	email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make 
--	sure that, the employee_id column does not contain any duplicate value at the time of insertion, 
--	and the foreign key column department_id, reference by the column department_id of departments 
--	table, can contain only those values which are exists in the departments table and another foreign 
--	key column job_id, referenced by the column job_id of jobs table, can contain only those values 
--	which are exists in the jobs table. The InnoDB Engine have been used to create the tables.
CREATE TABLE IF NOT EXISTS employees(
	employee_id NUMERIC(6) PRIMARY KEY, 
	first_name VARCHAR(20) DEFAULT NULL, 
	last_name VARCHAR(20) NOT NULL, 
	email VARCHAR(20) NOT NULL, 
	phone_number VARCHAR(20) DEFAULT NULL,
	hire_date DATE NOT NULL, 
	job_id VARCHAR(10) NOT NULL, 
	salary DECIMAL(10, 2) DEFAULT NULL, 
	commission DECIMAL(2, 2) DEFAULT NULL, 
	manager_id NUMERIC(6) DEFAULT NULL, 
	department_id NUMERIC(4) DEFAULT NULL,
	FOREIGN KEY (department_id) references departments(department_id)
	FOREIGN KEY (job_id) references jobs(job_id)
);

--Q17--
--Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, 
--	job_id, salary and make sure that, the employee_id column does not contain any duplicate 
--	value at the time of insertion, and the foreign key column job_id, referenced by the column 
--	job_id of jobs table, can contain only those values which are exists in the jobs table.
CREATE TABLE IF NOT EXISTS employees(
	employee_id NUMERIC(6) PRIMARY KEY, 
	first_name VARCHAR(20) DEFAULT NULL, 
	last_name VARCHAR(20) NOT NULL, 
	job_id VARCHAR(10) NOT NULL, 
	salary DECIMAL(10, 2) DEFAULT NULL, 
	FOREIGN KEY (job_id) references jobs(job_id)
);

--Q18--
--Write a SQL statement to create a table employees including columns employee_id, first_name, 
--	last_name, job_id, salary and make sure that, the employee_id column does not contain 
--	any duplicate value at the time of insertion, and the foreign key column job_id, referenced 
--	by the column job_id of jobs table, can contain only those values which are exists in the jobs table. 
CREATE TABLE IF NOT EXISTS employees(
	employee_id NUMERIC(6) PRIMARY KEY, 
	first_name VARCHAR(20) DEFAULT NULL, 
	last_name VARCHAR(20) NOT NULL, 
	job_id VARCHAR(10) NOT NULL, 
	salary DECIMAL(10, 2) DEFAULT NULL, 
	FOREIGN KEY (job_id) references jobs(job_id)
);



-----------------------------------------------------------------------------------------------------------------------------
--MySQL INSERT INTO Table--

--Q1--
--Write a SQL statement to insert a record with your own value into the table countries against each columns.
INSERT INTO countries VALUES('US', 'UNITED STATES', 23);

--Q2--
--Write a SQL statement to insert one row into the table countries against the column country_id and country_name.
INSERT INTO countries (country_id, country_name) VALUES('US', 'UNITED STATES');

--Q3--
--Write a SQL statement to create duplicate of countries table named country_new with all structure and data.
CREATE TABLE country_new AS SELECT * FROM countries;

--Q4--
--Write a SQL statement to insert NULL values against region_id column for a row of countries table
INSERT INTO countries (country_id, country_name, region_id) VALUES('US', 'UNITED STATES', 23);

--Q5--
--Write a SQL statement to insert 3 rows by a single insert statement
INSERT INTO countries VALUES('US', 'UNITED STATES', 23), ('US', 'UNITED STATES', 24), ('US', 'UNITED STATES', 25);

--Q6--
--Write a SQL statement insert rows from country_new table to countries table.
INSERT INTO countries SELECT * FROM country_new

--Q7--
--Write a SQL statement to insert one row in jobs table to ensure that no duplicate value will be entered in the job_id column.
INSERT INTO jobs VALUES(1001,'OFFICER',8000) --requires restraint on jobs table side, not the statement

--Q8--
--Write a SQL statement to insert one row in jobs table to ensure that no duplicate value will be entered in the job_id column.
--SAME AS Q7

--Q9--
--Write a SQL statement to insert a record into the table countries to ensure that, a country_id and region_id combination will be entered once in the table.

-- at this point in the module almost all the questions revolve more around creation rather than insert statements


------------------------------------------------------------------------------------------------------------------------------

--MySQL UPDATE Table--

--Q1--
--Write a SQL statement to change the email column of employees table with 'not available' for all employees.
UPDATE employees SET email='not available';

--Q2--
--Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for all employees.
UPDATE employees SET email='not available', commission=0.10;

--Q3--
--Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for those employees whose department_id is 110.
UPDATE employees SET email='not available', commission=0.10 WHERE department_id=110;

--Q4--
--Write a SQL statement to change the email column of employees table with 'not available' for those employees 
--	whose department_id is 80 and gets a commission_pct is less than .20
UPDATE employees SET email='not available' WHERE department_id=80 AND IFNULL(commission, 0) < .20;

--Q5--
--Write a SQL statement to change the email column of employees table with 'not available' for those employees who belongs to the 'Accouning' department.
UPDATE employees SET email='not available' WHERE department_id=(SELECT department_id FROM departments WHERE department_name = 'ACCOUNTING');

--Q6--
--Write a SQL statement to change salary of employee to 8000 whose ID is 105, if the existing salary is less than 5000.
UPDATE employees SET salary=8000 WHERE salary < 5000 AND employee_id=105;

--Q7--
--Write a SQL statement to change job ID of employee which ID is 118, to SH_CLERK if the employee belongs to department, which ID is 30 and the existing job ID does not start with SH.
UPDATE employees SET job_id='SH_CLERK' where employee_id = 118 AND department_id = 30 AND NOT job_id LIKE 'SH%';

--Q8--
--Write a SQL statement to increase the salary of employees under the department 40, 90 and 110 according to the company rules that, salary will be 
--	increased by 25% for the department 40, 15% for department 90 and 10% for the department 110 and the rest of the departments will remain same.
UPDATE employees SET salary=CASE department_id WHEN 40 THEN salary + salary*.25 WHEN 90 THEN salary + salary*.15 WHEN 110 THEN salary + salary*.1 ELSE salary END

--Q9--
--Write a SQL statement to increase the minimum and maximum salary of PU_CLERK by 2000 as well as the salary for those employees by 20% and commission percent by .10.
UPDATE jobs,employees SET jobs.min_salary=jobs.min_salary+2000, jobs.max_salary=jobs.max_salary+2000, employees.salary=employees.salary*1.2, employees.commission_pct=employees.commission_pct+.1 WHERE jobs.job_id = 'PU_CLERK' and employees.job_id='PU_CLERK';


------------------------------------------------------------------------------------------------------------------------------

--MySQL ALTER Table--

--Q1--
--Write a SQL statement to rename the table countries to country_new.
ALTER TABLE countries RENAME country_new;

--Q2--
--Write a SQL statement to add a column region_id to the table locations.
ALTER TABLE locations ADD region_id INT;

--Q3--
--Write a SQL statement to add a columns ID as the first column of the table locations.
ALTER TABLE locations ADD ID INT FIRST;

--Q4--
--Write a SQL statement to add a column region_id after state_province to the table locations.
ALTER TABLE locations ADD region_id INT AFTER state_province;

--Q5--
--Write a SQL statement change the data type of the column country_id to integer in the table locations.
ALTER TABLE locations MODIFY country_id INT;

--Q6--
--Write a SQL statement to drop the column city from the table locations.
ALTER TABLE locations DROP city;

--Q7--
--Write a SQL statement to change the name of the column state_province to state, keeping the data type and size same.
ALTER TABLE locations CHANGE state_province state VARCHAR(25);

--Q8--
--Write a SQL statement to add a primary key for the columns location_id in the locations table.
ALTER TABLE locations ADD PRIMARY KEY(location_id);

--Q9--
--Write a SQL statement to add a primary key for a combination of columns location_id and country_id.
ALTER TABLE locations ADD PRIMARY KEY(location_id, country_id);

--Q10--
--Write a SQL statement to drop the existing primary from the table locations on a combination of columns location_id and country_id
ALTER TABLE locations DROP PRIMARY KEY;

--Q11--
--Write a SQL statement to add a foreign key on job_id column of job_history table referencing to the primary key job_id of jobs table
ALTER TABLE job_history ADD FOREIGN KEY (job_id) references jobs(job_id);

--Q12--
--Write a SQL statement to add a foreign key constraint named fk_job_id on job_id 
--	column of job_history table referencing to the primary key job_id of jobs table
ALTER TABLE job_history ADD CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON UPDATE RESTRICT ON DELETE CASCADE;

--Q13--
--Write a SQL statement to drop the existing foreign key fk_job_id from job_history table on job_id column which is referencing to the job_id of jobs table.
ALTER TABLE job_history DROP FOREIGN KEY fk_job_id;

--Q14--
--Write a SQL statement to add an index named indx_job_id on job_id column in the table job_history
ALTER TABLE job_history ADD INDEX indx_job_id(job_id);

--Q15--
--Write a SQL statement to drop the index indx_job_id from job_history table
ALTER TABLE job_history DROP INDEX indx_job_id;

------------------------------------------------------------------------------------------------------------------------------

--MySQL BASIC SELECT--

--Q1--
--Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name"
SELECT first_name "First Name", last_name "Last Name" from employees;

--Q2--
--Write a query to get unique department ID from employee table
SELECT DISTINCT department_id FROM employees;

--Q3--
--Write a query to get all employee details from the employee table order by first name, descending.
SELECT * FROM employees ORDER BY first_name DESC;

--Q4--
--Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary)
SELECT first_name, last_name, salary, salary*.15 PF FROM employees;

--Q5--
--Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary.
SELECT employee_id, first_name, last_name, salary FROM employees ORDER BY salary ASC;

--Q6--
--Write a query to get the total salaries payable to employees
SELECT SUM(salary) total_salary FROM employees;

--Q7--
--Write a query to get the maximum and minimum salary from employees table.
SELECT MAX(salary) max_salary, MIN(salary) min_salary FROM employees;

--Q8--
--Write a query to get the average salary and number of employees in the employees table
SELECT AVG(salary), COUNT(*) FROM employees;

--Q9--
--Write a query to get the number of employees working with the company
SELECT COUNT(*) FROM employees;

--Q10--
--Write a query to get the number of jobs available in the employees table
SELECT COUNT(DISTINCT job_id) FROM employees;

--Q11--
--Write a query get all first name from employees table in upper case.
SELECT UPPER(first_name) FROM employees;

--Q12--
--Write a query to get the first 3 characters of first name from employees table
SELECT SUBSTR(first_name, 1, 3) FROM employees;

--Q13--
--Write a query to calculate 171*214+625
SELECT 171*214+625 RESULT;

--Q14--
--Write a query to get the names (for example Ellen Abel, Sundar Ande etc.) of all the employees from employees table.
SELECT CONCAT(first_name, ' ', last_name) Employee Name from employees;

--Q15--
--Write a query to get first name from employees table after removing white spaces from both side.
SELECT TRIM(first_name) FROM employees;

--Q16--
--Write a query to get the length of the employee names (first_name, last_name) from employees table.
SELECT first_name, last_name, LENGTH(first_name) + LENGTH(last_name) name_length FROM employees;

--Q17--
--Write a query to check if the first_name fields of the employees table contains numbers.
SELECT first_name FROM employees WHERE first_name REGEXP '[0-9]';

--Q18--
--Write a query to select first 10 records from a table
SELECT * FROM employees LIMIT 10;

--Q19--
--Write a query to get monthly salary (round 2 decimal places) of each and every employee
SELECT first_name, last_name, ROUND(salary/12, 2) "MONTHLY SALARY" FROM employees;

------------------------------------------------------------------------------------------------------------------------------

--MySQL SORTING/RESTRICTING--

--Q1--
--Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000
SELECT first_name, last_name FROM employees WHERE salary NOT BETWEEN 10000 AND 15000;

--Q2--
--Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order
SELECT first_name, last_name, department_id FROM employees WHERE department_id IN (30, 100) ORDER BY department_id;

--Q3--
--Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100.
SELECT first_name, last_name, salary FROM employees WHERE (salary NOT BETWEEN 10000 AND 15000) AND (department_id IN (30, 100));

--Q4--
--Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987
SELECT first_name, last_name, hire_date FROM employees WHERE YEAR(hire_date) LIKE '1987%';

--Q5--
--Write a query to display the first_name of all employees who have both "b" and "c" in their first name.
SELECT first_name FROM employees WHERE first_name LIKE '%b%' AND first_name LIKE '%c%';

--Q6--
--Write a query to display the last name, job, and salary for all employees whose job is that of a Programmer 
--	or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000
SELECT last_name, job_title, salary FROM employees JOIN jobs USING (job_id) WHERE job_title IN ('PROGRAMMER', 'SHIPPING CLERK') AND salary NOT IN (4500, 10000, 15000); 

--Q7--
--Write a query to display the last name of employees whose names have exactly 6 characters
SELECT last_name FROM employees WHERE last_name LIKE '______';

--Q8--
--Write a query to display the last name of employees having 'e' as the third character.
SELECT last_name FROM employees WHERE last_name LIKE '__e%';

--Q9--
--Write a query to display the jobs/designations available in the employees table
SELECT DISTINCT job_id FROM employees;

--Q10--
--Write a query to display the name (first_name, last_name), salary and PF (15% of salary) of all employees
SELECT first_name, last_name, salary, salary*.15 PF FROM employees;

--Q11--
--Write a query to select all record from employees where last name in 'BLAKE', 'SCOTT', 'KING' and 'FORD'
SELECT * FROM employees WHERE last_name in ('BLAKE', 'SCOTT', 'KING', 'FORD');

------------------------------------------------------------------------------------------------------------------------------

--MySQL Aggregate Functions and Group by--

--Q1--
--Write a query to list the number of jobs available in the employees table
SELECT COUNT(DISTINCT job_id) FROM employees;

--Q2--
--Write a query to get the total salaries payable to employees
SELECT SUM(salary) FROM employees;

--Q3--
--Write a query to get the minimum salary from employees table
SELECT MIN(salary) FROM	employees;

--Q4--
--Write a query to get the maximum salary of an employee working as a Programmer.
SELECT MAX(salary) FROM employees WHERE job_id LIKE '%PROG';

--Q5--
--Write a query to get the average salary and number of employees working the department 90
SELECT AVG(salary), COUNT(*) FROM employees WHERE department_id = 90;

--Q6--
--Write a query to get the highest, lowest, sum, and average salary of all employees
SELECT MAX(salary), MIN(salary), SUM(salary), AVG(salary) FROM employees;

--Q7--
--Write a query to get the number of employees with the same job.
SELECT job_id, COUNT(*) FROM employees GROUP BY job_id;

--Q8--
--Write a query to get the difference between the highest and lowest salaries
SELECT MAX(salary)-MIN(salary) FROM employees;

--Q9--
--Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
SELECT manager_id, MIN(salary) FROM employees WHERE manager_id IS NOT NULL GROUP BY manager_id ORDER BY MIN(salary);

--Q10--
--Write a query to get the department ID and the total salary payable in each department
SELECT department_id, SUM(salary) FROM employees WHERE department_id IS NOT NULL GROUP BY department_id;

--Q11--
--Write a query to get the average salary for each job ID excluding programmer
SELECT job_id, AVG(salary) FROM employees where job_id NOT LIKE '%PROG%' GROUP BY job_id;

--Q12--
--Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.
SELECT job_id, SUM(salary), MAX(salary), MIN(salary), AVG(salary) FROM employees WHERE department_id=90 GROUP BY job_id;

--Q13--
--Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000
SELECT job_id, MAX(salary) FROM employees GROUP BY job_id HAVING MAX(salary) >= 4000;

--Q14--
--Write a query to get the average salary for all departments employing more than 10 employees
SELECT department_id, COUNT(*), AVG(salary) FROM employees GROUP BY department_id HAVING COUNT(*)<10;

-------------------------------------------------------------------------------------------------------------------------------

--MySQL SUBQUERIES--

--Q1--
--Write a query to find the name (first_name, last_name) and the 
--	salary of the employees who have a higher salary than the employee whose last_name='Bull'.
SELECT first_name, last_name FROM employees WHERE salary > (SELECT MAX(salary) FROM employees WHERE last_name = 'Bull');

--Q2--
--Write a query to find the name (first_name, last_name) of all employees who works in the IT department
SELECT first_name, last_name, department_id FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE department_name LIKE "%IT%");

--Q3--
--Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department.
SELECT first_name, last_name FROM employees WHERE manager_id IN (SELECT employee_id FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE country_id LIKE '%US%'));

--Q4--
--Write a query to find the name (first_name, last_name) of the employees who are managers
SELECT first_name, last_name FROM employees WHERE employee_id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);

--Q5--
-- Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.
SELECT first_name, last_name, salary FROM employees where salary > (SELECT AVG(salary) FROM employees);

--Q6--
--Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their job grade
SELECT first_name, last_name, salary FROM employees e WHERE salary = (SELECT min_salary FROM jobs WHERE e.job_id = jobs.job_id);

--Q7--
--Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments
SELECT first_name, last_name, salary, job_id FROM employees WHERE salary > (SELECT AVG(salary) FROM employees) AND job_id LIKE '%IT%';

--Q8--
--Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of Mr. Bell
SELECT first_name, last_name, salary FROM employees WHERE salary > (SELECT MAX(salary) FROM employees WHERE last_name LIKE '%BELL%');

--Q9--
--Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments
SELECT first_name, last_name, salary FROM employees WHERE salary = (SELECT MIN(salary) FROM employees);

--Q10--
--Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all departments.
SELECT first_name, last_name, salary FROM employees WHERE salary > ALL(SELECT AVG(salary) FROM employees GROUP BY department_id);

--Q11--
--Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the 
--	Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest
SELECT first_name, last_name, salary FROM employees WHERE salary > (SELECT MAX(salary) FROM employees WHERE job_id = 'SH_CLERK') ORDER BY salary ASC; 

--Q12--
--Write a query to find the name (first_name, last_name) of the employees who are not supervisors
SELECT first_name, last_name FROM employees WHERE employee_id NOT IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);

--Q13--
--Write a query to display the employee ID, first name, last name, and department names of all employees.
SELECT employee_id, first_name, last_name, (SELECT department_name FROM departments d WHERE e.department_id = d.department_id) department FROM employees e ORDER BY department;

--Q14--
--Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.
SELECT employee_id, first_name, last_name, salary FROM employees e WHERE salary > (SELECT AVG(salary) FROM employees e1 WHERE e.department_id = e1.department_id);

--Q15--
--Write a query to fetch even numbered records from employees table
SET @i = 0;
SELECT i, employee_id FROM (SELECT @i := @i + 1 AS i, employee_id FROM employees) a WHERE MOD(a.i, 2) = 0;

--Q16--
--Write a query to find the 5th maximum salary in the employees table
SELECT DISTINCT salary FROM employees e WHERE 5 = (SELECT count(DISTINCT salary) FROM employees WHERE salary >= e.salary);

--Q17--
--Write a query to find the 4th minimum salary in the employees table.
SELECT DISTINCT salary FROM employees e1 WHERE 4 = (SELECT COUNT(DISTINCT salary) FROM employees e2 WHERE e2.salary <= e1.salary);

--Q18--
--Write a query to select last 10 records from a table
SELECT * FROM (SELECT * FROM employees ORDER BY employee_id DESC LIMIT 10) emps ORDER BY employee_id ASC;

--Q19--
--Write a query to list the department ID and name of all the departments where no employee is working
SELECT department_id, department_name FROM departments WHERE department_id NOT IN (SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL);

--Q20--
--Write a query to get 3 maximum salaries
SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 3; 
--also
SELECT DISTINCT salary FROM employees e1 WHERE 3 >= (SELECT COUNT(DISTINCT salary) FROM employees e2 WHERE e2.salary >= e1.salary) ORDER BY salary DESC;

--Q21--
--Write a query to get 3 minimum salaries
SELECT DISTINCT salary FROM employees ORDER BY salary ASC LIMIT 3;
--also
SELECT DISTINCT salary FROM employees e1 WHERE 3 >= (SELECT COUNT(DISTINCT salary) FROM employees e2 WHERE e2.salary <= e1.salary) ORDER BY salary ASC;

--Q22--
--Write a query to get 'N' max salaries of employees
SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT N;
--also
SELECT DISTINCT salary FROM employees e1 WHERE N >= (SELECT COUNT(DISTINCT salary) FROM employees e2 WHERE e2.salary >= e1.salary) ORDER by salary DESC; 
--Write a query to get 'Nth' max salaries of employees
SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT N-1, 1; --REPLACE QUANTITY N-1 WITH correct result, cannot perform calc in LIMIT CLAUSE
--also
SELECT DISTINCT salary FROM employees e1 WHERE N = (SELECT COUNT(DISTINCT salary) FROM employees e2 WHERE e2.salary >= e1.salary);

---------------------------------------------------------------------------------------------------------------------------------

--MySQL JOINS--

--Q1--
--Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments
SELECT location_id, street_address, city, state_province, country_name, department_name FROM (departments JOIN locations using (location_id)) JOIN countries USING (country_id) ORDER BY department_id;

--Q2--
--Write a query to find the name (first_name, last name), department ID and name of all the employees
SELECT first_name, last_name, department_id, department_name FROM employees JOIN departments USING (department_id);

--Q3--
--Write a query to find the name (first_name, last_name), job, department ID and name of the employees who works in London
SELECT first_name, last_name, job_id, department_id, department_name, city FROM (employees JOIN departments USING (department_id)) JOIN locations USING (location_id) WHERE city LIKE '%LONDON%';

--Q4--
--Write a query to find the employee id, name (last_name) along with their manager_id and name (last_name)
SELECT e.employee_id employees, e.last_name empname, m.employee_id manager, m.last_name mname FROM employees e JOIN employees m ON (e.manager_id = m.employee_id);

--Q5--
--Write a query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'
SELECT first_name, last_name, hire_date FROM employees e1 WHERE e1.hire_date > ALL(SELECT hire_date FROM employees WHERE last_name LIKE '%JONES%');
--also 
SELECT e1.first_name, e1.last_name, e1.hire_date FROM employees e1 JOIN employees e2 ON (e2.last_name LIKE '%JONES%') WHERE e1.hire_date > e2.hire_date;

--Q6--
--Write a query to get the department name and number of employees in the department
SELECT department_name, COUNT(*) FROM employees JOIN departments USING (department_id) GROUP BY department_id;

--Q7--
--Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90
SELECT employee_id, job_title, end_date-start_date FROM job_history JOIN jobs USING (job_id) WHERE department_id = 90; --DONT THINK THIS IS RIGHT, says 2001-06-17 - 1995-09-17 is 59000? not that many days (or hours or minutes) between them

--Q8--
--Write a query to display the department ID and name and first name of manager
SELECT d.department_id, d.department_name, m.first_name FROM departments d JOIN employees m ON (d.manager_id = m.employee_id);

--Q9--
--Write a query to display the department name, manager name, and city
SELECT d.department_name, m.first_name, m.last_name, l.city FROM (departments d JOIN employees m ON (d.manager_id = m.employee_id)) JOIN locations l USING (location_id);

--Q10--
--Write a query to display the job title and average salary of employees
SELECT job_title, AVG(salary) FROM employees JOIN jobs USING (job_id) GROUP BY job_id;

--Q11--
--Write a query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job.
SELECT job_title, first_name, last_name, salary - min_salary difference FROM employees JOIN jobs USING (job_id);

--Q12--
--Write a query to display the job history that were done by any employee who is currently drawing more than 10000 of salary
SELECT job_history.* FROM employees JOIN job_history USING (employee_id) WHERE salary > 10000;

--Q13--
--Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years
SELECT DISTINCT department_name, first_name, last_name, hire_date, salary, (DATEDIFF(now(), hire_date))/365 EXPERIENCE FROM employees e JOIN departments d ON (d.manager_id = e.employee_id) WHERE DATEDIFF(now(), hire_date)/365 > 15;

---------------------------------------------------------------------------------------------------------------------------------

--MySQL DATETIME--

--Q1--
--Write a query to display the first day of the month (in datetime format) three months before the current month.
SELECT DATE(((PERIOD_ADD(EXTRACT(YEAR_MONTH FROM CURDATE()),-3)*100)+1));

--Q2--
--Write a query to display the last day of the month (in datetime format) three months before the current month
SELECT (SUBDATE(ADDDATE(CURDATE(), INTERVAL -2 MONTH), INTERVAL DAYOFMONTH(CURDATE()) DAY));

--Q3--
--Write a query to get the distinct Mondays from hire_date in employees tables
SELECT DISTINCT(STR_TO_DATE (CONCAT(YEARWEEK(hire_date),'1'),'%x%v%w')) FROM employees;

--Q4--
--Write a query to get the first day of the current year
SELECT MAKEDATE(EXTRACT(YEAR FROM CURDATE()), 1);

--Q5--
--Write a query to get the last day of the current year
SELECT SUBDATE(ADDDATE(CURDATE(), INTERVAL 1 YEAR), INTERVAL DAYOFYEAR(CURDATE())+1 DAY);
--also 
SELECT STR_TO_DATE(CONCAT(12, 31, EXTRACT(YEAR FROM CURDATE())), '%m%d%Y');

--Q6--
--Write a query to calculate the age in year
SELECT YEAR(CURRENT_TIMESTAMP) - YEAR("1967-06-08") - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT("1967-06-08", 5)) as age;

--Q7--
--Write a query to get the current date in the following format.
SELECT DATE_FORMAT(CURDATE(), '%M %e, %Y');

--Q8--
--Write a query to get the current date in Thursday September 2014 format
SELECT DATE_FORMAT(CURDATE(), '%W %M %Y');

--Q9--
--Write a query to extract the year from the current date
SELECT EXTRACT(YEAR FROM CURDATE());

--Q10--
--Write a query to get the DATE value from a given day (number in N)
SELECT FROM_DAYS(N);

--Q11--
--Write a query to get the first name and hire date from employees table where hire date between '1987-06-01' and '1987-07-30'
SELECT first_name, hire_date FROM employees WHERE hire_date BETWEEN '1987-06-01' AND '1987-07-30';

--Q12--
--Write a query to display the current date in the following format: Thursday 4th September 2014 00:00:00
SELECT DATE_FORMAT(CURDATE(), '%W %D %M %Y %T');

--Q13--
--Write a query to display the current date in the following format: 05/09/2014
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');

--Q14--
--Write a query to display the current date in the following format: 12:00 AM Sep 5, 2014
SELECT DATE_FORMAT(CURDATE(), '%l:%i %p %b %e, %Y');

--Q15--
--Write a query to get the firstname, lastname who joined in the month of June
SELECT first_name, last_name, hire_date FROM employees WHERE DATE_FORMAT(hire_date, '%M') LIKE '%JUNE%';

--Q16--
--Write a query to get the years in which more than 10 employees joined
SELECT DATE_FORMAT(hire_date, '%Y'), COUNT(*) FROM employees GROUP BY DATE_FORMAT(hire_date, '%Y') HAVING COUNT(*)> 10;

--Q17--
--Write a query to get first name of employees who joined in 1987
SELECT first_name, hire_date FROM employees WHERE DATE_FORMAT(hire_date, '%Y') LIKE '%1987%';

--Q18--
--Write a query to get department name, manager name, and salary of the manager for all managers whose experience is more than 5 years
SELECT department_name, first_name, last_name, salary, hire_date FROM departments d JOIN employees m ON (d.manager_id = m.employee_id) WHERE (CURDATE()-hire_date)/(24*365) > 5;

--Q19--
--Write a query to get employee ID, last name, and date of first salary of the employees
SELECT employee_id, last_name, hire_date, ADDDATE(hire_date, INTERVAL 1 YEAR) first_salary FROM employees;

--Q20--
--Write a query to get first name, hire date and experience of the employees
SELECT first_name, hire_date, (TO_DAYS(CURDATE())-TO_DAYS(hire_date))/365 EXPERIENCE FROM employees ORDER BY EXPERIENCE DESC;

--Q21--
--Write a query to get the department ID, year, and number of employees joined
SELECT department_id, EXTRACT(YEAR FROM hire_date), COUNT(*) FROM employees GROUP BY department_id, EXTRACT(YEAR FROM hire_date);

----------------------------------------------------------------------------------------------------------------------------------

--MySQL string--

--Q1--
--Write a query to get the job_id and related employee's id
SELECT job_id, GROUP_CONCAT(' ', employee_id) FROM employees GROUP BY job_id;

--Q2--
--Write a query to update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
UPDATE employees SET phone_number = REPLACE(phone_number, '124', '999') WHERE phone_number LIKE "%124%";

--Q3--
--Write a query to get the details of the employees where the length of the first name greater than or equal to 8
SELECT * FROM employees WHERE LENGTH(first_name) >= 8; 

--Q4--
--Write a query to display leading zeros before maximum and minimum salary
SELECT LPAD(max_salary, 7, '0'), LPAD(min_salary, 7, '0') FROM jobs;

--Q5--
--Write a query to append '@example.com' to email field
SELECT CONCAT(email, '@example.com') FROM employees;

--Q6--
--Write a query to get the employee id, first name and hire month
SELECT employee_id, first_name, DATE_FORMAT(hire_date, '%e') 'HIRE MONTH' FROM employees; 
--also
SELECT employee_id, first_name, MID(hire_date, 6, 2) 'HIRE MONTH' FROM employees; --CAN ALSO USE SUBSTR

--Q7--
--Write a query to get the employee id, email id (discard the last three characters)
SELECT employee_id, REVERSE(SUBSTR(REVERSE(email), 4)) email_id FROM employees;

--Q8--
--Write a query to find all employees where first names are in upper case
SELECT * FROM employees WHERE first_name = BINARY UPPER(first_name);

--Q9--
--Write a query to extract the last 4 character of phone numbers
SELECT phone_number, REVERSE(SUBSTR(REVERSE(phone_number), 1, 4)) FROM employees;
--also
SELECT phone_number, RIGHT(phone_number, 4) FROM employees;

--Q10--
--Write a query to get the last word of the street address
SELECT street_address, SUBSTRING_INDEX(REPLACE(REPLACE(REPLACE(street_address, ',', ' '),')', ' '),'(', ' '),' ', -1) last_word FROM locations;

--Q11--
--Write a query to get the locations that have minimum street length
SELECT * FROM locations WHERE LENGTH(street_address) = (SELECT MIN(LENGTH(street_address)) FROM locations);

--Q12--
--Write a query to display the first word from those job titles which contains more than one words
SELECT job_title, SUBSTRING_INDEX(TRIM(job_title), ' ', 1) FROM jobs WHERE TRIM(job_title) LIKE '% %';

--Q13--
--Write a query to display the length of first name for employees where last name contain character 'c' after 2nd position
SELECT LENGTH(first_name) FROM employees WHERE last_name LIKE '%__c%';

--Q14--
--Write a query that displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names
SELECT first_name 'FIRST NAME', LENGTH(first_name) 'NAME LENGTH' FROM employees WHERE SUBSTR(first_name, 1, 1) IN ('A', 'J', 'M') ORDER BY first_name;

--Q15--
--Write a query to display the first name and salary for all employees. Format the salary to be 10 characters long, left-padded with the $ symbol. Label the column SALARY
SELECT first_name, LPAD(salary, 10, '$') SALARY FROM employees;

--Q16--
--Write a query to display the first eight characters of the employees' first names and indicates the amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary.
SELECT SUBSTR(first_name, 1, 8) first_n, LPAD('', salary/1000, '$') wealth FROM employees; 
--also
SELECT LEFT(first_name, 8), REPEAT('$', FLOOR(salary/1000)) 'SALARY($)', salary FROM employees;

--Q17--
--Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year
SELECT employee_id, first_name, last_name, hire_date FROM employees WHERE (EXTRACT(MONTH FROM hire_date) = '7') OR (DAYOFMONTH(hire_date) = '07');
--also
SELECT employee_id,first_name,last_name,hire_date FROM employees WHERE POSITION("07" IN DATE_FORMAT(hire_date, '%d %m'))>0;

----------------------------------------------------------------------------------------------------------------------------------

--END OF MYSQL EXERCISES--

--PRACTICE EXAM--

--Q1--
-- Write a SQL statement to create a table named hr_projects to store the information about the projects being run in the company. Identify to the best of your knowledge proper keys (primary and foreign), the best data types, and any other constraint that should be considered. The table must comprise the following attributes:

	-- project_number: number of the project, it must allow to identify each project uniquely by using this identifier.

	-- project_name: name of the project, it cannot be null.

	-- project_manager: identifies the project manager, it must be one of the existing employees.

	-- project_department: identifies the project department, it must be one of the existing departments.

	-- project_budget: budget of the project (USD currency format).

CREATE TABLE hr_projects(
	project_number INT PRIMARY KEY AUTO_INCREMENT,
	project_name VARCHAR(200) NOT NULL,
	project_manager INT NOT NULL,
	project_department INT,
	project_budget DECIMAL(10, 2),
	FOREIGN KEY (project_manager) REFERENCES employees(employee_id)
	FOREIGN KEY (project_department) REFERENCES departments(department_id)
);

--Q2--
-- Write a SQL statement to:

-- Insert yourself as a new employee in the Employees table. Include only your employee_id (1234), last_name (your lastname), email (your email), hire_date (now as in the system’s date), and job_id (IT_PROG). Do not include any other information nor NULL values in the insert statement.

-- Update your salary and set it to 80,000.

-- Delete yourself from the Employees table (you’re fired!).
INSERT INTO employees(employee_id, last_name, email, hire_date, job_id) VALUES(1234, 'DUBE', 'dubejz', CURDATE(), 'IT_PROG');
UPDATE employees SET salary=80000 WHERE employee_id=1234;
DELETE FROM employees WHERE employee_id = 1234;

--Q3--
--Write a query to show the distinct last names of the employees and how many of them have such same last name, 
--	sort the results according to the count first (bigger count first), and in case of equal count then sort 
--	according to the alphabetical order (A first, Z last).
SELECT last_name, COUNT(*) c FROM employees GROUP BY last_name ORDER BY c DESC, last_name ASC;

--Q4--
--Write a query to show the full name of the employees in a single column (e.g. John Doe), the department name, 
--	and the location (city) for all employees whose job title contains Manager and does not contain Sales.
SELECT CONCAT(first_name, ' ', last_name) 'Full Name', department_name, city 
FROM (
	(employees e JOIN departments d USING (department_id)) 
		JOIN locations USING (location_id)) 
	JOIN jobs USING (job_id) 
WHERE (job_title NOT LIKE '%SALES%') 
		AND (job_title LIKE '%MANAGER%');

--Q5--
--Write a query to show the department name, the department’s manager full name in a single column 
--	(e.g. John Doe), the average salary of all employees working for the department, and the number 
--	of employees of the department. Show only the departments whose manager’s salary is more than 10,000.
SELECT t1.department_name 'DEPT NAME', CONCAT(t1.fn, ' ', t1.ln) 'Full Name', ROUND(t2.avg_sal, 2) 'AVG SALARY', t2.emp_c 'EMP COUNT' 
FROM (SELECT e.first_name fn, e.last_name ln, d.department_id department_id, d.department_name department_name 
	FROM departments d JOIN employees e ON e.employee_id = d.manager_id WHERE e.salary > 10000) AS t1 
JOIN (SELECT e1.department_id, count(*) emp_c, AVG(e1.salary) avg_sal FROM employees e1 GROUP BY e1.department_id) AS t2 
ON t1.department_id = t2.department_id; 

--i hate sql