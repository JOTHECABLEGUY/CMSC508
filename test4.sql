-- Create a view named SUM_SALARIES_PER_DEPARTMENT_AND_JOB to show for each department name 
--	and job title the sum of the salaries of the employees having that department and job. 
--	Include all possible departments and jobs combinations (including those with $0 sum). 
--	Sort the results by the sum of the salaries (descending).
CREATE OR REPLACE VIEW SUM_SALARIES_PER_DEPARTMENT_AND_JOB (department_name, job_title, sum_sal) AS 
(SELECT d.department_name, j.job_title, 
(SELECT IFNULL(SUM(salary), 0) FROM 
(employees JOIN departments USING (department_id)) JOIN jobs USING (job_id)
WHERE department_name = d.department_name AND job_title = j.job_title
) as sum_sal
FROM departments d, jobs j
ORDER BY sum_sal DESC
);

-- a) (20 points) Create a function named numberEmployeesByCountry to calculate the number of employees 
--		working in a given country. The country_id is provided as the input parameter of the function.
DROP FUNCTION IF EXISTS numberEmployeesByCountry;
DELIMITER //
CREATE FUNCTION numberEmployeesByCountry(`p_country_id` CHAR(2)) RETURNS INT BEGIN
DECLARE num_emps INT;
SELECT COUNT(employee_id) INTO num_emps 
FROM ((employees JOIN departments USING (department_id)) 
JOIN locations USING (location_id))
JOIN countries USING (country_id)
WHERE country_id = `p_country_id`;
RETURN num_emps;
END//
DELIMITER ;

-- b) (5 points) Write a query (calling the function created before) to show for every country 
--		how many employees work there. Sort the results by the number of employees (descending).
SELECT country_name, numberEmployeesByCountry(country_id) cnt FROM countries ORDER BY cnt DESC;

-- Create trigger(s) to increase 10% the salary of an employee when they become the manager of a department.
DROP TRIGGER IF EXISTS inc_man_sal;
DELIMITER //
CREATE TRIGGER inc_man_sal 
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
IF (old.manager_id <> new.manager_id) THEN
UPDATE employees SET salary = salary * 1.1 WHERE employee_id = new.manager_id;
END IF;
END //
DELIMITER ;


-- a) (20 points) Create a procedure named SWAP_EMPLOYEE_MANAGERS 
--		to swap the managers of two employees whose employee_ids are 
--		provided as two input parameters. The procedure will use transactions 
--		to protect the correct exchange of managers. If the swap results in 
--		any of the two employees being their own manager (employee_id = new manager_id) 
--		then abort and undo the changes (you need to make the change and then undo it, 
--		do NOT "precheck" the condition before deciding to make the change). 
--		The procedure will have a third output parameter containing the string "COMPLETED" 
--		or "ABORTED" depending on whether the swap was successful or not.

DROP PROCEDURE IF EXISTS SWAP_EMPLOYEE_MANAGERS;
DELIMITER //
CREATE PROCEDURE SWAP_EMPLOYEE_MANAGERS (IN `p_emp_id1` INT, IN `p_emp_id2` INT, OUT `result` VARCHAR(10)) BEGIN
DECLARE man_1 INT;
DECLARE man_2 INT;
DECLARE new_man_1 INT;
DECLARE new_man_2 INT;
SELECT manager_id INTO man_1 FROM employees WHERE employee_id = `p_emp_id1`;
SELECT manager_id INTO man_2 FROM employees WHERE employee_id = `p_emp_id2`;
SET AUTOCOMMIT = off;
START TRANSACTION;
SAVEPOINT sp1;
UPDATE employees SET manager_id = man_2 WHERE employee_id = `p_emp_id1`;
UPDATE employees SET manager_id = man_1 WHERE employee_id = `p_emp_id2`;
SELECT manager_id INTO new_man_1 WHERE employee_id = `p_emp_id1`;
SELECT manager_id INTO new_man_2 WHERE employee_id = `p_emp_id2`;
IF (new_man_1 = `p_emp_id1`) THEN
SET `result` = "ABORTED";
ROLLBACK TO SAVEPOINT sp1;
ELSEIF (new_man_2 = `p_emp_id2`) THEN
SET `result` = "ABORTED";
ROLLBACK TO SAVEPOINT sp1;
ELSE
SET `result` = "COMPLETED";
COMMIT;
END IF;
SET AUTOCOMMIT = on;
END //
DELIMITER ;

-- b) (5 points) Call the procedure using two examples, one where the operation is 
--		successful (employee_ids 102 and 104) and another where the operation is aborted 
--		(employee_ids 114 and 115). Show the output message after calling the procedure using the respective examples.

CALL SWAP_EMPLOYEE_MANAGERS(102, 104, @res1);
SELECT @res1;

CALL SWAP_EMPLOYEE_MANAGERS(114, 115, @res2);
SELECT @res2;
