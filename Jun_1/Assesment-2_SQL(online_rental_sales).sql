CREATE DATABASE retail_capstone_db;
use retail_capstone_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    membership_type VARCHAR(30) CHECK (membership_type IN ('Gold', 'Silver', 'Bronze', 'Regular'))
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_mode VARCHAR(30) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    delivery_partner VARCHAR(50),
    delivery_status VARCHAR(30) NOT NULL,
    delivery_city VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

INSERT INTO customers (customer_id, customer_name, city, state, gender, membership_type) VALUES 
(101, 'Aarav Sharma', 'Hyderabad', 'Telangana', 'Male', 'Gold'),
(102, 'Aditi Rao', 'Hyderabad', 'Telangana', 'Female', 'Silver'),
(103, 'Rohan Verma', 'Mumbai', 'Maharashtra', 'Male', 'Gold'),
(104, 'Ananya Iyer', 'Bangalore', 'Karnataka', 'Female', 'Bronze'),
(105, 'Karan Patel', 'Mumbai', 'Maharashtra', 'Male', 'Regular'),
(106, 'Sneha Reddy', 'Hyderabad', 'Telangana', 'Female', 'Gold'),
(107, 'Rahul Das', 'Kolkata', 'West Bengal', 'Male', 'Silver'),
(108, 'Pooja Joshi', 'Delhi', 'Delhi', 'Female', 'Regular'),
(109, 'Vikram Singh', 'Bangalore', 'Karnataka', 'Male', 'Gold'),
(110, 'Meera Nair', 'Chennai', 'Tamil Nadu', 'Female', 'Silver'),
(111, 'Amit Mishra', 'Pune', 'Maharashtra', 'Male', 'Regular');

INSERT INTO products VALUES 
(201, 'Boat Wave Smartwatch', 'Electronics', 2499.00),
(202, 'OnePlus Nord CE4', 'Electronics', 24999.00),
(203, 'Sony WH-CH520 Headphones', 'Electronics', 4490.00),
(204, 'Levis Men Straight Jeans', 'Fashion', 1899.00),
(205, 'Anouk Women Ethnic Kurta', 'Fashion', 799.00),
(206, 'Puma Running Shoes', 'Fashion', 3200.00),
(207, 'Wakefit Orthopedic Mattress', 'Home Decor', 8500.00),
(208, 'Philips LED Desk Light', 'Home Decor', 1200.00),
(209, 'Prestige Electric Kettle', 'Home Decor', 999.00),
(210, 'Mi Powerbank 20000mAh', 'Electronics', 1999.00); 

INSERT INTO orders (order_id, customer_id, order_date, order_status) VALUES  
(301, 101, '2026-01-15', 'Delivered'), 
(302, 101, '2026-02-10', 'Delivered'),  
(303, 102, '2026-01-20', 'Delivered'), 
(304, 103, '2026-02-18', 'Delivered'), 
(305, 104, '2026-02-22', 'Cancelled'),  
(306, 105, '2026-03-01', 'Delivered'), 
(307, 106, '2026-03-05', 'Shipped'),     
(308, 107, '2026-03-10', 'Delivered'), 
(309, 108, '2026-03-12', 'Processing'),  
(310, 109, '2026-03-14', 'Delivered'), 
(311, 110, '2026-03-15', 'Cancelled'),  
(312, 102, '2026-03-18', 'Delivered'),  
(313, 103, '2026-03-20', 'Shipped'),     
(314, 106, '2026-03-22', 'Delivered'),  
(315, 101, '2026-03-25', 'Delivered'),  
(316, 104, '2026-03-28', 'Delivered');

INSERT INTO order_items VALUES 
(1, 301, 201, 1), 
(2, 301, 205, 2), 
(3, 302, 210, 1),
(4, 303, 204, 1), 
(5, 303, 206, 1), 
(6, 304, 202, 1),
(7, 305, 208, 1),
(8, 306, 209, 3),
(9, 307, 203, 1),
(10, 308, 205, 2),
(11, 309, 201, 1),
(12, 310, 207, 1),
(13, 311, 204, 2),
(14, 312, 206, 1),
(15, 313, 202, 1),
(16, 314, 208, 2), 
(17, 314, 210, 1),
(18, 315, 203, 1),
(19, 316, 205, 1);

INSERT INTO payments VALUES 
(401, 301, 'UPI', 'Success', 4097.00),
(402, 302, 'Credit Card', 'Success', 1999.00),
(403, 303, 'UPI', 'Success', 5099.00),
(404, 304, 'Net Banking', 'Success', 24999.00),
(405, 305, 'UPI', 'Failed', 0.00),      
(406, 306, 'COD', 'Success', 2997.00),
(407, 307, 'UPI', 'Success', 4490.00),
(408, 308, 'Debit Card', 'Success', 1598.00),
(409, 309, 'UPI', 'Pending', 2499.00),
(410, 310, 'Credit Card', 'Success', 8500.00),
(411, 311, 'UPI', 'Success', 3798.00),   
(412, 312, 'UPI', 'Success', 3200.00),
(413, 313, 'Credit Card', 'Success', 24999.00),
(414, 314, 'UPI', 'Success', 4399.00),
(415, 315, 'Debit Card', 'Success', 4490.00),
(416, 316, 'UPI', 'Success', 799.00);

INSERT INTO deliveries VALUES 
(501, 301, 'Delhivery', 'Delivered', 'Hyderabad'),
(502, 302, 'BlueDart', 'Delivered', 'Hyderabad'),
(503, 303, 'Delhivery', 'Delivered', 'Hyderabad'),
(504, 304, 'Xpressbees', 'Delivered', 'Mumbai'),
(505, 305, 'None', 'Cancelled', 'Bangalore'),
(506, 306, 'BlueDart', 'Delivered', 'Mumbai'),
(507, 307, 'Delhivery', 'Pending', 'Hyderabad'), 
(508, 308, 'Shadowfax', 'Delivered', 'Kolkata'),
(510, 310, 'BlueDart', 'Delivered', 'Bangalore'),
(511, 311, 'None', 'Cancelled', 'Chennai'),
(512, 312, 'Delhivery', 'Delivered', 'Hyderabad'),
(513, 313, 'Xpressbees', 'Pending', 'Mumbai'),     
(514, 314, 'Shadowfax', 'Delivered', 'Hyderabad'),
(515, 315, 'Delhivery', 'Delivered', 'Hyderabad'),
(516, 316, 'BlueDart', 'Failed', 'Bangalore');

-- Q1
Select * from customers;

-- Q2
select customer_name, city, membership_type from customers;

-- Q3
SELECT * FROM products ORDER BY price DESC;

-- Q4
SELECT * FROM customers WHERE city = 'Hyderabad';

-- Q5
SELECT * FROM customers WHERE membership_type = 'Gold';

-- Q6
SELECT * FROM products WHERE price BETWEEN 500 AND 5000;

-- Q7
SELECT * FROM products WHERE category IN ('Electronics', 'Fashion');

-- Q8
SELECT * FROM orders WHERE order_date > '2026-01-01';

-- Q9
SELECT * FROM payments WHERE payment_mode = 'UPI';

-- Q10
SELECT * FROM deliveries WHERE delivery_status = 'Pending';

-- Q11
SELECT COUNT(*) AS total_customers FROM customers;

-- Q12
SELECT COUNT(*) AS total_orders FROM orders;

-- Q13
SELECT COUNT(*) AS total_products FROM products;

-- Q14
SELECT SUM(amount) AS total_revenue FROM payments WHERE payment_status = 'Success';

-- Q15
SELECT AVG(amount) AS average_payment_amount FROM payments;

-- Q16
SELECT MAX(amount) AS highest_payment FROM payments;

-- Q17
SELECT MIN(amount) AS lowest_payment FROM payments;

-- Q18
SELECT city, COUNT(*) AS customer_count FROM customers GROUP BY city;

-- Q19
SELECT category, COUNT(*) AS product_count FROM products GROUP BY category;

-- Q20
SELECT order_status, COUNT(*) AS order_count FROM orders GROUP BY order_status;

-- Q21
SELECT c.customer_name, o.order_id, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- Q22
SELECT oi.order_id, p.product_name, oi.quantity, p.price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- Q23
SELECT c.customer_name, p.product_name, oi.quantity, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- Q24
SELECT order_id, payment_mode, payment_status, amount FROM payments;

-- Q25
SELECT order_id, delivery_partner, delivery_status FROM deliveries;

-- Q26
SELECT 
    c.customer_name, 
    c.city AS customer_city, 
    o.order_id, 
    o.order_date, 
    p.product_name, 
    p.category, 
    oi.quantity, 
    p.price, 
    pay.payment_status, 
    d.delivery_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN payments pay ON o.order_id = pay.order_id
LEFT JOIN deliveries d ON o.order_id = d.order_id;

-- Q27
SELECT c.city, SUM(p.amount) AS total_revenue
FROM payments p
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE p.payment_status = 'Success'
GROUP BY c.city;

-- Q28
SELECT c.customer_name, SUM(p.amount) AS total_revenue
FROM payments p
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE p.payment_status = 'Success'
GROUP BY c.customer_id, c.customer_name;

-- Q29
SELECT p.product_name, SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name;

-- Q30
SELECT p.category, SUM(pay.amount) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN payments pay ON oi.order_id = pay.order_id
WHERE pay.payment_status = 'Success'
GROUP BY p.category;

-- Q31
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Q32
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1;

-- Q33
SELECT p.category, SUM(pay.amount) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN payments pay ON oi.order_id = pay.order_id
WHERE pay.payment_status = 'Success'
GROUP BY p.category
HAVING SUM(pay.amount) > 10000;

-- Q34
SELECT city, COUNT(*) AS customer_count 
FROM customers 
GROUP BY city 
HAVING COUNT(*) > 2;

-- Q35
SELECT p.product_name, SUM(oi.quantity) AS times_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) > 3;

-- Q36
SELECT * FROM customers 
WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);

-- Q37
SELECT * FROM customers 
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- Q38
SELECT * FROM products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM order_items);

-- Q39
SELECT * FROM payments 
WHERE amount > (SELECT AVG(amount) FROM payments);

-- Q40
SELECT * FROM customers 
WHERE customer_id = (
    SELECT o.customer_id 
    FROM orders o 
    JOIN payments p ON o.order_id = p.order_id 
    ORDER BY p.amount DESC 
    LIMIT 1
);

-- Q41
SELECT * FROM products 
WHERE price > (SELECT AVG(price) FROM products);

-- Q42
SELECT * FROM customers 
WHERE customer_id IN (
    SELECT DISTINCT o.customer_id 
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.category = 'Electronics'
);

-- Q43
SELECT * FROM orders 
WHERE order_id IN (SELECT order_id FROM payments WHERE payment_status = 'Success');

-- Q44
SELECT * FROM orders 
WHERE order_id IN (SELECT order_id FROM deliveries WHERE delivery_status <> 'Delivered');

-- Q45
SELECT c.customer_id, c.customer_name, SUM(p.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Success'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(p.amount) > (
    SELECT AVG(customer_total_spending) FROM (
        SELECT SUM(amount) AS customer_total_spending 
        FROM payments pay
        JOIN orders ord ON pay.order_id = ord.order_id
        WHERE pay.payment_status = 'Success'
        GROUP BY ord.customer_id
    ) AS spending_table
);

-- Q46
SELECT * FROM orders 
WHERE order_id NOT IN (SELECT order_id FROM payments);

-- Q47
SELECT * FROM orders 
WHERE order_id NOT IN (SELECT order_id FROM deliveries);

-- Q48
SELECT * FROM payments WHERE amount IS NULL OR amount = 0;

-- Q49
SELECT o.order_id, o.order_status, p.payment_status, p.amount 
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'Cancelled' AND p.payment_status = 'Success';

-- Q50
SELECT o.order_id, o.order_status, p.payment_status 
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'Delivered' AND p.payment_status = 'Failed';

-- Q51
SELECT * FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Q52
SELECT * FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;