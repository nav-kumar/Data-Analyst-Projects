use hr;
select *from departments;
select *from employees;
select department_id, hire_date from employees where department_id != '2';
select department_id, hire_date from employees where year(hire_date) = '1990';
select *from employees;
select count(employee_id) from employees;
select count(distinct(manager_id)) from employees;
select min(salary), max(salary), avg(salary), std(salary), sum(salary) from employees;
select first_name,last_name, (case when salary>10000 then 'High' when salary<2500 then 'Low' else 'Mid' end) as "SalaryCategory" from employees;
select first_name as "FIRST_NAME", round((0.1*salary)) as "BONUS"  from employees;
select *from employees limit 10 offset 5;
select * FROM employees WHERE salary > ALL ( 
SELECT salary FROM employees WHERE 
department_id = 7);
Select E.employee_id, E.first_name, E.last_name
From employees E 
Where Exists ( Select * From employees E2 Where 
E2.manager_id = E.employee_id );
select first_name,last_name from employees order by first_name desc, last_name asc;
select department_id, round(avg(salary)) as "AVG Salary", round(max(salary)) as "MAX Salary"from employees group by department_id having round(max(salary))>10000 and department_id>5;
select count(*)from departments cross join employees;
select first_name, department_id from employees  where department_id in (1,2,3);
select department_id, department_name from departments where department_id in (1,2,3);
select first_name, e.department_id, department_name from employees e join departments d on e.department_id=d.department_id where e.department_id in (1,2,3);
show tables;
select c.country_name,c.country_id,l.country_id,l.street_address,l.city from countries c left join locations l on c.country_id=l.country_id where c.country_id in ('US','UK','CN');
select c.country_name,c.country_id,l.country_id,l.street_address,l.city from countries c right join locations l on c.country_id=l.country_id where c.country_id in ('US','UK','CN');



