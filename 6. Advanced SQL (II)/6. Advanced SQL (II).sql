DROP TABLE IF EXISTS salary_log;
CREATE TABLE salary_log (
  log_date timestamp DEFAULT CURRENT_TIMESTAMP,
  employee_id INT,
  new_salary DECIMAL(8,2),
  old_salary DECIMAL(8,2),
  primary key (log_date, employee_id)
);

DROP TRIGGER IF EXISTS salary_log_trigger;
DELIMITER //
CREATE TRIGGER salary_log_trigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
IF(new.salary <> old.salary) THEN
INSERT INTO salary_log (employee_id, new_salary, old_salary) VALUES (new.employee_id, new.salary, old.salary);
END IF;
END//
DELIMITER ;

update employees set salary = 50000 where employee_id = 100;

update employees set salary = 24000 where employee_id = 100;




DROP TRIGGER IF EXISTS update_job_history;
DELIMITER //
CREATE TRIGGER update_job_history
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
  IF (new.job_id <> old.job_id OR new.department_id <> old.department_id) THEN
    CALL add_job_history(old.employee_id, old.hire_date, sysdate(), old.job_id, old.department_id);
  END IF;
END//
DELIMITER ;

update employees set job_id = 'AD_VP' where employee_id = 103;



DROP TRIGGER IF EXISTS salary_check_trigger;
DELIMITER //
CREATE TRIGGER salary_check_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	DECLARE job_id_avg_sal DECIMAL (9,2);

	SELECT AVG(salary) INTO job_id_avg_sal FROM employees WHERE job_id = new.job_id;

	IF(new.salary > 2*job_id_avg_sal OR new.salary < 0.5*job_id_avg_sal) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary deviates from average of the job'; -- raises exception
	END IF;
END//
DELIMITER ;


INSERT INTO employees (last_name, email, hire_date, job_id, salary) VALUES ('Cano', 'email@vcu.edu', SYSDATE(), 'AD_VP', '1');



ALTER TABLE departments ADD total_salary DECIMAL(12,2);


DROP TRIGGER IF EXISTS total_salary_trigger_insert;
DELIMITER //
CREATE TRIGGER total_salary_trigger_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN 
	UPDATE departments 
	SET total_salary = total_salary + new.salary
	WHERE department_id = new.department_id;
END//
DELIMITER ;

DROP TRIGGER IF EXISTS total_salary_trigger_delete;
DELIMITER //
CREATE TRIGGER total_salary_trigger_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN 
	UPDATE departments 
	SET total_salary = total_salary - old.salary
	WHERE department_id = old.department_id;
END//
DELIMITER ;

DROP TRIGGER IF EXISTS total_salary_trigger_update;
DELIMITER //
CREATE TRIGGER total_salary_trigger_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN 
	IF(old.department_id <> new.department_id) THEN
		UPDATE departments 
		SET total_salary = total_salary - old.salary
		WHERE department_id = old.department_id;

		UPDATE departments 
		SET total_salary = total_salary + new.salary
		WHERE department_id = new.department_id;
	END IF;

	IF(old.department_id = new.department_id AND old.salary <> new.salary) THEN
		UPDATE departments 
		SET total_salary = total_salary - old.salary + new.salary
		WHERE department_id = new.department_id;
	END IF;
END//
DELIMITER ;



update employees set salary = salary;
update departments set total_salary = 0;


update departments d
set d.total_salary =
(select sum(e.salary) from employees e
where d.department_id = e.department_id);





DROP TRIGGER IF EXISTS update_salary_insert;
DELIMITER //
CREATE TRIGGER update_salary_insert 
AFTER INSERT ON employees
FOR EACH ROW
BEGIN 
	UPDATE employees 
	SET salary = salary*1.05
	WHERE department_id = new.department_id;
END//
DELIMITER ;


DROP TRIGGER IF EXISTS update_salary_update;
DELIMITER //
CREATE TRIGGER update_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN 
	IF(new.department_id <> old.department_id) THEN
		UPDATE employees 
		SET salary = salary*1.05
		WHERE department_id = new.department_id;
	END IF;
END//
DELIMITER ;


INSERT INTO employees (last_name, email, hire_date, job_id, salary, department_id) VALUES ('Cano', 'email@lol.edu', SYSDATE(), 'AD_VP', '10000', 20);  -- woopps, mutating table
update employees set department_id = 20 where employee_id = 100; -- woopps, mutating table
	


DROP TRIGGER IF EXISTS update_salary_insert;
DROP TRIGGER IF EXISTS update_salary_update;