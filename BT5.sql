create schema if not exists baitap5;

# drop schema baitap5;

use baitap5;

create table if not exists tblPhong
(
    phongID  int auto_increment primary key,
    tenPhong varchar(45),
    status   bit(1)
);

create table if not exists tblGhe
(
    gheID   int auto_increment primary key,
    phongID int,
    soGhe   varchar(10),
    constraint fk_room foreign key (phongID) references tblPhong (phongID)
);

create table if not exists tblPhim
(
    phimID   int auto_increment primary key,
    tenPhim  varchar(45),
    loaiPhim varchar(45),
    thoiGian int
);

create table if not exists tblVe
(
    phimID    int,
    gheID     int,
    ngayChieu date,
    status    bit(1),
    constraint pk_ve primary key (phimID, gheID),
    constraint fk_phim foreign key (phimID) references tblPhim (phimID),
    constraint fk_ghe foreign key (gheID) references tblGhe (gheID)
);

-- Create phong
delimiter //
create procedure if not exists insert_room(inputName varchar(45), inputStatus bit(1))
begin
    insert into tblPhong(tenPhong, status) values (inputName, inputStatus);
end //
delimiter ;

-- Create ghe
delimiter //
create procedure if not exists insert_seat(inputPhong int, inputSoGhe varchar(10))
begin
    insert into tblGhe(phongID, soGhe) values (inputPhong, inputSoGhe);
end //
delimiter ;

-- Create ve
delimiter //
create procedure if not exists insert_ticket(inputPhim int, inputGhe int, inputNgay date, inputStatus bit(1))
begin
    insert into tblVe(phimID, gheID, ngayChieu, status) values (inputPhim, inputGhe, inputNgay, inputStatus);
end //
delimiter ;

-- Create phim
delimiter //
create procedure if not exists insert_movie(inputName varchar(45), inputLoai varchar(45), inputGio int)
begin
    insert into tblPhim(tenPhim, loaiPhim, thoiGian) values (inputName, inputLoai, inputGio);
end //
delimiter ;

-- Add phong
call insert_room('Phòng chiếu 1', 1);
call insert_room('Phòng chiếu 2', 1);
call insert_room('Phòng chiếu 3', 0);

-- Add phim
call insert_movie('Em bé Hà Nội', 'Tâm lý', 90);
call insert_movie('Nhiệm vụ bất khả thi', 'Hành động', 100);
call insert_movie('Dị nhân', 'Viễn tưởng', 90);
call insert_movie('Cuốn theo chiều gió', 'Tình cảm', 120);

-- Add ghe
call insert_seat(1, 'A3');
call insert_seat(1, 'B5');
call insert_seat(2, 'A7');
call insert_seat(2, 'D1');
call insert_seat(3, 'T2');

-- Add ve
call insert_ticket(1, 1, '2008-10-20', 1);
call insert_ticket(1, 3, '2008-11-20', 1);
call insert_ticket(1, 4, '2008-12-23', 1);
call insert_ticket(2, 1, '2009-02-14', 1);
call insert_ticket(3, 1, '2009-02-14', 1);
call insert_ticket(2, 5, '2009-03-08', 0);
call insert_ticket(2, 3, '2009-03-08', 0);

select *
from tblPhim
order by thoiGian;

select tenPhim
from tblPhim
where thoiGian = (select max(thoiGian) from tblPhim);

select tenPhim
from tblPhim
where thoiGian = (select min(thoiGian) from tblPhim);

select soGhe
from tblGhe
where soGhe like 'A%';

alter table tblPhong
    modify status nvarchar(25);

update tblPhong
set status = case
                 when status = 0 then 'Đang sửa'
                 when status = 1 then 'Đang sử dụng'
                 else 'Unknow'
    end;

select *
from tblPhong;

select *
from tblPhim
where length(tenPhim) > 15
  and length(tenPhim) < 25;

select concat(tenPhong, ' ', status) from tblPhong;

