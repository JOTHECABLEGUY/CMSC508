create table projects (
project_id int(6) primary key,
department_id int(4),
foreign key (department_id) references departments (department_id) on update cascade on delete cascade
);

insert into departments values (1234, 'New department', null, null);

insert into projects values (987, 1234);

select * from projects;

update departments set department_id = 1235 where department_id = 1234;

select * from projects;

delete from departments where department_id = 1235; -- removes department 1235 and all projects associated with such department

select * from projects;

drop table projects;




create table projects (
project_id int(6) primary key,
department_id int(4),
foreign key (department_id) references departments (department_id) on delete set null
);

insert into departments values (1234, 'New department', null, null);
insert into projects values (987, 1234);

select * from projects;

delete from departments where department_id = 1234;

select * from projects;

drop table projects;





EXPLAIN SELECT * FROM employees WHERE first_name = 'John';

CREATE INDEX emp_first_name_ix ON employees(first_name);

EXPLAIN SELECT * FROM employees WHERE first_name = 'John';

ALTER TABLE employees DROP INDEX emp_first_name_ix;




DROP FUNCTION IF EXISTS getNameOfPresident;
DELIMITER //
CREATE FUNCTION getNameOfPresident() RETURNS VARCHAR(255)
BEGIN 
	DECLARE v_name varchar(255);
 
 	SELECT CONCAT(first_name, ' ', last_name) INTO v_name
 	FROM employees 
 	WHERE employee_id = '100';
 
 	RETURN v_name;
END//
DELIMITER ;

getNameOfPresident(); -- nope, this is a function
select * from getNameOfPresident; -- nope, this is a function
select getNameOfPresident() from dual; -- yesss
select getNameOfPresident() from employees; -- the function is called once PER ROW in employees


DROP FUNCTION IF EXISTS getNameOfEmployee;
DELIMITER //
CREATE FUNCTION getNameOfEmployee(p_emp_id  INT) RETURNS VARCHAR(255)
BEGIN 
DECLARE v_name varchar(255);
DECLARE v_text    varchar(255); 

SELECT CONCAT(first_name, ' ', last_name) INTO v_name
FROM employees 
WHERE employee_id = p_emp_id;
 
SET v_text = CONCAT ('Name of employee is ', v_name);
RETURN v_text;
END//
DELIMITER ;


select getNameOfEmployee(employee_id) from employees;



DROP FUNCTION IF EXISTS salaryDifference;
DELIMITER //
CREATE FUNCTION salaryDifference(p_emp_id  INT) RETURNS FLOAT
BEGIN 

DECLARE v_difference FLOAT;

SELECT ABS(e.salary - m.salary) INTO v_difference
FROM employees e JOIN employees m
ON e.manager_ID = m.employee_ID
WHERE e.employee_id = p_emp_id;

RETURN v_difference;
END//
DELIMITER ;


select employee_id, salaryDifference(employee_id) from employees;
select salaryDifference(100) from dual;



DROP PROCEDURE IF EXISTS getSalary;
DELIMITER //
CREATE PROCEDURE getSalary (IN p_employee_id INT, OUT p_salary VARCHAR(255))
BEGIN
    SELECT concat('USD ', format(salary,2)) INTO p_salary
     FROM employees WHERE employee_id = p_employee_id;
END//
DELIMITER ;

CALL getSalary (100, @salary);
SELECT @salary;



DROP PROCEDURE IF EXISTS IncreaseSalary;
DELIMITER //
CREATE PROCEDURE IncreaseSalary ( IN p_employee_id INT, IN p_increment_pct FLOAT )
BEGIN 
     UPDATE employees SET salary = salary * (1 + p_increment_pct)
     WHERE employee_id = p_employee_id;
END//
DELIMITER ;

CALL IncreaseSalary (100, 0.1);



DROP PROCEDURE IF EXISTS IncreaseSalaryReturn;
DELIMITER //
CREATE PROCEDURE IncreaseSalaryReturn  ( IN p_employee_id INT,
						 		 IN p_increment_pct FLOAT,
								 OUT p_new_salary DECIMAL(8,2))
BEGIN 
     SELECT salary INTO p_new_salary
     FROM employees WHERE employee_id = p_employee_id;
     SET p_new_salary  = p_new_salary  * (1 + p_increment_pct);
     UPDATE employees SET salary = p_new_salary 
     WHERE employee_id = p_employee_id;
END//
DELIMITER ;

CALL IncreaseSalaryReturn (100, 0.1, @newsal);
SELECT @newsal AS newsalary;





DROP PROCEDURE IF EXISTS getEmployeeLevel;
DELIMITER //
CREATE PROCEDURE getEmployeeLevel( IN  p_employee_id INT, OUT p_level VARCHAR(20))
BEGIN
    DECLARE v_salary DECIMAL(8,2);

    SELECT salary INTO v_salary
    FROM employees
    WHERE employee_id = p_employee_id;

    IF v_salary > 20000 THEN
        SET p_level = 'PLATINUM';
    ELSEIF v_salary > 10000 THEN
        SET p_level = 'GOLD';
    ELSE
    	SET p_level = 'SILVER';
    END IF;
END//
DELIMITER ;


CALL getEmployeeLevel(200, @level);
SELECT @level;




DROP PROCEDURE IF EXISTS countDaysHired;
DELIMITER //
CREATE PROCEDURE countDaysHired(IN p_employee_id INT, OUT p_days INT)
BEGIN
    DECLARE v_hire_date DATE;

    SELECT hire_date INTO v_hire_date
    FROM employees
    WHERE employee_id = p_employee_id;

    SET p_days = 0;

    WHILE v_hire_date < CURDATE() DO
      SET p_days = p_days + 1;
      SET v_hire_date = DATE_ADD(v_hire_date, INTERVAL 1 DAY);
    END WHILE;
END//
DELIMITER ;


CALL countDaysHired(100, @days);
SELECT @days;





DROP PROCEDURE IF EXISTS getEmployeeNames;
DELIMITER //
CREATE PROCEDURE getEmployeeNames (IN p_department_id INT)
BEGIN

	DECLARE v_employee_name VARCHAR(255);
	DECLARE v_employee_names VARCHAR(4096);
	DECLARE done INT DEFAULT FALSE;
	DECLARE cur CURSOR FOR SELECT CONCAT(first_name, ' ', last_name) FROM employees WHERE department_id = p_department_id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET v_employee_names = '';

    OPEN cur;
    myloop: LOOP
        FETCH cur INTO v_employee_name;
        IF done THEN
	    	LEAVE myloop;
	    END IF;
	    SET v_employee_names = CONCAT (v_employee_name, ', ' , v_employee_names);
    END LOOP;

    CLOSE cur;

    SELECT v_employee_names;
END//
DELIMITER ;

CALL getEmployeeNames(30);




DROP PROCEDURE IF EXISTS sumSalaries;
DELIMITER //
CREATE PROCEDURE sumSalaries ()
BEGIN

	DECLARE v_salary_low_sum   decimal(12,2) DEFAULT 0;
	DECLARE v_salary_high_sum  decimal(12,2) DEFAULT 0;
	DECLARE v_salary  decimal(8,2) DEFAULT 0;
	DECLARE done INT DEFAULT FALSE;
	DECLARE cur CURSOR FOR SELECT salary FROM employees;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    myloop: LOOP
        FETCH cur INTO v_salary;
        IF done THEN
	    	LEAVE myloop;
	    END IF;
	    IF v_salary > 10000 THEN
	    	SET v_salary_high_sum = v_salary_high_sum + v_salary;
	    ELSE
	    	SET v_salary_low_sum = v_salary_low_sum + v_salary;
	    END IF;
    END LOOP;

    CLOSE cur;

    SELECT CONCAT('Sum salaries >= $10k = ' , v_salary_high_sum, ' Sum salaries < $10k = ', v_salary_low_sum);
END//
DELIMITER ;

CALL sumSalaries();




DROP PROCEDURE IF EXISTS tempTableSumSalaries;
DELIMITER //
CREATE PROCEDURE tempTableSumSalaries ()
BEGIN

	DECLARE v_salary_low_sum   decimal(12,2) DEFAULT 0;
	DECLARE v_salary_high_sum  decimal(12,2) DEFAULT 0;
	DECLARE v_salary  decimal(8,2) DEFAULT 0;
	DECLARE done INT DEFAULT FALSE;
	DECLARE cur CURSOR FOR SELECT salary FROM employees;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	CREATE TEMPORARY TABLE mytemptable (
		higher_sal float,
		lower_sal  float
	);

    INSERT INTO mytemptable VALUES (0,0);

    OPEN cur;

    myloop: LOOP
        FETCH cur INTO v_salary;
        IF done THEN
	    	LEAVE myloop;
	    END IF;
	    IF v_salary > 10000 THEN
	    	UPDATE mytemptable SET higher_sal = higher_sal + v_salary;
	    ELSE
	    	UPDATE mytemptable SET lower_sal = lower_sal + v_salary;
	    END IF;
    END LOOP;
    CLOSE cur;

    SELECT higher_sal, lower_sal INTO v_salary_high_sum, v_salary_low_sum FROM mytemptable;
    SELECT CONCAT('Sum salaries >= $10k = ' , v_salary_high_sum, ' Sum salaries < $10k = ', v_salary_low_sum);

    DROP TEMPORARY TABLE mytemptable;
END//
DELIMITER ;

CALL tempTableSumSalaries();




Complete the following SQL code:

a) (20 points) Create a function named employeesCountry to calculate the number of employees working in a given country (including 0). The country_id is provided as the input parameter of the function.
b) (5 points) Write a query (calling the function created before) to show for every country how many employees work there.

DROP FUNCTION IF EXISTS `employeesCountry`;
DELIMITER //
CREATE FUNCTION `employeesCountry` (`p_country_id` CHAR(2)) RETURNS INT
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
	FROM employees
	LEFT JOIN departments USING(department_id)
	LEFT JOIN locations USING(location_id)
	LEFT JOIN countries USING(country_id)
	WHERE country_id = p_country_id;

	RETURN v_count;

END//
DELIMITER ;

SELECT country_name, employeesCountry(country_id) FROM countries;





(25 points) Create a procedure named INCREASE_SALARY_SUPERVISORS.
The procedure will increase the salary of each employee as follows:
10% if the employee supervises one employee.
15% if the employee supervises two employees.
20% if the employee supervises three or more employees.
The procedure will return an output parameter containing the sum of all of the salary increases.
Execute the procedure print the output value.


DROP PROCEDURE IF EXISTS INCREASE_SALARY_SUPERVISORS;
DELIMITER //
CREATE PROCEDURE INCREASE_SALARY_SUPERVISORS(OUT p_salary_increase_sum DECIMAL(10,2))
BEGIN

DECLARE v_employee_id INT;
DECLARE v_num_supervisees INT;
DECLARE v_salaryincrease DECIMAL(9,2);
DECLARE done INT DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT employee_id FROM employees;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

SET p_salary_increase_sum = 0;

OPEN cur;
    myloop: LOOP
        FETCH cur INTO v_employee_id;
        IF done THEN
	    LEAVE myloop;
        END IF;

	    SET v_salaryincrease = 0;

	    SELECT count(*) INTO v_num_supervisees FROM employees WHERE manager_id = v_employee_id;
	    -- The previous SELECT may be removed and merged with the SELECT cursor to make the code more efficient.
	    -- You could create a cursor which simultanously returns the employee_id and the number of supervisees.

	    IF v_num_supervisees = 1 THEN
	    	SELECT salary*0.1 INTO v_salaryincrease FROM employees WHERE employee_id = v_employee_id;
	    	UPDATE employees SET salary = salary * 1.1 WHERE employee_id = v_employee_id;
	    ELSEIF v_num_supervisees = 2 THEN
	    	SELECT salary*0.15 INTO v_salaryincrease FROM employees WHERE employee_id = v_employee_id;
	    	UPDATE employees SET salary = salary * 1.15 WHERE employee_id = v_employee_id;
	    ELSEIF v_num_supervisees >= 3 THEN
	    	SELECT salary*0.2 INTO v_salaryincrease FROM employees WHERE employee_id = v_employee_id;
	    	UPDATE employees SET salary = salary * 1.2 WHERE employee_id = v_employee_id;
	    END IF;

	    SET p_salary_increase_sum = p_salary_increase_sum + v_salaryincrease;

    END LOOP;
    CLOSE cur;


END //
DELIMITER ;

CALL INCREASE_SALARY_SUPERVISORS(@amount);
SELECT @amount;