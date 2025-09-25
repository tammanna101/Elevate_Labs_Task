-- Here are example SQL operations for the "Customers" table including 
-- use of SELECT (all and specific columns), WHERE conditions (with AND, OR, LIKE, BETWEEN), and sorting with ORDER BY. -- 

       -- SELECT Queries-- 
-- Retrieve all columns for all customers:-- 
SELECT * 
FROM Customers;

-- Retrieve only names and emails: -- 
SELECT name, email 
FROM Customers;

         -- WHERE, AND, OR, LIKE, BETWEEN -- 
-- Find customers from California: -- 
SELECT * FROM
Customers WHERE state = 'CA';

-- Find customers from California or New York: -- 
SELECT * 
FROM Customers WHERE state = 'CA' OR state = 'NY';

-- Find customers registered between '2022-03-01' and '2022-06-30': -- 
SELECT * 
FROM Customers WHERE registered_date BETWEEN '2022-03-01' AND '2022-06-30';

-- Find customers whose name starts with 'A': -- 
SELECT * 
FROM Customers WHERE name LIKE 'A%';

-- Find customers from 'CA' with name containing 'Grace': -- 
SELECT * 
FROM Customers WHERE state = 'CA' AND name LIKE '%Grace%';

      -- ORDER BY Sorting-- 
-- List all customers in order of registration date (oldest first): -- 
SELECT * 
FROM Customers ORDER BY registered_date ASC;

-- List all customers alphabetically by city: -- 
SELECT * 
FROM Customers ORDER BY city;

-- List names and registered dates in reverse registration order: -- 
SELECT name, registered_date 
FROM Customers ORDER BY registered_date DESC;


-- Here are example SQL operations for the "product" table including 
-- use of SELECT (all and specific columns), WHERE conditions (with AND, OR, LIKE, BETWEEN), and sorting with ORDER BY. --

           -- SELECT Queries -- 
-- Retrieve all columns for all products: -- 
SELECT * 
FROM Products;

-- Retrieve only product_name and price:-- 
SELECT product_name, price 
FROM Products;

		 -- WHERE, AND, OR, LIKE, BETWEEN -- 
-- Find all products in the 'Electronics' category: -- 
SELECT * 
FROM Products WHERE category = 'Electronics';

-- Find products by 'Sony' or 'Apple': -- 
SELECT * 
FROM Products WHERE brand = 'Sony' OR brand = 'Apple';

-- Find products with price between 100 and 800: -- 
SELECT * 
FROM Products WHERE price BETWEEN 100 AND 800;

-- Find products whose name contains 'phone': -- 
SELECT * 
FROM Products WHERE product_name LIKE '%phone%';

-- Find electronics by Samsung added after '2023-01-01': -- 
SELECT * 
FROM Products WHERE category = 'Electronics' AND brand = 'Samsung' AND added_date > '2023-01-01';

     --    ORDER BY Sorting -- 
-- List all products sorted by price ascending: -- 
SELECT * 
FROM Products ORDER BY price ASC;

-- List all products by added_date descending: -- 
SELECT * 
FROM Products ORDER BY added_date DESC;

-- Show product_name and stock ordered by stock (highest first): -- 
SELECT product_name, stock 
FROM Products ORDER BY stock DESC;


-- Here are example SQL operations for the "order" table including 
-- use of SELECT (all and specific columns), WHERE conditions (with AND, OR, LIKE, BETWEEN), and sorting with ORDER BY. --

-- Select all columns -- 
SELECT * 
FROM Orders;

-- Select only specific columns -- 
SELECT order_id, customer_id, product_id, total_amount, status
FROM Orders;

  -- Apply WHERE, AND, OR, LIKE, BETWEEN 
-- Orders with status 'Delivered'
SELECT * 
FROM Orders
WHERE status = 'Delivered';

-- Orders where total_amount > 2000 AND status = 'Pending'
SELECT * 
FROM Orders
WHERE total_amount > 2000 AND status = 'Pending';

-- Orders where status is 'Cancelled' OR 'Shipment'
SELECT * 
FROM Orders
WHERE status = 'Cancelled' OR status = 'Shipment';

-- Orders where status contains 'Ship' (using LIKE)
SELECT * 
FROM Orders
WHERE status LIKE '%Ship%';

-- Orders between 2023-03-01 and 2023-03-05
SELECT * 
FROM Orders
WHERE order_date BETWEEN '2023-03-01' AND '2023-03-05';

      --  Sort with ORDER BY
-- Sort by total amount in ascending order
SELECT * 
FROM Orders
ORDER BY total_amount ASC;

-- Sort by total amount in descending order
SELECT * 
FROM Orders
ORDER BY total_amount DESC;

-- Sort first by status, then by total_amount descending
SELECT * 
FROM Orders
ORDER BY status ASC, total_amount DESC;
