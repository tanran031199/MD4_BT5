create schema if not exists QuanlySinhVien;

use QuanlySinhVien;

# drop schema QuanlySinhVien;

create table if not exists Classes
(
    classId   int auto_increment primary key,
    className varchar(45)
);

create table if not exists Students
(
    studentId   int auto_increment primary key,
    studentName varchar(45),
    age         int,
    email       varchar(45),
    check (age > 0)
);

create table if not exists ClassStudent
(
    studentId int,
    classId   int,
    constraint fk_cls_stu primary key (studentId, classId),
    constraint fk_student foreign key (studentId) references Students (studentId),
    constraint fk_cls foreign key (classId) references Classes (classId)
);

create table if not exists Subjects
(
    subjectId   int auto_increment primary key,
    subjectName varchar(45)
);

create table if not exists Marks
(
    Mark      int,
    subjectId int,
    studentId int,
    constraint fk_sbj foreign key (subjectId) references Subjects (subjectId),
    constraint fk_stu foreign key (studentId) references Students (studentId)
);

-- CRUD Class
delimiter //
create procedure if not exists insert_class(inputName varchar(45))
begin
    insert into Classes(className) values (inputName);
end //
delimiter ;

-- CRUD Student
delimiter //
create procedure if not exists insert_student(inputName varchar(45), inputAge int, inputEmail varchar(45))
begin
    insert into Students(studentName, age, email) values (inputName, inputAge, inputEmail);
end //
delimiter ;

-- CRUD ClassStudent
delimiter //
create procedure if not exists insert_cls_stu(inputStuID int, inputClsID int)
begin
    insert into ClassStudent(studentId, classId) values (inputStuID, inputClsID);
end //
delimiter ;

-- CRUD Subject
delimiter //
create procedure if not exists insert_subject(inputName varchar(45))
begin
    insert into Subjects(subjectName) values (inputName);
end //
delimiter ;

-- CRUD Mark
delimiter //
create procedure if not exists insert_mark(inputMark int, inputSubID int, inputStuID int)
begin
    insert into Marks(Mark, subjectId, studentId) values (inputMark, inputSubID, inputStuID);
end //
delimiter ;

-- Add Student
call insert_student('Nguyen Quang An', 18, 'an@yahoo.com');
call insert_student('Nguyen Cong Vinh', 20, 'vinh@gmail.com');
call insert_student('Nguyen Van Quyen', 19, 'quyen');
call insert_student('Pham Thanh Binh', 25, 'binh@com');
call insert_student('Nguyen Van Tai Em', 30, 'taiem@sport.vn');

-- Add Class
call insert_class('C0706L');
call insert_class('C0708G');

-- Add ClassStudent
call insert_cls_stu(1, 1);
call insert_cls_stu(2, 1);
call insert_cls_stu(3, 2);
call insert_cls_stu(4, 2);
call insert_cls_stu(5, 2);

-- Add Subject
call insert_subject('SQL');
call insert_subject('Java');
call insert_subject('C');
call insert_subject('Visual Basic');

-- Add Mark
call insert_mark(8, 1, 1);
call insert_mark(3, 2, 1);
call insert_mark(9, 1, 1);
call insert_mark(7, 1, 3);
call insert_mark(3, 1, 4);
call insert_mark(5, 2, 5);
call insert_mark(8, 3, 3);
call insert_mark(1, 3, 5);
call insert_mark(3, 2, 4);

select * from Students;

select * from Subjects;

select S.studentName, avg(Mark) as 'Điểm trung bình' from Students S
join Marks M on S.studentId = M.studentId
group by S.studentName;

select subjectName, Mark from Marks
join Subjects S on S.subjectId = Marks.subjectId
where Mark = (select max(Mark) from Marks);

select * from Marks order by Mark desc;

alter table Subjects modify column subjectName nvarchar(255);

update Subjects set subjectName = concat('« Day la mon hoc « ', subjectName);

alter table Students add constraint chk_age check ( age > 15 and age < 50 );

alter table ClassStudent drop foreign key fk_cls, drop foreign key fk_student;
alter table Marks drop foreign key fk_sbj, drop foreign key fk_stu;

delete from Students where studentId = 1;

alter table Students add column status bit(1) default 1;

update Students set status = 0;