create database amazon;
use amazon;
use amazon;
use amazon;
-- text change to varchar
alter table Customers
modify column customerID varchar(50);
alter table  order_details
modify column orderID varchar(50);
alter table order_details
modify column productID varchar(50);
alter table orders
modify column orderID varchar(50);
alter table orders
modify column CustomerID varchar(50);
alter table products
modify column productID varchar(50);
alter table products
modify column supplierID varchar(50);
alter table reviews
modify column reviewID varchar(50);
alter table reviews
modify column productID varchar(50);
alter table reviews
modify column CustomerID varchar(50);
alter table suppliers
modify column supplierID varchar(50);
-- add constraint primary key and foregin key table
alter table Customers
add constraint new_constraint primary key(CustomerID);
alter table orders
add constraint new_constraint primary key(orderID);
alter table products
add constraint new_constraint primary key(productID);
alter table reviews
add constraint new_constraint primary key(reviewID);
alter table suppliers
add constraint new_constraint primary key(supplierID);
-- foregin key
alter table order_details
add constraint fk_order foreign key(orderID)references orders(orderID),
add constraint fk_product foreign key(productID)references products(productID);
ALTER TABLE orders  
ADD CONSTRAINT fk_customers FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID);
Insert into suppliers(SupplierID)
select distinct SupplierID
from products 
where SupplierID not in (Select SupplierID from suppliers);
alter table products 
add constraint fk_Supplier foreign key(supplierID)references supplier(supplierID);
alter table reviews
add constraint fk_prod foreign key(productID)references products(productID),
add constraint fk_cus foreign key(CustomerID) REFERENCES customers(CustomerID);
-- Task 3: Write a query to:
select * from Customers;
select city from Customers;
select * from products;
select *from Customers WHERE city='port calebstad';
select *from products where category='fruits';

-- task 4 (ddl statement)
-- customer ib as the primary key
alter table Customers add constraint new_constraint primary key(CustomerID);
-- ensure age cannot be null and must be greater than 18
alter table Customers modify column age int not null;
alter table Customers add constraint chk_age check(age>=18);
-- change data type in name
alter table Customers
modify column name varchar(40);
-- add a unique constraint for name
alter table Customers
add constraint new_constraint unique(name);

-- (DML TASK 5) INSERT 3 ROWS INTO THE PRODUCT TABLE USING INSERT STATEMENTS.
insert into products values
(101, "orange", "fruit", "Sub-fruit-4", 300, 20, "eafcc3e7-8363-4392-b278-1cc6efc9a2a2"),
(102,"cake", "snack", "Sub-Bakery-3", 240, 30, "7524d174-62e4-468f-8b7b-b8e555+73638"), 
(103, "beetroot", "vegetable", "Sub-Vegetables-4", 350, 25," 4636a00e-3913-46a1-a2bb-896a3d677ac4");

-- (TASK 6) Update the stock quantity of a product shere Popduct 30 matches a specific ID.
update products set StockQuantity=60 where productID="c0898936-8142-4fag-ac60-2ecba78f8aa8";

-- (TASK 7)Delete a supplier from the Suppliers table where their city matches a specific value. 
delete from suppliers where city="Schneidermouth";
set sql_safe_updates=0;
-- Constraints and Operators (TASK 8)
-- Add a CHECK constraint to ensure that ratings in the Reviews table are between 1 and 5.
alter table reviews add constraint chk_rate check(rating between 1 and 5);
-- Add a DEFAULT constraint for the Primellember column in the Customers table (default value: "No"). (default
alter table customers modify column PrimeMember varchar(10) default "no";
select *from products;

-- Clauses and Aggregations (Task 9)
-- WHERE clause to find orders placed after 2024-01-01.
select *from orders where Orderdate>2024-01-01;
-- HAVING clause to list products with average ratings greater than 4.
select ProductID, avg(rating) as avg_rating from reviews group by ProductID having avg(rating)>4;

-- task 10: 1. calculate the customer each costomers total spending
-- 2. rank customers based on their spending
-- 3. identify customers who have spent more than 5,000
select CustomerID,sum(orderamount)from orders group by CustomerID;
select CustomerID,orderamount from orders order by orderamount desc;
select CustomerID,orderamount from orders where orderamount>500;
-- task 11
-- joins snd orderdetails table to calculate total revenue per order.
 select od.orderID, od.productID, o.CustomerID, (od.quantity*od.unitprice) as total_revenue from order_details as od
 left join orders as o on o.orderid=od.orderid;
 -- 2.identify customer who placed the most orders in a specific time period.
 select CustomberID,orderamount from orders order by orderamount desc limit 3;
 -- 3.Find the supplier with the most products in stock.
 select productid,supplierid,productname,stockquantity from products order by stockquantity desc limit 1;
 select max(stockquantity)from products;
 -- TASK 12
 -- Seperate product categories and subcategories into a table.
 select * from products_name;
 -- create foregin keys to maintain relationships.
 alter table products_name modify column productid varchar(50);
alter table products_name add constraint new_constraint_product foreign key(productid)references products(productid);
 
 -- TASK 13
 -- identify  the top 3 products based on sales revenue
 select CustomerID,orderID,orderamount from orders where orderamount=0;
 -- task 14
 -- which cities have the highest concentration of prime numbers.
 select max(quantity)from order_details;
 select productname,category from products where productid=(select max(quantity)from order_details);





