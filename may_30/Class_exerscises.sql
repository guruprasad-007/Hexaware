use retail_db;
CREATE TABLE customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE orders
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    order_amount DECIMAL(10,2),
    order_status VARCHAR(30)
);

INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'Hyderabad', '9876543210'),
(2, 'Priya Reddy', 'Bangalore', '9876543211'),
(3, 'Amit Kumar', 'Mumbai', NULL),
(4, 'Sneha Patel', 'Chennai', '9876543213'),
(5, 'Arjun Verma', NULL, '9876543214'),
(6, 'Neha Singh', 'Delhi', '9876543215');

INSERT INTO orders VALUES
(101, 1, 'Laptop', 55000, 'Delivered'),
(102, 1, 'Mouse', 700, 'Delivered'),
(103, 2, 'Mobile', 25000, 'Shipped'),
(104, 3, 'Keyboard', NULL, 'Pending'),
(105, 7, 'Printer', 18000, 'Delivered'),
(106, NULL, 'Office Chair', 7500, 'Pending'),
(107, 4, NULL, 12000, 'Cancelled'),
(108, 8, 'Monitor', 15000, NULL);

select c.customer_id, c.customer_name, c.city, o.order_id, o.customer_id as order_customer_id, o.product_name, o.order_amount from customers c
left join orders o on c.customer_id = o.customer_id 

union 

select c.customer_id, c.customer_name, c.city, o.order_id, o.customer_id as order_customer_id, o.product_name, o.order_amount from customers c
right join orders o on c.customer_id = o.customer_id;

select * from customers where customer_id in 
(
select customer_id
from orders
);

select * from orders where order_amount > 
(
select avg(order_amount)
from orders
);

SELECT * FROM orders 
WHERE customer_id IN (
    SELECT customer_id 
    FROM customers 
    WHERE city IN ('Hyderabad', 'Bangalore')
);

SELECT * FROM orders 
WHERE order_amount = (
    SELECT MIN(order_amount) 
    FROM orders
); 

SELECT * FROM customers 
WHERE customer_id IN (
    SELECT customer_id 
    FROM orders 
    WHERE order_amount > (SELECT order_amount FROM orders WHERE order_id = 101)
);