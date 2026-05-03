create database universitydb;
use universitydb;

create table students (
    studentid int primary key,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    birthdate date,
    enrollmentdate date
);

create table courses (
    courseid int primary key,
    coursename varchar(100),
    departmentid int,
    credits int
);

create table instructors (
    instructorid int primary key,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    departmentid int
);

create table departments (
    departmentid int primary key,
    departmentname varchar(100)
);

create table enrollments (
    enrollmentid int primary key,
    studentid int,
    courseid int,
    enrollmentdate date,
    foreign key (studentid) references students(studentid),
    foreign key (courseid) references courses(courseid)
);

insert into students values
(1, 'john', 'doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'jane', 'smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

insert into departments values
(1, 'computer science'),
(2, 'mathematics');

insert into courses values
(101, 'introduction to sql', 1, 3),
(102, 'data structures', 2, 4);
 select * from courses;
 
insert into instructors values
(1, 'alice', 'johnson', 'alice@univ.com', 1),
(2, 'bob', 'lee', 'bob@univ.com', 2);

insert into enrollments values
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');

update students set firstname = 'johnny' where studentid = 1;
delete from students where studentid = 2;

select * from students
where enrollmentdate > '2022-01-01';

select * from courses
where departmentid = 2
limit 5;

select courseid, count(studentid) as totalstudents
from enrollments
group by courseid
having count(studentid) > 0;

select studentid
from enrollments
where courseid in (101,102)
group by studentid
having count(distinct courseid) = 2;

select distinct studentid
from enrollments
where courseid in (101,102);

select avg(credits) as avgcredits from courses;


select d.departmentname, count(e.studentid)
from departments d
join courses c on d.departmentid = c.departmentid
join enrollments e on c.courseid = e.courseid
group by d.departmentname;

select s.firstname, c.coursename
from students s
inner join enrollments e on s.studentid = e.studentid
inner join courses c on e.courseid = c.courseid;

select s.firstname, c.coursename
from students s
left join enrollments e on s.studentid = e.studentid
left join courses c on e.courseid = c.courseid;

select courseid
from enrollments
group by courseid
having count(studentid) > 10;

select studentid, year(enrollmentdate) as year
from enrollments;

select concat(firstname, ' ', lastname) as fullname
from instructors;

select courseid,
count(studentid) over (order by courseid) as runningtotal
from enrollments;

select studentid,
case 
    when year(curdate()) - year(enrollmentdate) > 4 then 'senior'
    else 'junior'
end as status
from students;