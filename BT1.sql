create schema if not exists demo;

use demo;

create table if not exists Products
(
    id                 int primary key,
    productCode        int,
    productName        varchar(45),
    productPrice       float,
    productAmount      int,
    productDescription text,
    productStatus      bit(2)
);

delimiter //
create procedure if not exists proc_insert_pro(inputCode int, inputName varchar(45), inputPrice float, inputAmount int,
                                               inputDescription text, inputStatus bit(2))
begin
    insert into Products(productCode, productName, productPrice, productAmount, productDescription,
                         productStatus) value (inputCode, inputName, inputPrice, inputAmount, inputDescription,
                                               inputStatus);
end //
delimiter ;

delimiter //
create procedure if not exists proc_update_pro(inputId int, inputCode int, inputName varchar(45), inputPrice float,
                                               inputAmount int, inputDescription text, inputStatus bit(2))
begin
    update Products
    set productCode        = inputCode,
        productName        = inputName,
        productPrice       = inputPrice,
        productAmount      = inputAmount,
        productDescription = inputDescription,
        productStatus      = inputStatus
    where id = inputId;
end //
delimiter ;

delimiter //
create procedure if not exists proc_delete_pro(inputId int)
begin
    delete from Products where id = inputId;
end //
delimiter ;

# drop procedure proc_insert_pro;

call proc_insert_pro(1, 5, 'Áo thun 1', 100, 5, 'Des 1', 1);
call proc_insert_pro(2, 10, 'Áo thun 2', 80, 5, 'Des 2', 1);
call proc_insert_pro(3, 2, 'Áo thun 3', 200, 5, 'Des 3', 1);
call proc_insert_pro(4, 4, 'Áo thun 4', 110, 5, 'Des 4', 1);
call proc_insert_pro(5, 9, 'Áo thun 5', 170, 5, 'Des 5', 1);
call proc_insert_pro(6, 18, 'Áo thun 6', 220, 5, 'Des 6', 1);
call proc_insert_pro(7, 14, 'Áo thun 7', 60, 5, 'Des 7', 1);
call proc_insert_pro(8, 3, 'Áo thun 8', 150, 5, 'Des 8', 1);
call proc_insert_pro(9, 20, 'Áo thun 9', 70, 5, 'Des 9', 1);
call proc_insert_pro(10, 22, 'Áo thun 10', 100, 5, 'Des 10', 1);
call proc_insert_pro(11, 19, 'Áo thun 11', 110, 5, 'Des 11', 1);
call proc_insert_pro(12, 6, 'Áo thun 12', 110, 5, 'Des 12', 1);
call proc_insert_pro(13, 8, 'Áo thun 13', 110, 5, 'Des 13', 1);
call proc_insert_pro(14, 7, 'Áo thun 14', 110, 5, 'Des 14', 1);


explain
select *
from Products
where productCode = 10;

create view product_view as
select productCode, productName, productPrice, productStatus
from Products;

update product_view
set productName = 'Áo thun 01'
where productCode = 5;

select *
from product_view;

drop view product_view;

alter table Products
    add constraint pro_unique unique index (productCode);

drop index pro_unique on Products;

create index pro_compo_index
    on Products (productName, productPrice);

drop table Products;

