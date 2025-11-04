create database Employee_salary ;

drop database Employee_salary; 

create database SQL_Learning_Practice;
USE SQL_Learning_Practice;


CREATE TABLE Employee_salary (
employee_id int not null, 
first_name varchar(50) not null,
last_name varchar (50)not null,
occuption varchar (50),
employee_salary int not null,
dept_id int
)
;


insert into Employee_salary (employee_id,first_name,last_name,occuption,employee_salary,dept_id)
values
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);


create table Employee_Demographics (
employee_id int not null,
first_name varchar (50) not null,
last_name varchar (50) not null,
age int,
gender varchar (50),
birth_date date,
PRIMARY KEY (employee_id)
)
;

drop table Employee_Demographics

INSERT INTO Employee_Demographics (employee_id,first_name,last_name,age,gender,birth_date)
values 
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');


CREATE TABLE parks_departments (
  department_id INT NOT NULL ,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);


INSERT INTO parks_departments (department_id , department_name )
VALUES
(1,'Parks and Recreation'),
(2,'Animal Control'),
(3, 'Public Works'),
(4, 'Healthcare'),
(5, 'Library'),
(6, 'Finance');


select *
from Employee_salary

select *
from employee_demographics

SELECT *
FROM 
parks_departments

select top 5*
from Employee_salary;

select count(first_name) as total_people 
from Employee_Demographics

select avg (Employee_salary) as avg_salary
from Employee_salary

select Employee_salary
from Employee_salary
where Employee_salary !=60000

select first_name,age,gender
from employee_demographics 
where age>=30 and gender = 'female' 

select * 
from employee_demographics 
where first_name like '%i%' AND age >=25

select * 
from employee_demographics 
where first_name like 'L___%' 

select * 
from employee_demographics 
where first_name IN ('donna','ann','ben','craig')

select  Gender ,count (gender)
from employee_demographics  
group by gender
;


--JOINS 

select demo.employee_id ,age , occuption  
from Employee_salary as sal
join employee_demographics as demo 
	on sal.employee_id = demo.employee_id
;


select * 
from Employee_salary ;

select *
from employee_demographics  ;

select *  
from Employee_salary as sal
LEFT join employee_demographics as demo 
	on sal.employee_id = demo.employee_id
;

select *  
from Employee_salary as sal
RIGHT join employee_demographics as demo 
	on sal.employee_id = demo.employee_id
;

SELECT *
FROM Employee_salary as sal1 
JOIN Employee_salary as sal2
	on sal1.employee_id = sal2.employee_id
;

-- Appointing secret santa to each eployee using self join 

SELECT sal1.employee_id as secret_santa,
sal1.first_name as First_name_santa,
sal1.last_name as last_name_santa,
sal2.employee_id as secret_santa,
sal2.first_name as First_name_santa,
sal2.last_name as last_name_santa
FROM Employee_salary as sal1 
JOIN Employee_salary as sal2
	on sal1.employee_id + 1 = sal2.employee_id
;

--JOINGIN 3 tables at once

select *  
from Employee_salary as sal
join employee_demographics as demo 
	on sal.employee_id = demo.employee_id
JOIN parks_departments as pd
	on sal.dept_id = pd.department_id
	;
-- UNIONS 

SELECT First_name , last_name
FROM employee_demographics
UNION 
SELECT First_name , last_name
FROM Employee_salary
;

SELECT First_name , last_name
FROM employee_demographics
UNION ALL
SELECT First_name , last_name
FROM Employee_salary
;

-- NOW WE WANT TO LOOK AT PEOPLEOLDER THAN 50 

SELECT first_name , last_name, 'old' AS old_person
FROM employee_demographics 
where age > 50
;

-- WE WANT TO IDENTIFY OLD EMPLOYEES AND HIGH PAID EMPLOYEES BOTH MALE AND FEMALE

SELECT first_name , last_name, 'old lady' AS Label
FROM employee_demographics 
where age > 40 AND gender = 'female' 
UNION
SELECT first_name , last_name, 'old man' AS Label
FROM employee_demographics 
where age > 40 AND Gender = 'male'
UNION
SELECT first_name , last_name, 'Highly Paid' AS Label
FROM Employee_salary
where employee_salary > 70000
ORDER BY first_name , last_name
;

-- CASE STATEMENTS 
-- Pay icrease 
-- < 50000 = 5%
-- > 50000 = 7% 
-- Finance = 10% bonus 

SELECT first_name , last_name , employee_salary,department_name,
CASE 
	WHEN employee_salary < 50000 THEN '5%'
	WHEN employee_salary > 50000 THEN '7%'
	WHEN pd.department_name = ('Finance') THEN '10%'
	END AS Bonus
FROM Employee_salary,parks_departments as pd

-- now u have to create another column where u can see the final salary that they will get after they recive the bonus 


SELECT first_name , last_name , employee_salary,
CASE 
	WHEN employee_salary < 50000 THEN employee_salary * 1.05
	WHEN employee_salary > 50000 THEN employee_salary * 1.07
END AS Bonus_salary,
CASE 
	WHEN dept_id = 6 THEN employee_salary * 1.10
END Bonus
FROM Employee_salary


SELECT *
FROM 
parks_departments
where department_id = '6'

SELECT *
FROM 
Employee_salary
where dept_id = '6';

-- WINDOW FUNCTIONS 
-- ROWS, RANKS, DENSE RANKS

--AVG Salary for each gender (OVER HERE WE ARE JOINING TABLES because we want to cobine and look at data from 2 different tables)

SELECT*
FROM Employee_demographics;

SELECT gender , AVG(employee_salary) OVER() AS avg_salary 
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	ON demo.employee_id = sal.employee_id
;

SELECT gender , AVG(employee_salary) OVER(PARTITION BY gender) AS avg_salary 
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	ON demo.employee_id = sal.employee_id
;

-- We can add extra info in the select column without disturbing the AVG funtion column 

SELECT  demo.first_name,
demo.last_name,
gender , 
AVG(employee_salary) OVER(PARTITION BY gender) AS avg_salary 
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	ON demo.employee_id = sal.employee_id
;

-- SUM of the salaries 

SELECT  demo.first_name,
demo.last_name,
gender , 
SUM(employee_salary) OVER(PARTITION BY gender) AS SUM_salary 
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	ON demo.employee_id = sal.employee_id
;

--Rolling total 

SELECT  demo.employee_id,
demo.first_name,
demo.last_name,
gender ,
employee_salary,
SUM(employee_salary) OVER(PARTITION BY gender order by demo.employee_id) AS rolling_salary 
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	ON demo.employee_id = sal.employee_id
;

--Row Number 

SELECT  demo.employee_id,
demo.first_name,
demo.last_name,
gender ,
employee_salary,
ROW_NUMBER() OVER(PARTITION BY Gender ORDER BY employee_salary DESC) as Row_numbers
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	ON demo.employee_id = sal.employee_id
;

--RANKS & DENSE RANKS

SELECT  demo.employee_id,
demo.first_name,
demo.last_name,
gender ,
employee_salary,
ROW_NUMBER() OVER(PARTITION BY Gender ORDER BY employee_salary DESC) as Row_num,
RANK () OVER(PARTITION BY Gender ORDER BY employee_salary DESC) as RANK_num,
DENSE_RANK () OVER(PARTITION BY Gender ORDER BY employee_salary DESC) as DENSE_RANK_num
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	ON demo.employee_id = sal.employee_id
;

-- Top 3 most paid employee from both male and female (that substring in itself is a table u dont have to name a table to select data from it)

select *
from 

(SELECT  demo.employee_id,
demo.first_name,
demo.last_name,
gender ,
employee_salary,
RANK () OVER(PARTITION BY Gender ORDER BY employee_salary DESC) as RANK_num
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	ON demo.employee_id = sal.employee_id) AS most_paid

where RANK_num <=3 
;

--CTE 

WITH CTE_Example
AS 
( SELECT gender, AVG(employee_salary) AS avg_sal, MAX(employee_salary) AS max_sal, MIN(employee_salary) AS min_sal, COUNT(employee_salary) AS count_sal
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	on demo.employee_id = sal.employee_id 
GROUP BY gender 
)
SELECT *
from CTE_Example ;

-- We can also create more than 1 or 2 CTE tables whenu want to combine 2 table or more 
-- we do this because we might have to alot of functionality in one table and might need only a few things from the other table 


WITH CTE_Example
AS 
( SELECT employee_id, gender, birth_date
FROM Employee_demographics 
where birth_date > '1985-01-01'
),
CTE_Example2 AS 
( select employee_id , employee_salary
from Employee_salary
where employee_salary >50000
) 
SELECT *
from CTE_Example
join CTE_Example2 
	on CTE_Example.employee_id = CTE_Example2.employee_id
;

-- We will look at how we can use columns in the CTE function here u will not have to use 'AS' in irder to chnage the column name 

WITH CTE_Example (gender, avg_sal, max_sal, min_sal, count_sal)
AS 
( SELECT gender, AVG(employee_salary) , MAX(employee_salary) , MIN(employee_salary) , COUNT(employee_salary) 
FROM Employee_demographics AS demo
JOIN Employee_salary AS sal
	on demo.employee_id = sal.employee_id 
GROUP BY gender 
)
SELECT *
from CTE_Example
;

-- Create a TEMP Table using an existing table (employee_salary) 
-- We need to create a table where we have salary over and = to 50,000

SELECT *
FROM Employee_salary

SELECT *
INTO #salary_over_50k
FROM Employee_salary
WHERE employee_salary >= 50000;

SELECT *
FROM #salary_over_50k;

-- Store Procedure 

CREATE PROCEDURE Test 
AS 
SELECT *
FROM Employee_salary;


EXEC Test;

CREATE PROCEDURE salaryraise 
AS 
SELECT *
FROM Employee_salary
WHERE employee_salary >=50000;

EXEC salaryraise;

-- Somthing we will do on a daily basis in work 
-- multiple things at once 

DELETE salaryraise2;

CREATE PROCEDURE salaryraise3
AS
BEGIN
    SELECT *
    FROM Employee_salary
    WHERE employee_salary >= 50000;

    SELECT *
    FROM Employee_salary
    WHERE employee_salary >= 10000;
END;

EXEC salaryraise3;

