use mystery;
show tables;
describe departments;
describe dept_emp;
describe dept_manager;
describe employees;
describe salaries;
describe titles;

-- 1)
select count(distinct first_name, last_name, birth_date) from employees;
-- 2)
select title, count(emp_no) from titles group by title;
-- 3)
select max(salary) from salaries;
select min(salary) from salaries;
select avg(salary) from salaries;
-- 4)
select first_name, last_name, max(salary) from employees inner join salaries
using (emp_no) group by emp_no order by max(salary) desc limit 10;
-- 5)
select sum(salary) from salaries;
select sum(salary) from salaries where to_date = 99990101;
-- 6)
select first_name, last_name, birth_date from employees
order by birth_date limit 1;
select first_name, last_name, birth_date from employees
order by birth_date desc limit 1;
-- 7)
select first_name, last_name, hire_date from employees
order by hire_date desc limit 1;
-- 8)
select gender, count(*) from employees group by gender;
-- 9)
select count(*) from employees where birth_date > 19611124;
select first_name, last_name from employees where birth_date > 19611124;
-- 10)
select dept_name, count(emp_no) from dept_emp inner join departments
using (dept_no) group by dept_no;
-- 11)
select emp_no, count(*) from dept_emp group by emp_no order by count(*) desc;
-- 12)
select first_name, last_name from employees where hire_date < 20061124;
-- 13)
select dept_name, dept_no from departments;
select gender, count(*) from dept_emp inner join employees using (emp_no)
where dept_no like 'd007' group by gender;
-- 14)
select max(length(first_name) + length(last_name)) from employees;
select * from employees where length(first_name) + length(last_name) = 29;

select first_name, count(*)from employees group by first_name
order by count(*) desc;

select dept_name, count(*) from dept_emp inner join departments
  using (dept_no) group by dept_no;