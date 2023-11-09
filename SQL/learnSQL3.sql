/*SQL Constraints-SQL constraints
SQL constraints are used to specify any rules for the records in a table.
Constraints can be used to limit the tyoe of data that can go into a table.
it ensures the accuarcy and realiability of the records in a table, and if there is any violation 
between the constraint and record action, the action is aborted.Constraints can be column level or table level.
Column level cosntraints apply to a column and table level constraints apply to the whole table. 

1.NOT NULL
2.UNIQUE
3.PRIMARY KEY
4.FOREIGN KEY
5.check
6.DEFAULT
7.INDEX
*/

#NOT NULL
use customer;
create table student(
id int NOT NULL,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int);
desc student;

alter table student modify age int not null;

#2.UNIQUE
create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int not null,
unique(id));

insert into person values(1,'naveen','kumar',27);
insert into person values(2,'naveen1','kumar1',27);
select * from person;
insert into person values(1,'naveen2','kumar2',27);

alter table person add unique(first_name);

alter table person add constraint uc_person unique(age,first_name);
desc person;

alter table person drop index uc_person;

#2.Primary key

create table profession(
id int not null,
first_name varchar(25) not null,
sports varchar(25),
age int,
constraint pk_profession primary key(id,sports));
desc profession;

alter table profession add primary key(id);

alter table profession drop primary key;

 