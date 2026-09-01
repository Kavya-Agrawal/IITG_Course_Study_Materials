-- use Mysql
-- Create the DATABASE first, 
-- CREATE DATABASE COMPANY;
-- then USE <DATABASE NAME>;
-- as instructed in the lectures in class

-- Step 1: Create the DEPARTMENT table without the foreign key for Mgr_ssn
CREATE TABLE DEPARTMENT (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9), -- No foreign key here initially
    Mgr_start_date DATE,
    PRIMARY KEY (Dnumber),
    UNIQUE (Dname)
);

-- Step 2: Create the EMPLOYEE table without the foreign key for Dno
CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT, -- No foreign key here initially
    PRIMARY KEY (Ssn)
);


-- Step 4: Create the DEPT_LOCATIONS table
CREATE TABLE DEPT_LOCATIONS (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

-- Step 5: Create the PROJECT table
CREATE TABLE PROJECT (
    Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    PRIMARY KEY (Pnumber),
    UNIQUE (Pname),
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

-- Step 6: Create the WORKS_ON table
CREATE TABLE WORKS_ON (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1),
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

-- Step 7: Create the DEPENDENT table
CREATE TABLE DEPENDENT (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(8),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);

-- Step 8: Insert data into the tables
-- Insert data into DEPARTMENT
-- #1452 - Cannot add or update a child row: a foreign key constraint fails (`company`.`DEPARTMENT`, CONSTRAINT `fk_department_manager` FOREIGN KEY (`Mgr_ssn`) REFERENCES `EMPLOYEE` (`Ssn`))
-- Adding the Foreign keys constraints later

INSERT INTO DEPARTMENT VALUES 
('Research', 5, '333445555', '1988-05-22'),
('Administration', 4, '987654321', '1995-01-01'),
('Headquarters', 1, '888665555', '1981-06-19');

-- Insert data into EMPLOYEE
INSERT INTO EMPLOYEE VALUES 
('John', 'B', 'Smith', '123456789', '1985-01-09', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5),
('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, '888665555', 5),
('Alicia', 'J', 'Zelaya', '999887777', '1985-07-19', '321 Castle, Spring, TX', 'F', 25000, '987654321', 4),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, '888665555', 4),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, '987654321', 4),
('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);

-- Insert data into DEPT_LOCATIONS
INSERT INTO DEPT_LOCATIONS VALUES 
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

-- Insert data into PROJECT
INSERT INTO PROJECT VALUES 
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

-- Insert data into WORKS_ON
INSERT INTO WORKS_ON VALUES 
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('987987987', 30, 5.0),
('987654321', 10, 20.0),
('987654321', 30, 15.0),
('888665555', 20, NULL);

-- Insert data into DEPENDENT
INSERT INTO DEPENDENT VALUES 
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'),
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'),
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');


-- Step 3: Add the foreign key constraints after both tables are created
ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_employee_department FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber);

ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_supervisor_employee FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);

ALTER TABLE DEPARTMENT
ADD CONSTRAINT fk_department_manager FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);




