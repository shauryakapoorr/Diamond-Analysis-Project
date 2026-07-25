--CREATE LOCATION TABLE
create table location(
location_id int primary key,
city varchar(50))

-- CREATE DEPARTMENT TABLE
create table department(
	department_id int primary key,
	name varchar(50),
	Location_id int,
	foreign key (Location_Id) references Location(Location_Id))

--CREATE JOB TABLE
create table job (
	job_id int primary key,
	designation varchar(50))

--CREATE EMPLOYEE TABLE
create table employee (
	employee_id int primary key,
	last_name varchar(50),
	first_name varchar(50),
	middle_name varchar(50),
	job_id int,
	hire_date date,
	salary decimal(10,2),
	comm decimal(10,2) null,
	department_id int,

	foreign key (job_id) references job(job_id),
	foreign key (department_id) references department(department_id))

--INSERT DATA INTO LOCATION
insert into location values
(122,'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston')

--INSERT DATA INTO DEPARTMENT
insert into department values
(10,'Accounting',122),
(20,'Sales',124),
(30,'Research',123),
(40,'Operations',167)

--INSERT DATA INTO JOB
insert into job values
(667,'Clerk'),
(668,'Staff'),
(669,'Analyst'),
(670,'Sales Person'),
(671,'Manager'),
(672,'President')

--INSERT DATA INTO EMPLOYEE
insert into employee values
(7369,'Smith','John','Q',667,'1984-12-17',800,null,20),
(7499,'Allen','Kevin','J',670,'1985-02-20',1600,300,30),
(7555,'Doyle','Jean','K',671,'1985-05-15',2850,null,30),
(7566,'Dennis','Lynn','S',671,'1985-06-10',2750,null,30),
(7577,'Baker','Leslie','D',671,'1985-06-10',2200,null,40),
(7521,'Wark','Cynthia','D',670,'1985-02-22',1250,50,30)

select * from location
select * from department
select * from job
select * from employee

--SIMPLE QUERIES
--LIST ALL THE EMPLOYEES DETAILS
select * from employee

--LIST ALL DEPARTMENT DETAILS
select * from department

--LIST ALL JOB DETAILS
select * from job

--LIST ALL LOCATIONS
select * from location

--FIRST NAME, LAST NAME, SALARY, COMMISSION
select first_name, last_name, salary, comm
from employee

--EMPLOYEE ID, LAST NAME, DEPARTMENT ID FOR ALL EMPLOYEES AND ALIAS
select Employee_id as 'Id of the employee',
last_name as 'name of the employee',
department_id as 'dep_id'
from employee

--ANNUAL SALARY WITH NAMES
select first_name, last_name,
salary * 12 as annual_salary
from employee

--WHERE CONDITION
--DETAILS ABOUT SMITH
select * from employee
where last_name = 'Smith'

--EMPLOYEES IN DEPARTMENT 20
select * from employee
where department_id = 20

--SALARY BETWEEN 2000 AND 3000
select * from employee
where salary between 2000 and 3000

--DEPARTMENT 10 OR 20
select * from employee
where department_id in(10,20)

--NOT IN DEPARTMENT 10 OR 30
select * from employee
where department_id not in(10,30)

--NAME STARTS WITH L
select * from employee
where first_name like 'L%'

--NAME STARTS WITH L AND ENDS WITH E
select * from employee
where first_name like 'L%E'

--NAME LENGTH 4 AND START WITH J
select * from employee
where len(first_name) = 4
and first_name like 'J%'

--DEPARTMENT 30 AND SALARY >2500
select * from employee
where department_id = 30 and salary>2500

--NOT RECEIVING COMMISSION
select * from employee
where comm is null

--ORDER BY CLAUSE
--EMPLOYEE ID ASCENDING
select employee_id, last_name
from employee
order by employee_id asc

--EMPLOYEE ID AND NAME IN DESCENDING BASED ON SALARY
select employee_id, first_name, last_name
from employee
order by salary desc

--EMPLOYEE DETAILS BY LAST NAME IN ASCENDING AND DEPARTMENT ID IN DESCENDING
select * from employee
order by last_name asc,
department_id desc

--GROUP BY AND HAVING
--DEPARTMENT WISE MAX,MIN,AVG SALARY
select department_id, 
max(salary) as max_salary,
min(salary) as min_salary,
avg(salary) as avg_salary
from employee
group by department_id

--JOB WISE MAX,MIN,AVG SALARY
select job_id,
max(salary) as max_salary,
min(salary) as min_salary,
avg(salary) as avg_salary
from employee
group by job_id

--EMPLOYEE JOINED EACH MONTH
select month(hire_date) as month_no,
count(*) as employees
from employee
group by month(hire_date)
order by month_no

--EMPLOYEES FOR EACH MONTH AND YEAR
select year(hire_date) as year_no,
month(hire_date) as month_no,
count(*) as employees
from employee
group by year(hire_date), month(hire_date)
order by year_no, month_no

--EMPLOYEES FOR EACH MONTH AND SALARY
select month(hire_date) as month_no,
year(hire_date) as year_no,
count(*) as employees
from employee
group by month(hire_date), year(hire_date)
order by year_no, month_no

--DEPARTMENT HAVING AT LEAST 4 EMPLOYEES
select department_id, count(*) as employee_count
from employee
group by department_id
having count(*) >=4

--EMPLOYEES JOINED IN FEBRUARY
select count(*) as employee_count
from employee
where month(hire_date) = 2

--EMPLOYEES JOINED IN MAY OR JUNE
select count(*) as employee_count
from employee
where month(hire_date) in (5,6)

--EMPLOYEES JOINED IN 1985
select count(*) as employee_count
from employee
where year(hire_date) = 1985

--EMPLOYEES JOINED EACH MONTH IN 1985
select month(hire_date) as month_no,
count(*) as employee_count
from employee
where year(hire_date) = 1985
group by month(hire_date)
order by month_no

--EMPLOYEES JOINED IN APRIL 1985
select count(*) as employee_count
from employee
where month(hire_date) = 4
and year(hire_date) = 1985

--DEPARTMENTS HAVING >=3 EMPLOYEES JOINED IN APRIL 1985
select department_id,
count(*) as employee_count
from employee
where month(hire_date) = 4
and year(hire_date) = 1985
group by department_id
having count(*) >=3

--EMPLOYEES WITH DEPARTMENT NAMES
select e.first_name, e.last_name, d.name as department_name
from employee e
join department d
on e.department_id = d.department_id

--EMPLOYEES WITH DESIGNATIONS
select e.first_name, e.last_name, j.designation
from employee e
join job j
on e.job_id = j.job_id

--EMPLOYEES WITH DEPARTMENT NAME AND CITY
select e.first_name, e.last_name, 
d.name as department_name,
l.city
from employee e
join department d
on e.department_id = d.department_id
join location l
on d.Location_id= l.location_id

--EMPLOYEE COUNT DEPARTMENT WISE
select d.name, 
count(*) as employee_count
from employee e
join department d
on e.department_id = d.department_id
group by d.name

--EMPLOYEES IN SALES DEPARTMENT
select count(*) as employee_count
from employee e
join department d
on e.department_id = d.department_id
where d.name = 'sales'

--DEPARTMENTS HAVING >=3 EMPLOYEES
select d.name, 
count(*) as employee_count
from employee e
join department d
on e.department_id = d.department_id
group by d.name
having count(*)>= 3
order by d.name

--EMPLOYEES WORKING IN DALLAS
select count(*) as employee_count
from employee e
join department d
on e.employee_id = d.department_id
join location l
on d.Location_id = l.location_id
where l.city = 'Dallas'

--EMPLOYEES IN SALES OR OPERATIONS
select e.*
from employee e
join department d
on e.department_id = d.department_id
where d.name in ('sales', 'operations')

--CONDITIONAL STATEMENT(CASE)
/**GRADE LOGIC
GRADE A = SALARY >=3000
GRADE B = SALARY 2000-2999
GRADE C = SALARY 1000-1999
GRADE D = SALARY <1000 **/

--EMPLOYEE DETAILS WITH GRADES
select *,
case
when salary >= 3000 then 'A'
when salary >= 2000 then 'B'
when salary >= 1000 then 'C'
end as grade
from employee

--NUMBER OF EMPLOYEES GRADE WISE
select 
case
when salary >=3000 then 'A'
when salary >=2000 then 'B'
when salary >=1000 then 'C'
else 'D'
end as grade,
count(*) as employee_count
from employee
group by 
case
when salary >= 3000 then 'A'
when salary >=2000 then 'B'
when salary >=1000 then 'C'
else 'D'
end

--GRADES AND EMPLOYEES BETWEEN 2000 AND 5000
select
case 
when salary >= 3000 then 'A'
when salary >= 2000 then 'B'
end as grade,
count(*) as employee_count
from employee
where salary between 2000 and 5000
group by 
case 
when salary >= 3000 then 'A'
when salary >= 2000 then 'B'
end

--SUBQUERIES
--EMPLOYEES WITH MAXIMUM SALARY
select *
from employee
where salary = (select max(salary) from employee)

--EMPLOYEES IN SALES DEPARTMENT
select * from employee
where department_id =(select department_id from department where name = 'sales')

--EMPLOYEES WORKING AS CLERK
select * from employee
where job_id = (select job_id from job where designation = 'Clerk')

--EMPLOYEES LIVING IN BOSTON
select * from employee
where department_id in 
(select department_id from department where location_id =(
select location_id from location where city = 'Boston') )

--NUMBER OF EMPLOYEE IN SALES DEPARTMENT
select count(*)
from employee
where department_id = (select department_id from department where name = 'sales')

--INCREASE CLERK SALARY BY 10%
update employee
set salary = salary* 1.10
where job_id = (select job_id from job where designation= 'Clerk')

--SECOND HIGHEST SALARY EMPLOYEE
select * from employee
where salary = 
(select max(salary) from employee where salary < (select max(salary) from employee))

--EMPLOYEES EARNING MORE THAN EMPLOYEE IN DEPARTMENT 30
select * from employee
where salary > (select max(salary) from employee where department_id = 30)

--DEPARTMENT WITH NO EMPLOYEES
select * from department
where department_id not in
(select distinct department_id from employee)

--EMPLOYEES EARNING ABOVE DEPARTMENT AVERAGE
select * from employee e
where salary > (select avg(salary) from employee where department_id = e.department_id)