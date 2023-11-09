#create database Learning;
use learning;
create table profession(id integer auto_increment, 
person varchar(25),
hobby varchar(25),
pay float,
primary key(id));
select * from profession;
insert into profession(person,hobby,pay) values('naveen','cricket',95432.7),
('namratha','badminton',98704.6),
('shantanu','tennis',76453.98),
('vikas','baseball',null);
select * from profession where pay is not null;
desc profession;
update profession set pay=65432.98 where id=7;
alter table profession add gender varchar(10);


