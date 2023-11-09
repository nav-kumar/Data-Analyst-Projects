/* learn sql
SQL null values
SQL update statement
SQL delete statement
SQL alter table
--Add column in existing column
--modify /alter column
--alter table-drop column
*/

#create database
#create database customer;
show databases;
use customer;
#create customer_info table
create table customer_info(
id integer auto_increment,
first_name varchar(25),
last_name varchar(25),
salary integer,
primary key(id));

select * from customer_info;
##insert records into table
insert into customer_info(first_name,last_name,salary)
values
('Naveen','kumar',95000),
('Namratha','kutty',98000),
('Nagamani','pabbathi',97000),
('thanav','simha',94000),
('Ranjana','ganta',NULL);
select * from customer_info where salary is not null;

#sql update statement to replace null values

update customer_info set salary=85000 where id=5;
select * from customer_info;

##sql delete statememt

delete from customer_info where id=5;

##sql alter table
##add columns in existing table

alter table customer_info add email varchar(25);
insert into customer_info(first_name,last_name,salary) values ('ranjana','ganatasala',98000);
select * from customer_info;

update customer_info set email='pabbathi2995@gmail.com' where id=1;
update customer_info set email='kuttynam@gmail.com' where id=2;
update customer_info set email='nagamani@gmail.com' where id=3;
update customer_info set email='thanavsimha@gmail.com' where id=4;
update customer_info set email='ranjana@gmail.com' where id=6;
alter table customer_info add dob date;
##alter table modify column

alter table customer_info modify dob year;
desc customer_info;
update customer_info set dob=1995 where id=1;
update customer_info set dob=1995 where id=2;
update customer_info set dob=1972 where id=3;
update customer_info set dob=2020 where id=4;
update customer_info set dob=2000 where id=6;

##alter table to drop cloumn
alter table customer_info drop column email;
select * from customer_info;