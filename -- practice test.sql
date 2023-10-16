-- practice test
-- 1. Create a view named EMPLOYEES_PER_COUNTRY_AND_JOB to show for each country and job title the 
-- 		number of employees in that country and job (include 0). Sort the results by the count of employees (descending).
CREATE OR REPLACE VIEW EMPLOYEES_PER_COUNTRY_AND_JOB (country_name, job_title, num_emps) AS (
SELECT c.country_name, j.job_title, 
(SELECT COUNT(employee_id) 
	FROM (((employees e 
		LEFT JOIN departments d
		ON (e.department_id = d.department_id)) 
	JOIN locations USING (location_id))
	JOIN countries USING (country_id))
	JOIN jobs USING (job_id)
	WHERE country_name = c.country_name AND job_title = j.job_title) as cnt
FROM countries c, jobs j
GROUP BY c.country_name, j.job_title
ORDER BY cnt DESC
);

-- 2. Complete the following SQL code:
-- a) Create a function named numberEmployeesByDepartment to calculate the number of employees working in a given 
--		country (including 0). The department_id is provided as the input parameter of the function.
DROP FUNCTION IF EXISTS numberEmployeesByDepartment;
DELIMITER //
CREATE FUNCTION numberEmployeesByDepartment(`p_dept_id` INT) RETURNS INT BEGIN
DECLARE num_emps INT;
SELECT COUNT(e.employee_id) INTO num_emps FROM departments d LEFT JOIN employees e ON (e.department_id = d.department_id) WHERE d.department_id = `p_dept_id` GROUP BY d.department_id;
RETURN num_emps;
END //
DELIMITER ;
-- b) Write a query (calling the function created before) to show for every department how many employees work there.
SELECT department_id, numberEmployeesByDepartment(department_id) FROM departments;

-- 3. Create a trigger to increase 10% the salaries of the employees in a given department every time their department is moved to another country (to cover moving expenses!). An employee transferring to another department does not affect this trigger.
DROP TRIGGER IF EXISTS sal_dept_move;
DELIMITER //
CREATE TRIGGER sal_dept_move
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
DECLARE old_country CHAR(2);
DECLARE new_country CHAR(2);
SELECT country_id INTO old_country FROM countries JOIN locations USING (country_id) WHERE location_id = old.location_id LIMIT 1;
SELECT country_id INTO new_country FROM countries JOIN locations USING (country_id) WHERE location_id = new.location_id LIMIT 1;
IF (old_country <> new_country) THEN
	UPDATE employees SET salary = salary * 1.1 WHERE department_id = new.department_id;
END IF;
END //
DELIMITER ;

-- 4. Complete the following SQL code:
-- a) Create a procedure named SWAP_SALARIES to swap the salaries of two employees whose employee_ids are provided as two input parameters. The procedure will use transactions to protect the correct exchange of salaries. The procedure will have a third output parameter containing the sum of the salaries of the two employees.

DROP PROCEDURE IF EXISTS SWAP_SALARIES;
DELIMITER //
CREATE PROCEDURE SWAP_SALARIES (IN `p_emp_id1` INT , IN `p_emp_id2` INT, OUT `sum_sal` DECIMAL(10, 2)) BEGIN
DECLARE first DECIMAL(10, 2);
DECLARE second DECIMAL(10, 2);
SELECT salary INTO first FROM employees WHERE employee_id = `p_emp_id1`;
SELECT salary INTO second FROM employees WHERE employee_id = `p_emp_id2`;
SET `sum_sal` = first + second;
SET AUTOCOMMIT=off;
START TRANSACTION;
SAVEPOINT s1;
UPDATE employees SET salary = second WHERE employee_id = `p_emp_id1`;

UPDATE employees SET salary = first WHERE employee_id = `p_emp_id2`;

COMMIT;
END//
DELIMITER ;

-- b) Call the procedure using two employees and display the output sum
CALL SWAP_SALARIES(100, 101, @res);
SELECT @res;