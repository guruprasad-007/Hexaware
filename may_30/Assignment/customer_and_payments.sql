CREATE TABLE customers_new
(

customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50),
membership_type VARCHAR(30)
);

CREATE TABLE payments
(
payment_id INT PRIMARY KEY,
customer_id INT,
amount DECIMAL(10,2),
payment_mode VARCHAR(30),
payment_status VARCHAR(30)
);

INSERT INTO customers_new VALUES
(1, 'Ramesh Gupta', 'Hyderabad', 'Gold'),
(2, 'Sana Khan', 'Bangalore', 'Silver'),
(3, 'John Mathew', 'Mumbai', 'Gold'),
(4, 'Ayesha Begum', 'Chennai', 'Bronze'),
(5, 'Vikram Rao', 'Delhi', 'Silver'),
(6, 'Divya Sharma', 'Pune', NULL);

INSERT INTO payments VALUES
(1001, 1, 15000, 'UPI', 'Success'),
(1002, 1, 8000, 'Card', 'Success'),
(1003, 2, 5000, 'Cash', 'Pending'),
(1004, 3, 22000, 'UPI', 'Success'),
(1005, 7, 12000, 'Card', 'Failed'),
(1006, NULL, 3000, 'Cash', 'Pending'),
(1007, 4, NULL, 'UPI', 'Success'),
(1008, 5, 7000, NULL, 'Success');

SELECT * FROM customers_new 
WHERE customer_id IN (SELECT DISTINCT customer_id FROM payments WHERE customer_id IS NOT NULL);

SELECT * FROM customers_new c
WHERE NOT EXISTS (
    SELECT 1 FROM payments p 
    WHERE p.customer_id = c.customer_id
);

SELECT * FROM payments 
WHERE amount > (SELECT AVG(amount) FROM payments);

SELECT * FROM customers_new 
WHERE customer_id = (SELECT customer_id FROM payments WHERE amount = (SELECT MAX(amount) FROM payments));

SELECT * FROM customers_new 
WHERE membership_type = 'Gold' 
AND customer_id IN (SELECT customer_id FROM payments WHERE customer_id IS NOT NULL);

SELECT * FROM customers_new 
WHERE customer_id IN (
    SELECT customer_id FROM payments 
    GROUP BY customer_id 
    HAVING SUM(amount) > 10000
);

SELECT * FROM payments p
WHERE NOT EXISTS (
    SELECT 1 FROM customers_new c 
    WHERE c.customer_id = p.customer_id
);

SELECT * FROM customers_new c
WHERE EXISTS (
    SELECT 1 FROM payments p 
    WHERE p.customer_id = c.customer_id
);

SELECT * FROM customers_new c
WHERE NOT EXISTS (
    SELECT 1 FROM payments p 
    WHERE p.customer_id = c.customer_id
);

SELECT * FROM customers_new 
WHERE customer_id IN (
    SELECT customer_id FROM payments 
    WHERE amount > ALL (SELECT amount FROM payments WHERE customer_id = 2)
);