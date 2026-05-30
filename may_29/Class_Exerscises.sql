use retail_db;
create table customers(
customer_id int,
customer_name varchar(50),
city varchar(20)
);
insert into customers values
(1, 'Guru', 'Chennai'),
(2, 'Prasad', 'Hydrebad'),
(3, 'Gill', 'Ahemdabad');

set sql_safe_updates = 0;

update customers set city = 'Mumbai' where customer_id = 3;

set sql_safe_updates = 1;

create table products(
product_id int Primary key,
product_name varchar(20),
category varchar(20),
price decimal(10,2),
stock_quantity int,
supplier_city varchar(50)
);

insert into products values
(1, 'Laptop', 'electronic', 50000, 10, 'Chennai'),
(2, 'Cricket Bat', 'Sports Gear', 3000, 20, 'Kashmir'),
(3, 'Jeans', 'Cloth', 800, 40, 'Mumbai');

update products set price = 60000 where product_id = 1;
select * from products;

delete from products where product_id = 3;

drop table products;

create table products(
product_id int Primary key,
product_name varchar(20),
category varchar(20),
price decimal(10,2),
stock_quantity int,
supplier_city varchar(50)
);

iNSERT INTO products VALUES
(1,'Laptop','Electronics',55000,10,'Hyderabad'),
(2,'Mobile','Electronics',25000,25,'Bangalore'),
(3,'Printer','Electronics',18000,8,'Pune'),
(4,'Office Chair','Furniture',7500,15,'Mumbai'),
(5,'Desk','Furniture',12000,5,'Chennai'),
(6,'Notebook','Stationery',80,200,'Hyderabad'),
(7,'Pen','Stationery',20,500,'Delhi'),
(8,'Water Bottle','Accessories',500,50,'Bangalore');

select product_name, price from products;

select distinct category from products;

select * from products where price > 10000;

select * from products where stock_quantity > 20;

select * from products where price between 1000 and 10000;

select * from products where product_name like 'P%';

select product_name as Product,
price as Product_price from products;

select * from products order by price desc;

select count(*) from products where category = 'Electronics';

select sum(price) from products;


select category, sum(price) as ProductCount from products group by category;

drop table customers;

