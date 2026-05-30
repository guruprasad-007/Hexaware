CREATE DATABASE training_sql_db;
USE training_sql_db;

CREATE TABLE books
(
book_id INT PRIMARY KEY,
book_title VARCHAR(100),
category VARCHAR(50),
author VARCHAR(50),
price DECIMAL(10,2),
stock INT,
published_year INT
);

INSERT INTO books VALUES
(1, 'Python Basics', 'Programming', 'Ravi Kumar', 550, 30, 2021),
(2, 'Advanced SQL', 'Database', 'Priya Sharma', 750, 15, 2020),
(3, 'Data Engineering Guide', 'Data', 'Amit Verma', 1200, 10, 2023),
(4, 'Machine Learning Start', 'AI', 'Neha Reddy', 950, 8, 2022),
(5, 'Excel for Business', 'Business', 'Kiran Rao', 400, 50, 2019),
(6, 'Power BI Reports', 'Data', 'Sneha Patel', 850, 12, 2021),
(7, 'Java Fundamentals', 'Programming', 'Arjun Mehta', 600, 20, 2018),
(8, 'Cloud Basics', 'Cloud', 'Rahul Nair', 700, 18, 2022),
(9, 'SQL Interview Prep', 'Database', 'Farhan Ali', 500, 25, 2024),
(10, 'AI for Beginners', 'AI', 'Meera Singh', 650, 5, 2023);

select * from books;

select book_title, category, price from books;

select distinct category from books;

select * from books where category = 'Programming';

select * from books where price > 700;

select * from books where stock < 15;

SELECT * FROM books WHERE category IN ('Programming', 'Database', 'AI');

select * from books where price between 500 and 900;

select * from books where book_title like '%SQL%';

select * from books where book_title like 'Data%'; 

select * from books order by price desc;

select * from books order by category asc, price desc;

SELECT COUNT(*) AS total_books FROM books;

SELECT MAX(price) AS highest_price FROM books;

SELECT MIN(price) AS lowest_price FROM books;

SELECT AVG(price) AS average_price FROM books;

select sum(stock) as Total_stock from books;

SELECT category, COUNT(*) AS total_books FROM books GROUP BY category;

SELECT category, AVG(price) AS average_price 
FROM books GROUP BY category;

SELECT category, SUM(stock) AS total_stock 
FROM books 
GROUP BY category;

SELECT category, COUNT(*) AS total_books 
FROM books 
GROUP BY category 
HAVING COUNT(*) > 1;

SELECT category, AVG(price) AS average_price 
FROM books 
GROUP BY category 
HAVING AVG(price) > 700;


