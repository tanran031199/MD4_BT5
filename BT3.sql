create schema if not exists studenTest;

use studenTest;

create table if not exists test
(
    testID int auto_increment primary key,
    name   varchar(45)
);

create table if not exists students
(
    RN   int auto_increment primary key,
    name varchar(45),
    age  tinyint
);

create table if not exists studentTest
(
    RN     int,
    testID int,
    date   date,
    mark   float,
    constraint fk_test foreign key (testID) references test (testID),
    constraint fk_stu foreign key (RN) references students (RN)
);

-- Create test
delimiter //
create procedure if not exists insert_test(inputName varchar(45))
begin
    insert into test(name) values (inputName);
end //
delimiter ;

-- Create student
delimiter //
create procedure if not exists insert_student(inputName varchar(45), inputAge tinyint)
begin
    insert into students(name, age) values (inputName, inputAge);
end //
delimiter ;

-- Create studentTest
delimiter //
create procedure if not exists insert_student_test(inputRN int, inputTestID int, inputDate date, inputMark float)
begin
    insert into studentTest(RN, testID, date, mark) values (inputRN, inputTestID, inputDate, inputMark);
end //
delimiter ;

-- Add test
call insert_test('EPC');
call insert_test('DWMX');
call insert_test('SQL1');
call insert_test('SQL2');

-- Add student
call insert_student('Nguyen Hong Ha', 20);
call insert_student('Truong Ngoc Anh', 30);
call insert_student('Tuan Minh', 25);
call insert_student('Dan Truong', 22);

-- Add studentTest
call insert_student_test(1, 1, '2006-07-17', 8);
call insert_student_test(1, 2, '2006-07-18', 5);
call insert_student_test(1, 3, '2006-07-19', 7);
call insert_student_test(2, 1, '2006-07-17', 7);
call insert_student_test(2, 2, '2006-07-18', 4);
call insert_student_test(2, 3, '2006-07-19', 2);
call insert_student_test(3, 1, '2006-07-17', 10);
call insert_student_test(3, 3, '2006-07-18', 1);

alter table students
    add constraint chk_age check (age > 15 and age < 55);

alter table studentTest
    modify mark float default 0;

alter table studentTest
    add constraint pk_stu_test primary key (RN, testID);

alter table test
    add constraint name_unique unique (name);

alter table test
    drop index name_unique;

select S.name as 'Student Name', T.name as 'Test Name', ST.mark as 'Mark', ST.date as 'Date'
from students S
         join studentTest ST on S.RN = ST.RN
         join test T on ST.testID = T.testID;

select S.RN as RN, S.name as Name, S.age as Age
from students S
         left join studentTest ST on S.RN = ST.RN
where testID is null;

select S.name as 'Student Name', T.name as 'Test Name', ST.mark as 'Mark', ST.date as 'Date'
from students S
         join studentTest ST on S.RN = ST.RN
         join test T on ST.testID = T.testID
where mark < 5;

select S.name as 'Student Name', avg(mark) as 'Average'
from students S
         join studentTest ST on S.RN = ST.RN
group by S.name;

select S.name as 'Student Name', avg(mark) as Average
from students S
         join studentTest ST on S.RN = ST.RN
group by S.name
order by avg(mark) desc
limit 1;

select T.name, max(ST.mark)
from test T
         join studenttest ST on T.testID = ST.testID
group by T.name;

select S.name 'Student Name', T.name 'Test Name'
from students S
         left join studentTest ST on S.RN = ST.RN
         left join test T on ST.testID = T.testID;

update students
set age = (age + 1);
alter table students
    add column status varchar(10);

update students
set status = case when age < 30 then 'Young' else 'Old' end;

select *
from students;

select S.name, T.name, ST.mark, ST.date
from students S
         join studentTest ST on S.RN = ST.RN
         join test T on ST.testID = T.testID
order by ST.date;

select S.*
from students S
         join studentTest ST on S.RN = ST.RN
where name like 'T%'
group by S.RN, S.name, S.age, S.status
having avg(ST.mark) > 4.5;

select S.RN, S.name, avg(ST.mark) as 'Average', rank() over (order by avg(ST.mark) desc) as 'Rank'
from students S
         join studentTest ST on S.RN = ST.RN
group by S.RN, S.name;

update students
set name = case when age > 20 then concat('Old ', name) else concat('Young ', name) end;

delete
from test
where testID not in (select studentTest.testID from studentTest);

select *
from test;

delete studentTest
from studentTest
         join (select RN from studentTest where mark < 5) as Subquery
              on studentTest.RN = Subquery.RN;

select *
from studentTest;
