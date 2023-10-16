select first_name from employees;

select distinct first_name from employees;

select distinct first_name, last_name from employees;

select distinct department_id as ID, department_name as Department from departments;

select * from employees;

select 27 from dual;

select now() from dual;

select now() from employees;

select 'ASD' as "fOo" from departments;

select now() from departments;

select CONCAT(first_name, '  ', last_name), salary*12 as "ANNUAL SALARY" from employees;

select last_name, department_id from employees where department_id = 110;

select last_name, salary from employees where salary < 10000;

select last_name, salary from employees where salary between 10000 and 12000;

select last_name, manager_id from employees where manager_id  in (100, 145, 146);

select last_name, job_id, manager_id from employees where manager_id is null;

select last_name as "Name", salary as "Salary", salary*12+commission_pct*salary as "Annual" from employees;

select CONCAT(last_name, ', ', first_name) as "Name", salary as "Salary", commission_pct as "Commission", salary*12+commission_pct*salary as "Annual" from employees;

select CONCAT(last_name, ', ', first_name) as "Name", salary as "Salary", commission_pct as "Commission", salary*12+IFNULL(commission_pct,0)*salary as "Annual" from employees;

select last_name, IFNULL(commission_pct, 'Not Applicable') as "COMMISSION" from employees;

select last_name from employees where last_name like 'Mc%';

select last_name from employees where last_name like BINARY 'MC%';

select first_name from employees where first_name like 'D__i%';

select phone_number from employees where phone_number like '%123%';

select phone_number from employees where phone_number like '%.123.%';

select last_name, job_id, salary from employees where job_id = 'SA_MAN' or job_id = 'AD_PRES' and salary >= 14000;

select last_name, job_id, salary from employees where (job_id = 'SA_MAN' or job_id = 'AD_PRES') and salary >= 14000;

select last_name, job_id from employees where job_id not in ('SA_MAN','AD_PRES') and department_id = 50;

select last_name, commission_pct from employees where commission_pct is not null;

select employee_id, manager_id from employees where manager_id not in (100);

select employee_id, manager_id from employees where manager_id not in (100, NULL);

select distinct last_name from employees order by last_name;

select last_name, first_name from employees order by last_name, first_name;

select employee_id, manager_id from employees order by manager_id asc, employee_id desc;

select employee_id, first_name, last_name, LPAD (salary, 10, '*') as salary from employees;