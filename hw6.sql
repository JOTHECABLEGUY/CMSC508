-- Functions and procedures

-- 1. Create a function to return the manager’s full name for an employee 
--		whose employee_id is provided as input parameter.
	DROP FUNCTION IF EXISTS get_manager_full_name;
	DELIMITER //
	CREATE FUNCTION get_manager_full_name (`p_emp_id` INT) RETURNS VARCHAR(50)
	BEGIN
	DECLARE var VARCHAR(50);
	SELECT CONCAT(m.first_name, ' ', m.last_name) INTO var FROM employees e JOIN employees m ON (m.employee_id = e.manager_id) WHERE e.employee_id = `p_emp_id`;
	RETURN IFNULL(var, "NO MANAGER");
	END//
	DELIMITER ;

-- 2. Create a function called format_phone. It will format the input 
--		argument 123.456.7890 so that it looks like a U.S. phone number (123) 456-7890.
	DROP FUNCTION IF EXISTS format_phone;
	DELIMITER //
	CREATE FUNCTION format_phone(`p_phone_number` CHAR(12)) RETURNS CHAR(14)
	BEGIN
	RETURN CONCAT('(', SUBSTR(`p_phone_number`, 1,3),') ', SUBSTR(`p_phone_number`, 5, 3), '-', SUBSTR(`p_phone_number`, 9, 4));
	END //
	DELIMITER ;

-- 3. Create a function to return the median salary for a department_id 
-- 		provided as input parameter.
	DROP FUNCTION IF EXISTS
	    dept_median_salary;
	DELIMITER
	    //
	CREATE FUNCTION dept_median_salary(`p_dept_id` INT) RETURNS DECIMAL(10, 2) BEGIN
	    DECLARE
	        emp_count INT ; 
	    DECLARE 
	    	median DECIMAL(10, 2) ;
	    SET @row_index := -1;
		SELECT AVG(t1.salary) INTO median
		FROM (
			SELECT (@row_index := @row_index + 1) as row_i, salary
			FROM employees
			WHERE department_id = `p_dept_id`
			ORDER BY salary ASC
			) AS t1
		WHERE t1.row_i IN (CEIL(t1.row_i / 2), FLOOR(t1.row_i / 2));
		RETURN IFNULL(median, 0.00) ;
	END//
	DELIMITER ;

-- 4. Create a procedure to increase (increase_pct as parameter) the 
-- 		salary of the manager whose subordinate employee_id is provided as input parameter.
	DROP PROCEDURE IF EXISTS increase_manager_salary;
	DELIMITER //
	CREATE PROCEDURE increase_manager_salary(`p_increase_pct` DECIMAL(5, 3), `p_employee_id` INT) BEGIN
	DECLARE man_id INT;
	SELECT m.employee_id INTO man_id FROM employees e JOIN employees m WHERE (e.manager_id = m.employee_id AND e.employee_id = `p_employee_id`);
	UPDATE employees SET salary = salary * (1+`p_increase_pct`) WHERE employee_id = man_id;
	END //
	DELIMITER ;

-- 5. Create a procedure to create a table with the department name, the department’s 
--		manager full name and the number of employees working for that department.
	DROP PROCEDURE IF EXISTS create_dept_table;
	DELIMITER //
	CREATE PROCEDURE create_dept_table(`p_dept_id` INT) BEGIN
	DECLARE dept_name VARCHAR(50);
	DECLARE man_name VARCHAR(50);
	DECLARE num_emps INT;
	SELECT d.department_name INTO dept_name FROM departments d WHERE d.department_id = `p_dept_id`;
	SELECT CONCAT(m.first_name, ' ', m.last_name) INTO man_name FROM departments d JOIN employees m WHERE d.department_id = `p_dept_id` AND m.employee_id = d.manager_id;
	SELECT t1.cnt INTO num_emps FROM (SELECT e.department_id, COUNT(e.employee_id) as cnt FROM employees e GROUP BY e.department_id) as t1 WHERE t1.department_id = `p_dept_id`;
	DROP TABLE IF EXISTS new_table;
	CREATE TABLE IF NOT EXISTS new_table(`department_name` VARCHAR(50), `manager_name` VARCHAR(50), `num_employees` INT);
	INSERT INTO new_table (`department_name`, `manager_name`, `num_employees`) VALUES(dept_name, man_name, num_emps);
	END //
	DELIMITER ;

-- 6. Create a procedure to increase 10% the salary of all subordinates in a department, 
--		do it as many times as necessary, until the average salary difference between 
--		managers and their subordinates in the department is smaller than 5%. 
	DROP PROCEDURE IF EXISTS reduce_sal_diff;
	DELIMITER //
	CREATE PROCEDURE IF NOT EXISTS reduce_sal_diff(`p_dept_id` INT) BEGIN
	DECLARE sub_avg DECIMAL(10, 2);
	DECLARE man_avg DECIMAL(10, 2);
	DECLARE pct DECIMAL(5, 3);
	DECLARE emp_id INT;
	DECLARE done INT DEFAULT FALSE;
	DECLARE cur CURSOR FOR SELECT e.employee_id FROM employees m JOIN employees e ON (e.manager_id = m.employee_id) WHERE (m.department_id = `p_dept_id` AND e.department_id = `p_dept_id`);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	CREATE TEMPORARY TABLE mytable(employee_id INT);
	OPEN cur;
	WHILE NOT done DO
		FETCH cur INTO emp_id;
		INSERT INTO mytable (employee_id) VALUES(emp_id);
	END WHILE;
	CLOSE cur;
	SELECT AVG(t1.salary) INTO man_avg FROM (SELECT m.salary FROM employees m JOIN employees e ON (e.manager_id = m.employee_id) WHERE m.department_id = `p_dept_id` AND e.department_id = `p_dept_id`) AS t1;
	SELECT AVG(t2.salary) INTO sub_avg FROM (SELECT e.salary FROM employees e JOIN employees m ON (e.manager_id = m.employee_id) WHERE m.department_id = `p_dept_id` AND e.department_id = `p_dept_id`) AS t2;
	SET pct = (man_avg-sub_avg)/man_avg;
	WHILE pct > 0.05 DO 
		UPDATE employees 
		SET salary = salary * 1.1
		WHERE employee_id IN 
			(SELECT employee_id FROM mytable);
		SELECT AVG(t1.salary) INTO man_avg FROM (SELECT m.salary FROM employees m JOIN employees e ON (e.manager_id = m.employee_id) WHERE m.department_id = `p_dept_id` AND e.department_id = `p_dept_id`) AS t1;
		SELECT AVG(t2.salary) INTO sub_avg FROM (SELECT e.salary FROM employees e JOIN employees m ON (e.manager_id = m.employee_id) WHERE m.department_id = `p_dept_id` AND e.department_id = `p_dept_id`) AS t2;
		SET pct = (man_avg-sub_avg)/man_avg;
	END WHILE;
	DROP TEMPORARY TABLE mytable;
	END //
	DELIMITER ;

-- 2020 function test question: Create a function named employeesCountry to calculate the number of employees
-- 	working in a given country (including 0). The country_id is provided as the input
-- 	parameter of the function.
	DROP FUNCTION IF EXISTS employeesCountry;
	DELIMITER //
	CREATE FUNCTION employeesCountry (`p_country_id` CHAR(2)) RETURNS INT BEGIN
	DECLARE emp_cnt INT;
	SELECT COUNT(employee_id) INTO emp_cnt FROM 
		((countries 
		JOIN locations USING (country_id)) 
		JOIN departments USING (location_id))
		JOIN employees USING (department_id) 
	WHERE country_id = `p_country_id`;
	RETURN emp_cnt;
	END //
	DELIMITER ;

-- Write a query (calling the function created before) to show for every country how many employees work there.
	SELECT country_id, country_name, employeesCountry(country_id) FROM countries;


-- 2020 procedure test question: Create a procedure named INCREASE SALARY SUPERVISORS. The procedure will
-- 	increase the salary of each employee as follows:
--	10% if the employee supervises one employee.
--	15% if the employee supervises two employees.
--	20% if the employee supervises three or more employees.

--	The procedure will return an output parameter containing the sum of all of the salary
--	increases.
	DROP PROCEDURE IF EXISTS `INCREASE SALARY SUPERVISORS`;
	DELIMITER //
	CREATE PROCEDURE `INCREASE SALARY SUPERVISORS`(OUT sum_of_increases DECIMAL(10,2)) BEGIN
	DECLARE num_subs INT;
	DECLARE emp_id INT;
	DECLARE inc DECIMAL(10,2);
	DECLARE done INT default FALSE;
	DECLARE cur CURSOR FOR SELECT employee_id FROM employees;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = True;
	SET sum_of_increases = 0;
	OPEN cur;
	WHILE NOT done DO
	FETCH cur INTO emp_id;
	SELECT COUNT(e.employee_id) INTO num_subs 
		FROM employees e 
		JOIN employees m ON (e.manager_id = m.employee_id);
	IF num_subs = 1 THEN 
		SELECT salary*0.1 INTO inc FROM employees WHERE employee_id = emp_id;
		SET sum_of_increases = sum_of_increases + inc;
		UPDATE employees SET salary = salary + inc WHERE employee_id = emp_id;
	ELSEIF num_subs = 2 THEN
		SELECT salary*0.15 INTO inc FROM employees WHERE employee_id = emp_id;
		SET sum_of_increases = sum_of_increases + inc;
		UPDATE employees SET salary = salary + inc WHERE employee_id = emp_id;
	ELSEIF num_subs > 2 THEN
		SELECT salary*0.2 INTO inc FROM employees WHERE employee_id = emp_id;
		SET sum_of_increases = sum_of_increases + inc;
		UPDATE employees SET salary = salary + inc WHERE employee_id = emp_id;
	END IF;
	END WHILE;
	END//
	DELIMITER ;

--	Execute the procedure print the output value.
	CALL `INCREASE SALARY SUPERVISORS`(@res);
	SELECT @res;



--		TRIGGERS

-- 1. Create a trigger to prevent having employees whose salary is bigger than their
--		manager (or the president's salary if they have no manager). Consider all scenarios.
	DROP TRIGGER IF EXISTS insert_sub_sal_check_trigger;
	DROP TRIGGER IF EXISTS update_sub_sal_check_trigger;
	DROP TRIGGER IF EXISTS update_man_sal_check_trigger;
	DELIMITER //
	CREATE TRIGGER insert_sub_sal_check_trigger 
	BEFORE INSERT ON employees
	FOR EACH ROW
	BEGIN
	DECLARE man_sal DECIMAL(10,2);
	SELECT m.salary INTO man_sal FROM employees m WHERE IFNULL(new.manager_id, 100) = m.employee_id;
	IF (new.salary > man_sal) THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'invalid salary, cannot be bigger than manager\'s or president\'s salary.';
	END IF;
	END//
	DELIMITER ;

	DELIMITER //
	CREATE TRIGGER update_sub_sal_check_trigger
	BEFORE UPDATE ON employees
	FOR EACH ROW
	BEGIN
	DECLARE man_sal DECIMAL(10,2);
	SELECT m.salary INTO man_sal FROM employees m WHERE IFNULL(new.manager_id, 100) = m.employee_id;
	IF (new.salary > man_sal AND new.employee_id != 100) THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'invalid salary, cannot be bigger than manager\'s or president\'s salary.';
	END IF;
	END//
	DELIMITER ;

	DELIMITER //
	CREATE TRIGGER update_man_sal_check_trigger
	BEFORE UPDATE ON employees
	FOR EACH ROW
	BEGIN
	DECLARE max_sub_sal DECIMAL(10,2);
	SELECT MAX(e.salary) INTO max_sub_sal FROM employees e WHERE e.manager_id = new.employee_id;
	IF (new.salary < max_sub_sal) THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'invalid change, cannot be manager\'s salary must be above their subordinates\'.';
	END IF;
	END//
	DELIMITER ;

-- 2. Create a table for projects (title, manager, duration (days), cost), and check that the
--		cost must be < 1000 per day nor bigger than the sum of the salaries of the
--		department employees the manager works for. Consider all scenarios.
	DROP TABLE IF EXISTS projects;
	CREATE TABLE IF NOT EXISTS projects(title VARCHAR(30) PRIMARY KEY, 
										manager INT,
										duration INT,
										cost DECIMAL(10,2),
										FOREIGN KEY (manager) REFERENCES employees(employee_id));
	DROP TRIGGER IF EXISTS insert_cost_trigger;
	DELIMITER //
	CREATE TRIGGER insert_cost_trigger
	BEFORE INSERT ON projects
	FOR EACH ROW
	BEGIN
	IF new.cost/new.duration >= 1000 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid cost. Cost per day must be less than $1000';
	END IF;
	IF new.cost > (SELECT SUM(salary) 
					FROM employees 
					WHERE department_id = 
						(SELECT department_id
						FROM employees WHERE employee_id = new.manager)) 
	THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid cost. Cost must not be bigger than the sum of the salaries of the department employees the manager works for';
	END IF;
	END //
	DELIMITER ;

	DROP TRIGGER IF EXISTS update_cost_trigger;
	DELIMITER //
	CREATE TRIGGER update_cost_trigger
	BEFORE UPDATE ON projects
	FOR EACH ROW
	BEGIN
	IF new.cost > (SELECT SUM(salary) 
					FROM employees 
					WHERE department_id = 
						(SELECT department_id
						FROM employees WHERE employee_id = new.manager)) 
	THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid operation. Cost must not be bigger than the sum of the salaries of the department employees the manager works for';
	END IF;
	IF new.cost/new.duration >= 1000 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid operation. Cost per day must be less than $1000';
	END IF;
	END //
	DELIMITER ;

	DROP TRIGGER IF EXISTS update_emp_trigger;
	DELIMITER //
	CREATE TRIGGER update_emp_trigger
	BEFORE UPDATE ON employees
	FOR EACH ROW
	BEGIN
	IF (SELECT SUM(salary) - old.salary + new.salary
			FROM employees 
			WHERE department_id = 
				(SELECT department_id
				FROM employees WHERE employee_id = new.manager_id)
		<
		(SELECT IFNULL(MAX(cost), 0) 
			FROM projects 
			WHERE manager = 
				(SELECT manager_id FROM departments WHERE department_id = new.department_id)))
	THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid operation. Cost per day must not be bigger than the sum of the salaries of the department employees the manager works for';
	END IF;
	END //

	DROP TRIGGER IF EXISTS insert_emp_trigger;
	DELIMITER //
	CREATE TRIGGER insert_emp_trigger
	BEFORE INSERT ON employees
	FOR EACH ROW
	BEGIN
	IF (SELECT SUM(salary) + new.salary
			FROM employees 
			WHERE department_id = 
				(SELECT department_id
				FROM employees WHERE employee_id = new.manager_id)
		<
		(SELECT IFNULL(MAX(cost), 0) 
			FROM projects 
			WHERE manager = 
				(SELECT manager_id FROM departments WHERE department_id = new.department_id)))
	THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid operation. Cost per day must not be bigger than the sum of the salaries of the department employees the manager works for';
	END IF;
	END //

-- 3. Create a new table to keep the count of the number of subordinates of an employee.
--		Create a trigger to keep this table up to date. Remove from this table the data of the
-- 		employee if fired. Consider all scenarios.
	DROP TABLE IF EXISTS subordinates;
	CREATE TABLE subordinates(employee INT PRIMARY KEY, num_subs INT DEFAULT 0);

	DROP TRIGGER IF EXISTS insert_emp_trigger;
	DELIMITER //
	CREATE TRIGGER insert_emp_trigger
	AFTER INSERT ON employees
	FOR EACH ROW
	BEGIN
	IF new.manager_id NOT IN (SELECT employee FROM subordinates) THEN
	INSERT INTO subordinates (employee, num_subs) VALUES(new.manager_id, 1);
	ELSE
	UPDATE subordinates SET num_subs = num_subs + 1 WHERE employee = new.manager_id;
	END IF;
	END//
	DELIMITER ;

	DROP TRIGGER IF EXISTS update_emp_trigger;
	DELIMITER //
	CREATE TRIGGER update_emp_trigger
	AFTER UPDATE ON employees
	FOR EACH ROW
	BEGIN
	IF new.manager_id <> old.manager_id THEN 
		IF new.manager_id NOT IN (SELECT employee FROM subordinates) THEN
			INSERT INTO subordinates (employee, num_subs) VALUES(new.manager_id, 1);
		ELSE
			UPDATE subordinates SET num_subs = num_subs + 1 WHERE employee = new.manager_id;
		END IF;
		UPDATE subordinates SET num_subs = num_subs - 1 WHERE employee = old.manager_id;
	END IF;
	END//
	DELIMITER ;

	DROP TRIGGER IF EXISTS delete_emp_trigger;
	DELIMITER //
	CREATE TRIGGER delete_emp_trigger
	AFTER DELETE ON employees
	FOR EACH ROW
	BEGIN
	UPDATE subordinates SET num_subs = num_subs - 1 WHERE employee = old.manager_id;
	DELETE FROM subordinates WHERE employee = old.employee_id;
	END//
	DELIMITER ; 

-- 4. Create a new log table and a trigger to keep track of any changes to the employees
-- 		table. The table schema should be (log_event_id, date, description) and the contents
--		should look as e.g. (1234, 04/05/17, "Employee 123 updated salary from 5000 to
--		10000"). Track salaries, managers, departments, and jobs.
	DROP TABLE IF EXISTS emp_log;
	CREATE TABLE emp_log(log_event_id INT AUTO_INCREMENT, 
						`date` DATE, 
						description VARCHAR(200),
	                    PRIMARY KEY (log_event_id)); 
	DROP TRIGGER IF EXISTS insert_emp_trigger;
	DELIMITER //
	CREATE TRIGGER insert_emp_trigger
	AFTER INSERT ON employees
	FOR EACH ROW
	BEGIN
	INSERT INTO emp_log (`date`, description) VALUES (CURDATE(), 
		CONCAT('Employee ', new.employee_id, ' inserted into log 
			table with salary ', ROUND(new.salary, 0), ' manager ',
			new.manager_id, ' department ', new.department_id, ' 
			job ', job_id));
	END//
	DELIMITER ;

	DROP TRIGGER IF EXISTS update_emp_trigger;
	DELIMITER //
	CREATE TRIGGER update_emp_trigger
	AFTER UPDATE ON employees
	FOR EACH ROW
	BEGIN

	IF (old.salary <> new.salary) THEN
	INSERT INTO emp_log (`date`, description) VALUES (CURDATE(), 
		CONCAT('Employee ', new.employee_id, ' updated salary from ', ROUND(old.salary, 0), 
			' to ', ROUND(new.salary, 0)));
	END IF;

	IF (old.manager_id <> new.manager_id) THEN
	INSERT INTO emp_log (`date`, description) VALUES (CURDATE(), 
		CONCAT('Employee ', new.employee_id, ' updated manager from ', old.manager_id, 
			' to ', new.manager_id));
	END IF;

	IF (old.department_id <> new.department_id) THEN
	INSERT INTO emp_log (`date`, description) VALUES (CURDATE(), 
		CONCAT('Employee ', new.employee_id, ' updated department from ', old.department_id, 
			' to ', new.department_id));
	END IF;

	IF (old.job_id <> new.job_id) THEN
	INSERT INTO emp_log (`date`, description) VALUES (CURDATE(), 
		CONCAT('Employee ', new.employee_id, ' updated department from ', old.job_id, 
			' to ', new.job_id));
	END IF;
	END//
	DELIMITER ;

	DROP TRIGGER IF EXISTS delete_emp_trigger;
	DELIMITER //
	CREATE TRIGGER delete_emp_trigger
	AFTER DELETE ON employees
	FOR EACH ROW
	BEGIN
	INSERT INTO emp_log (`date`, description) VALUES (CURDATE(), 
		CONCAT('Employee ', old.employee_id, ' deleted from log 
			table with salary'));
	END//
	DELIMITER ;


-- 		VIEWS

-- 1. Create a function to compute the average of the salaries for a given department_id defined as
--		input parameter of the function. Then, create a view named department_statistics as the result
--		of a query collecting for every department: the department name, name of the department
--		manager (in the form "F. LastName" where F. is the first letter of the first name), the number of
--		employees working for the department, the lowest and highest salary of its employees, and the
--		average of the salaries (as a result of the call of the function you created first). Include in the
--		view departments not having any employee and display 0 rather than NULL when necessary.
DROP FUNCTION IF EXISTS avg_sals;
DROP VIEW IF EXISTS department_statistics;
DELIMITER //
CREATE FUNCTION avg_sals(`p_dept_id` INT) RETURNS DECIMAL(10, 2)
BEGIN
DECLARE average DECIMAL(10, 2);
SELECT AVG(salary) INTO average FROM employees WHERE department_id = `p_dept_id`;
RETURN IFNULL(average, 0);
END//
DELIMITER ;

CREATE VIEW department_statistics (dept_id, dept_name, man_name, num_emps, min_sal, max_sal, avg_sal) AS
(SELECT DISTINCT d.department_id as dept_id,
 		d.department_name as dept_name, 
		IFNULL(CONCAT(SUBSTR(m.first_name, 1, 1), '. ', m.last_name), "NO MANAGER") AS man_name,
		(SELECT COUNT(e.employee_id) FROM employees e WHERE e.department_id = d.department_id) AS num_emps,
		(SELECT IFNULL(MIN(e.salary), 0) FROM employees e WHERE e.department_id = d.department_id) AS min_sal,
		(SELECT IFNULL(MAX(e.salary), 0) FROM employees e WHERE e.department_id = d.department_id) AS max_sal,
		avg_sals(d.department_id) AS avg_sal
FROM
	employees m RIGHT JOIN departments d ON (m.employee_id = d.manager_id) ORDER BY num_emps DESC);


-- 2. Create a view to find for each department the largest salary difference between any two
--		employees within the department.
DROP VIEW IF EXISTS dept_sal_diff;
CREATE VIEW dept_sal_diff (dept_id, max_sal, min_sal, largest_sal_diff) AS
(SELECT department_id, MAX(salary)-MIN(salary)
	FROM employees
	GROUP BY department_id);

-- 3. Create a view to find the number of departments in each region, including regions with 0
--		departments (show 0) and departments with no regions assigned (show 'NO REGION').
DROP VIEW IF EXISTS depts_region;
CREATE VIEW depts_region (region_name, num_depts) AS
(SELECT r.region_name, COUNT(department_id) as cnt FROM
	regions r LEFT JOIN 
	((departments d JOIN locations l USING (location_id))
	JOIN countries c USING (country_id)) ON (r.region_id = c.region_id)
    GROUP BY r.region_name)
UNION
SELECT "NO REGION", (SELECT COUNT(department_id) FROM departments) - (SELECT COUNT(department_id) FROM departments JOIN locations USING (location_id) JOIN countries USING (country_id) JOIN regions USING (region_id)) as cnt;

-- 4. Create a procedure protected with a transaction to steal a percentage of the salary of the
--		employees and transfer the money to the president's salary. If the president's new salary is
--		bigger than $100k undo the changes.
DROP PROCEDURE IF EXISTS steal;
DELIMITER //
CREATE PROCEDURE steal(`p_pct` DECIMAL(5,3))
BEGIN
DECLARE sal DECIMAL(10, 2);
DECLARE money_to_steal DECIMAL(10, 2);
DECLARE emp_id INT;
DECLARE done INT DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT employee_id FROM employees WHERE employee_id != 100;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
START TRANSACTION;
SAVEPOINT p1;
OPEN cur;
WHILE NOT done DO
FETCH cur INTO emp_id;
SET sal = (SELECT salary FROM employees WHERE employee_id = emp_id);
SET money_to_steal = sal * `p_pct`;
UPDATE employees SET salary = salary - money_to_steal WHERE employee_id = emp_id;
UPDATE employees SET salary = salary + money_to_steal WHERE employee_id = 100;
END WHILE;
IF (SELECT salary FROM employees WHERE employee_id = 100) > 120000 THEN
ROLLBACK TO SAVEPOINT p1;
ELSE COMMIT;
END IF;
CLOSE cur;
END//
DELIMITER ;
