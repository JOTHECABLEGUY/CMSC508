-- Remember to untick "Enable foreign key checks"
drop procedure if exists add_job_history;
drop trigger if exists update_job_history;
drop view if exists  emp_details_view;
drop table if exists job_history;
drop table if exists departments;
drop table if exists employees;
drop table if exists jobs;
drop table if exists locations;
drop table if exists countries;
drop table if exists regions;
drop table if exists job_grades;