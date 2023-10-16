drop view if exists employeesData;
create view employeesData (employee_id, last_name, department_name) as
select employee_id, last_name, department_name from employees, departments
where employees.department_id = departments.department_id;

DROP view if exists employeesLocation;
CREATE VIEW employeesLocation (employee_id, last_name, city) AS
SELECT employee_id, last_name, city 
FROM employees JOIN departments
USING (department_id)
JOIN locations
USING (location_id);





DROP view if exists employeesDataLocation;
create view employeesDataLocation
(last_name, department_name, city) as
select employeesData.last_name, department_name, city
from employeesData join employeesLocation USING (employee_id);

DROP view if exists highSalaryEmployees;
create view highSalaryEmployees
(last_name, department_name, salary) as
select e.last_name, d.department_name, e.salary
from employees e join departments d
on e.department_id = d.department_id
where e.salary >
(select AVG(salary) from employees c
where e.department_id = c.department_id);




drop view if exists regionsView;
create view regionsView
as select region_id, region_name from regions;

insert into regionsView values (99,'Antarctica');

update regionsView
set region_name = 'Potato Land' where region_id = 99;

delete from regionsView where region_id = 99;



insert into employeesDataLocation values ('John', 'Marketing', 'Seattle'); -- doesn't work on purpose


drop view if exists employeesData;
drop view if exists employeesLocation;
drop view if exists employeesDataLocation;
drop view if exists highSalaryEmployees;
drop view if exists regionsView;


SET autocommit = OFF;

SHOW VARIABLES WHERE Variable_name='autocommit';

START TRANSACTION; -- starts a transaction

SELECT @employee_id:=employee_id
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

SELECT * FROM employees ORDER BY salary ASC; 

DELETE FROM employees
WHERE employee_id = @employee_id;

SELECT * FROM employees ORDER BY salary ASC; 

ROLLBACK; -- undo the transaction

SELECT * FROM employees ORDER BY salary ASC;

COMMIT; -- makes changes permanent




SET autocommit = OFF;

SHOW VARIABLES WHERE Variable_name='autocommit';

START TRANSACTION; -- starts a transaction

SAVEPOINT p1; -- creates a savepoint

SELECT count(*) FROM employees;

DELETE FROM employees WHERE employee_id = 132;

SELECT count(*) FROM employees;

SAVEPOINT p2; -- creates a savepoint

DELETE FROM employees WHERE employee_id = 128;

SELECT count(*) FROM employees;

ROLLBACK TO SAVEPOINT p2; -- undo changes and restore savepoint p2

SELECT count(*) FROM employees;

ROLLBACK TO SAVEPOINT p1; -- undo changes and restore savepoint p1

SELECT count(*) FROM employees;

COMMIT; -- makes changes permanent

-- RELEASE SAVEPOINT p1;

-- RELEASE SAVEPOINT p2;