create schema if not exists homeCenterShop;

# drop schema homeCenterShop;

use homeCenterShop;

create table if not exists Customers
(
    cID   int auto_increment primary key,
    cName varchar(45),
    cAge  int(3),
    check (cAge > 0)
);

create table if not exists Orders
(
    oID         int auto_increment primary key,
    cID         int,
    oDate       date,
    oTotalPrice float,
    constraint fk_cID foreign key (cID) references Customers (cID)
);

create table if not exists Products
(
    pID    int auto_increment primary key,
    pName  varchar(45),
    pPrice float,
    check (pPrice > 0)
);

create table if not exists OrderDetails
(
    oID   int,
    pID   int,
    odQTY int,
    constraint pk_oID_pID primary key (oID, pID),
    constraint fk_oID foreign key (oID) references Orders (oID),
    constraint fk_pID foreign key (pID) references Products (pID)
);

-- CRUD Customer
delimiter //
create procedure if not exists insert_customer(inputName varchar(45), inputAge int)
begin
    insert into Customers(cName, cAge) values (inputName, inputAge);
end //
delimiter ;

delimiter //
create procedure if not exists update_customer(inputCID int, inputName varchar(45), inputAge int)
begin
    update Customers set cName = inputName, cAge = inputAge where cID = inputCID;
end //
delimiter ;

delimiter //
create procedure if not exists delete_customer(inputCID int)
begin
    delete from Customers where cID = inputCID;
end //
delimiter ;

-- CRUD Order
delimiter //
create procedure if not exists insert_order(inputCID int, inputDate date, inputTotalPrice float)
begin
    insert into Orders(cID, oDate, oTotalPrice) values (inputCID, inputDate, inputTotalPrice);
end //
delimiter ;

delimiter //
create procedure if not exists update_order(inputOID int, inputCID int, inputDate date, inputTotalPrice float)
begin
    update Orders set cID = inputCID, oDate = inputDate, oTotalPrice = inputTotalPrice where oID = inputOID;
end //
delimiter ;

delimiter //
create procedure if not exists delete_order(inputOID int)
begin
    delete from Orders where oID = inputOID;
end //
delimiter ;

-- CRUD Product
delimiter //
create procedure if not exists insert_product(inputName varchar(45), inputPrice float)
begin
    insert into Products(pName, pPrice) values (inputName, inputPrice);
end //
delimiter ;

delimiter //
create procedure if not exists update_product(inputPID int, inputName varchar(45), inputPrice float)
begin
    update Products set pName = inputName, pPrice = inputPrice where pID = inputPID;
end //
delimiter ;

delimiter //
create procedure if not exists delete_product(inputPID int)
begin
    delete from Products where pID = inputPID;
end //
delimiter ;

-- CRUD OrderDetail
delimiter //
create procedure if not exists insert_order_detail(inputOID int, inputPID int, inputQTY int)
begin
    insert into OrderDetails(oID, pID, odQTY) values (inputOID, inputPID, inputQTY);
end //
delimiter ;

delimiter //
create procedure if not exists update_order_detail(inputOID int, inputPID int, inputQTY int)
begin
    update OrderDetails set odQTY = inputQTY where oID = inputOID and pID = inputPID;
end //
delimiter ;

delimiter //
create procedure if not exists delete_order_detail(inputOID int, inputPID int)
begin
    delete from OrderDetails where oID = inputOID and pID = inputPID;
end //
delimiter ;

-- Add Customer
call insert_customer('Minh Quan', 10);
call insert_customer('Ngoc Oanh', 20);
call insert_customer('Hong Ha', 50);

-- Add Order
call insert_order(1, '2006-03-21', null);
call insert_order(2, '2006-03-23', null);
call insert_order(1, '2006-03-16', null);

-- Add Product
call insert_product('May Giat', 3);
call insert_product('Tu Lanh', 5);
call insert_product('Dieu Hoa', 7);
call insert_product('Quat', 1);
call insert_product('Bep Dien', 2);

-- Add OrderDetail
call insert_order_detail(1, 1, 3);
call insert_order_detail(1, 3, 7);
call insert_order_detail(1, 4, 2);
call insert_order_detail(2, 1, 1);
call insert_order_detail(3, 1, 8);
call insert_order_detail(2, 5, 4);
call insert_order_detail(2, 3, 3);

select *
from Orders
order by oDate desc;

select pName, pPrice
from Products
where pPrice = (select max(pPrice) from Products);

select cName, pName
from Customers
         join Orders O on Customers.cID = O.cID
         join OrderDetails OD on O.oID = OD.oID
         join Products P on OD.pID = P.pID;

select cName
from Customers
         left join Orders O on Customers.cID = O.cID
where oID is null;

select O.oID, O.oDate, OD.odQTY, P.pName, P.pPrice from Orders O
join OrderDetails OD on O.oID = OD.oID
join Products P on P.pID = OD.pID;

select O.oID, O.oDate, sum(p.pPrice * OD.odQTY) from Orders O
join OrderDetails OD on O.oID = OD.oID
join Products P on OD.pID = P.pID
group by O.oID, O.oDate;