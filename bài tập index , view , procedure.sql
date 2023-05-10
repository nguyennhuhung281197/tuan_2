create database Products_1 ;
use Products_1;


create table Products(
    productCode int primary key ,
    productName varchar(30),
    productPrice decimal,
    productAmount int,
    productDescription varchar(255),
    productStatus bit
);

create unique index index_ProDuctCode on Products(productCode);

insert into Products (productCode) values (6);

create index index_productName_productPrice on Products( productName , productPrice);

explain select * from Products
where productName = 'hung';

create or replace view Products_view as
    select productCode,productName,productPrice,productAmount,productDescription,productStatus from Products;

select * from Products_view;

update products_view set productName = 'thu'
where productCode = 6;

delimiter //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END;
// delimiter ;


delimiter //
create procedure AddProcedure (
in pproductCode int ,
in pproductName varchar(30),
in pproductPrice decimal,
in pproductAmount int,
in pproductDescription varchar(255),
in pproductStatus bit,
out pp int,
out dd int
)
begin
    insert into products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
        values (pproductCode, pproductName,pproductPrice,pproductAmount,pproductDescription,pproductStatus);
    select count(productName)
        into pp
    from products;
    select avg(productPrice)
    into dd
    from products;

end; //
delimiter ;
drop procedure AddProcedure;
call GetAllProducts();
call AddProcedure(18, 'cc',10,20,'no',true, @pp, @dd);
select @pp, @dd;