use customer;
create table School(ID integer,Name varchar(10));
show tables;
insert into School(ID,Name) values(1,'Naveen'),
(2,'Namratha'),
(3,'rio'),
(4,'honey');
select * from school;
create table Grades(ID integer,grade varchar(10));
show tables;
insert into Grades(ID,grade) values(1,'A'),
(2,'B'),
(3,'C'),
(5,'D');
Select * from grades;
select S.name,G.grade
from school S
left join grades G on S.ID=G.ID;
