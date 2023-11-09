#Session 1
/*
1.SQL CREATE databases
2.sql drop databases
3.sql create table
4.sql insert into table
5.sql drop table
*/
show databases;

#create database customers;
#create table in databases
use customers;
create table customer_info(id integer,first_name varchar(10),last_name varchar(10));
show tables;
select * from customer_info;
insert into customer_info(id,first_name,last_name) values(1,'Naveen','kumar');
insert into customer_info(id,first_name,last_name) values(1,'Namratha','kutty');
drop table customer_info;
show tables;
drop database customers;
show databases;
#create database naveenp;
use naveenp;
create table Personal_info(rollno integer,schoolname varchar(10),sports varchar(10));
show tables;
select * from Personal_info;
insert into Personal_info(rollno,schoolname,sports) values(1,'rishi','cricket');
drop table Personal_info;
show tables;
drop database naveenp;
show databases;
create database naveen;
use naveen;
create table customer_detail(firstname varchar(50), lastname varchar(50), age int);
insert into customer_detail values ('naveen','kumar',27),('spider','reddy',22),('namratha','gantasala',28),('anushka','shetty',29),('kiran','kumar2',22),('mythili','kumar3',24);
select * from customer_detail;
