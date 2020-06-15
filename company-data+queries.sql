CREATE TABLE EMPLOYEE(
FNAME VARCHAR(20),
MINIT CHAR(1),
LNAME VARCHAR(20),
ESSN INT(10) NOT NULL PRIMARY KEY,
BDATE DATE,
ADDRESS VARCHAR(50),
SEX CHAR(1),
SALARY INT(8),
SUPER_SSN INT(10),
DNUMBER INT(1),
INDEX(DNUMBER),
CONSTRAINT FK_EMP FOREIGN KEY(DNUMBER) REFERENCES DEPARTMENT(DNUMBER)
);

CREATE TABLE DEPARTMENT(
DNAME VARCHAR(20),
DNUMBER INT(1) NOT NULL PRIMARY KEY,
MGR_SSN INT(10),
MGR_START_DATE DATE
);

CREATE TABLE PROJECT(
PNAME VARCHAR(20),
PNUMBER INT(2) NOT NULL PRIMARY KEY,
PLOCATION VARCHAR(10),
DNUMBER INT(1),
INDEX(DNUMBER),
CONSTRAINT FK_PROJECT FOREIGN KEY(DNUMBER) REFERENCES DEPARTMENT(DNUMBER)
);

CREATE TABLE WORKS_ON(
ESSN INT(10),
PNUMBER INT(2),
HOURS NUMERIC(3,1),
INDEX(ESSN),
INDEX(PNUMBER),
CONSTRAINT PK_WORKS_ON PRIMARY KEY(ESSN,PNUMBER)
);

CREATE TABLE DEPENDENT(
ESSN INT(10),
DEPENDENT_NAME VARCHAR(10) NOT NULL,
SEX ENUM('M','F'),
BDATE DATE,
RELATIONSHIP VARCHAR(10),
INDEX(ESSN),
CONSTRAINT PK_DEPENDENT PRIMARY KEY(ESSN,DEPENDENT_NAME)
);

CREATE TABLE DEPT_LOCATIONS(
DNUMBER INT(1),
PLOCATION VARCHAR(10),
INDEX(DNUMBER),
INDEX(PLOCATION),
CONSTRAINT PK_DEPT_LOCATIONS PRIMARY KEY(DNUMBER,PLOCATION)
);

#1. 
SELECT FNAME FROM EMPLOYEE,WORKS_ON WHERE EMPLOYEE.ESSN = WORKS_ON.ESSN AND HOURS > 10 AND PNUMBER = (SELECT PNUMBER FROM PROJECT WHERE DNUMBER = 5 AND PNAME = 'ProductX');
+-------+
| FNAME |
+-------+
| John  |
| Joyce |
+-------+
#OR
SELECT FNAME FROM EMPLOYEE INNER JOIN WORKS_ON ON EMPLOYEE.ESSN = WORKS_ON.ESSN AND HOURS > 10 AND PNUMBER = (SELECT PNUMBER FROM PROJECT WHERE DNUMBER = 5 AND PNAME = 'ProductX');

#2.
SELECT FNAME FROM EMPLOYEE,DEPENDENT WHERE FNAME = DEPENDENT_NAME;
EMPTY SET
#OR
SELECT FNAME FROM EMPLOYEE INNER JOIN DEPENDENT ON FNAME = DEPENDENT_NAME;

#3.
SELECT a.FNAME FROM EMPLOYEE a, EMPLOYEE b WHERE a.SUPER_SSN = b.ESSN AND b.FNAME = 'Franklin' AND b.LNAME = 'Wong';
+--------+
| FNAME  |
+--------+
| John   |
| Ramesh |
| Joyce  |
+--------+

#4.
SELECT PNAME, SUM(HOURS) FROM PROJECT, WORKS_ON WHERE PROJECT.PNUMBER = WORKS_ON.PNUMBER GROUP BY PNAME;
+-----------------+------------+
| PNAME           | SUM(HOURS) |
+-----------------+------------+
| Computerization |       55.0 |
| Newbenefits     |       55.0 |
| ProductX        |       52.5 |
| ProductY        |       37.5 |
| ProductZ        |       50.0 |
| Reorganization  |       25.0 |
+-----------------+------------+

#5.
SELECT FNAME FROM EMPLOYEE, PROJECT WHERE EMPLOYEE.DNUMBER = PROJECT.DNUMBER AND PNAME = 'ProductX' AND PNAME = 'ProductY' AND PNAME = 'ProductZ' AND PNAME = 'Computerization' AND PNAME = 'Reorganization' AND PNAME = 'Newbenefits';
EMPTY SET
#OR
SELECT FNAME FROM EMPLOYEE,PROJECT WHERE EMPLOYEE.DNUMBER = PROJECT.DNUMBER AND PNAME = ALL(SELECT PNAME FROM PROJECT);
EMPTY SET
#OR
SELECT FNAME FROM EMPLOYEE INNER JOIN PROJECT ON EMPLOYEE.DNUMBER = PROJECT.DNUMBER WHERE PNAME = ALL(SELECT PNAME FROM PROJECT);
EMPTY SET

#6.
SELECT FNAME FROM EMPLOYEE, PROJECT WHERE EMPLOYEE.DNUMBER = PROJECT.DNUMBER AND PNAME NOT IN('ProductX','ProductY', 'ProductZ','Computerization','Reorganization','Newbenefits');
EMPTY SET
#OR
SELECT FNAME FROM EMPLOYEE,PROJECT WHERE EMPLOYEE.DNUMBER = PROJECT.DNUMBER AND PNAME <> ALL (SELECT PNAME FROM PROJECT);
EMPTY SET

#7.
SELECT DNAME, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEE,DEPARTMENT WHERE EMPLOYEE.DNUMBER = DEPARTMENT.DNUMBER GROUP BY DNAME;
+----------------+------------+
| DNAME          | AVG_SALARY |
+----------------+------------+
| Administration | 31000.0000 |
| Headquarters   | 55000.0000 |
| Research       | 33250.0000 |
+----------------+------------+

#8.
SELECT AVG(a.SALARY) AS AVG_SALARY_FEMALES FROM EMPLOYEE a, EMPLOYEE b WHERE a.SEX = 'F' AND b.SEX = 'F';
+--------------------+
| AVG_SALARY_FEMALES |
+--------------------+
|         31000.0000 |
+--------------------+
#OR
SELECT AVG(a.SALARY) FROM EMPLOYEE a INNER JOIN EMPLOYEE b ON a.SEX = 'F' AND b.SEX = 'F';
SAME OUTPUT

#9.
SELECT DISTINCT FNAME, ADDRESS FROM EMPLOYEE, PROJECT, DEPT_LOCATIONS WHERE EMPLOYEE.DNUMBER = PROJECT.DNUMBER AND PROJECT.PLOCATION = 'Houston' AND EMPLOYEE.DNUMBER = DEPT_LOCATIONS.DNUMBER AND DEPT_LOCATIONS.PLOCATION <> 'Houston';
+----------+--------------+
| FNAME    | ADDRESS      |
+----------+--------------+
| John     | 731 Fodren   |
| Franklin | 638 Voss     |
| Ramesh   | 975 Fire Oak |
| Joyce    | 5631 Rice    |
| James    | 450 Stone    |
+----------+--------------+

#OR
SELECT DISTINCT FNAME, ADDRESS FROM EMPLOYEE, PROJECT, DEPT_LOCATIONS WHERE PROJECT.PLOCATION = 'Houston' AND DEPT_LOCATIONS.PLOCATION NOT LIKE 'H%' AND EMPLOYEE.DNUMBER = PROJECT.DNUMBER AND EMPLOYEE.DNUMBER = DEPT_LOCATIONS.DNUMBER;
+----------+--------------+
| FNAME    | ADDRESS      |
+----------+--------------+
| John     | 731 Fodren   |
| Franklin | 638 Voss     |
| Ramesh   | 975 Fire Oak |
| Joyce    | 5631 Rice    |
+----------+--------------+

#10.
SELECT DISTINCT FNAME AS DEPT_MGR FROM EMPLOYEE, DEPARTMENT, DEPENDENT WHERE MGR_SSN = EMPLOYEE.ESSN AND EMPLOYEE.ESSN <> DEPENDENT.ESSN;
+----------+
| DEPT_MGR |
+----------+
| Franklin |
| Jennifer |
| James    |
+----------+