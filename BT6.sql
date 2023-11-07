create schema if not exists baitap6;

use baitap6;

create table if not exists class
(
    classID   int auto_increment primary key,
    className varchar(45) not null,
    startDate date        not null,
    status    bit(1)
);

create table if not exists student
(
    studentID   int auto_increment primary key,
    studentName nvarchar(30) not null,
    address     nvarchar(50),
    phone       varchar(20),
    status      bit(1) default 1,
    classID     int          not null,
    constraint fk_class foreign key (classID) references class (classID)
);

create table if not exists subject
(
    subID   int auto_increment primary key,
    subName nvarchar(30) not null,
    credit  tinyint      not null default 1 check ( credit >= 1 ),
    status  bit(1)                default 1
);

create table if not exists mark
(
    markID    int auto_increment primary key,
    subID     int not null,
    studentID int not null,
    mark      float   default 0 check ( mark between 0 and 10),
    examTimes tinyint default 1,
    constraint unique_key unique key (subID, studentID),
    constraint fk_sub foreign key (subID) references subject (subID),
    constraint fk_stu foreign key (studentID) references student (studentID)
);

-- Add class
insert into class(className, startDate, status)
values ('A1', '2008-12-20', 1);
insert into class(className, startDate, status)
values ('A1', '2008-12-22', 1);
insert into class(className, startDate, status)
values ('B3', curdate(), 0);

-- Add student
insert into student(studentName, address, phone, status, classID)
values ('Hung', 'Ha Noi', '0912113113', 1, 1);
insert into student(studentName, address, status, classID)
values ('Hoa', 'Hai Phong', 1, 1);
insert into student(studentName, address, phone, status, classID)
values ('Manh', 'HCM', '0123123123', 0, 2);

-- Add subject
insert into subject(subName, credit, status)
values ('CF', 5, 1);
insert into subject(subName, credit, status)
values ('C', 6, 1);
insert into subject(subName, credit, status)
values ('HDJ', 5, 1);
insert into subject(subName, credit, status)
values ('RDBMS', 10, 1);

-- Add mark
insert into mark(subID, studentID, mark, examTimes)
values (1, 1, 8, 1);
insert into mark(subID, studentID, mark, examTimes)
values (1, 2, 10, 1);
insert into mark(subID, studentID, mark, examTimes)
values (2, 1, 12, 1);

update student
set classID = 2
where studentName = 'Hung';

update student
set phone = 'No phone'
where phone is null;

update class
set className = replace(className, 'New', 'Old')
where status = 1
  and className like 'New%';

update class
set status = 0
where classID not in (select classID from student);

update subject
set status = 0
where subID not in (select mark.subID from mark);

select *
from student
where studentName like 'h%';

select *
from class
where month(startDate) = 12;

select max(credit)
from subject;

select *
from subject
where credit = (select max(credit) from subject);

select *
from subject
where credit between 3 and 5;

select C.classID, className, studentName, address from class C
join student S on C.classID = S.classID;

select S.* from subject S
right join mark M on S.subID = M.subID
where S.subID not in (M.subID);



select *
from subject;
select *
from student;
select *
from class;
select *
from mark;