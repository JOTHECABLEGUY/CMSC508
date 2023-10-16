CREATE TABLE instructor (
  ID         int AUTO_INCREMENT,
  name       varchar(20) NOT NULL,
  dept_name  varchar(30),
  salary     decimal(10,2) CHECK (salary > 0),
  office     char(5) NOT NULL UNIQUE,
  PRIMARY KEY (ID),
  FOREIGN KEY (dept_name) REFERENCES departments (department_name)
);

ALTER TABLE instructor ADD COLUMN foocolumn VARCHAR(25);

ALTER TABLE instructor DROP COLUMN foocolumn;

INSERT INTO instructor VALUES (123, 'ALBERTO CANO', NULL, 1234.56, 'E4251');
INSERT INTO instructor (ID, name, salary, office) VALUES (123, 'ALBERTO CANO', 1234.56, 'E4251'); -- This will fail. Primary key 123 already in use.
INSERT INTO instructor (name, salary, office) VALUES ('ALBERTO CANO', 9876.5, 'W0465');
INSERT INTO instructor (name, salary, office) VALUES ('JOHN DOE', 1232.5, 'W0465'); -- This will fail. Office number is UNIQUE and it's already in use.

UPDATE instructor SET salary = 4321.00 WHERE ID = 123;
UPDATE instructor SET salary = 4321.00 WHERE name = 'ALBERTO CANO';
UPDATE instructor SET salary = 4321.00;
UPDATE instructor SET salary = salary * 1.05;

UPDATE instructor
SET salary = CASE
    WHEN salary <= 100000
          THEN salary * 1.05
          ELSE salary * 1.03
END;

UPDATE instructor SET dept_name = 'CS' WHERE ID = 123; -- This will fail. There's no CS department in the departments table.

DELETE FROM instructor;
DELETE FROM instructor WHERE ID = 123;
DELETE FROM instructor WHERE name = 'ALBERTO CANO';

DELETE FROM employees WHERE employee_id = 100;

TRUNCATE TABLE instructor;
DROP TABLE instructor;

SELECT SYSDATE() FROM DUAL;
SELECT UTC_TIMESTAMP() FROM DUAL;
SELECT CURDATE() FROM DUAL;

CREATE TABLE time_test (
  ex_date      DATE,
  ex_datetime  DATETIME,
  ex_timestamp TIMESTAMP
);

INSERT INTO time_test (ex_date, ex_datetime) VALUES (CURDATE(), SYSDATE());
UPDATE time_test SET ex_date = '2020-01-01';