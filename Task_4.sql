-- 1.Apply aggregate functions on numeric columns
-- 2.Use GROUP BY to categorize
-- 3.Filter groups using HAVING) Here are SQL query examples based on Customers table 

-- 1) Here is an example applying COUNT (to count customers), MIN, and MAX to the registered_date column and grouping by state -- .
SELECT state,COUNT(*) AS total_customers,
MIN(registered_date) AS earliest_registration,
MAX(registered_date) AS latest_registration
FROM Customers
GROUP BY state
HAVING COUNT(*) >= 2;

-- 2) Retrieve the most recent customer per state
SELECT c.*
FROM Customers c
    INNER JOIN (SELECT state, MAX(registered_date) AS max_date
	FROM Customers
	GROUP BY state
    ) mc ON c.state = mc.state AND c.registered_date = mc.max_date;

-- 3)Count of Customers per City -- 
SELECT city, COUNT(*) AS num_customers
FROM Customers
GROUP BY city;

-- 4)States with No Customers in 2022 --
SELECT state
FROM Customers
GROUP BY state
HAVING SUM(CASE WHEN YEAR(registered_date) = 2022 THEN 1 ELSE 0 END) = 0;

-- 5)Find cities with more than one customer -- 
SELECT city, COUNT(*) AS num_customers
FROM Customers
GROUP BY city
HAVING COUNT(*) > 1;

--  6)Show the number of customers registered each month -- 
SELECT YEAR(registered_date) AS year, 
MONTH(registered_date) AS month, COUNT(*) AS num_customers
FROM Customers
GROUP BY YEAR(registered_date), MONTH(registered_date);

-- 7)Find the earliest registered customer in each city -- 
SELECT city, MIN(registered_date) AS earliest_registration
FROM Customers
GROUP BY city;

-- 1.Apply aggregate functions on numeric columns
-- 2.Use GROUP BY to categorize
-- 3.Filter groups using HAVING) Here are SQL query examples based on Products table :

-- 1. Apply aggregate functions on numeric columns -- 
SELECT COUNT(*) AS total_products,
    SUM(price) AS total_value,
    AVG(price) AS average_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    SUM(stock) AS total_stock
FROM Products;

-- 2. Use GROUP BY to categorize -- 
SELECT category,
    COUNT(*) AS product_count,
    AVG(price) AS average_price,
    SUM(stock) AS total_stock
FROM Products
GROUP BY category;

-- 3. Filter groups using HAVING --
SELECT category,
    AVG(price) AS average_price,
    SUM(stock) AS total_stock
FROM Products
GROUP BY category
HAVING AVG(price) > 300;

-- 4. Minimum and Maximum Stock by Brand -- 
SELECT brand, 
    MIN(stock) AS min_stock, 
    MAX(stock) AS max_stock
FROM Products
GROUP BY brand;

-- 5. Count of Products and Total Value by Brand (with HAVING) -- 
SELECT brand,
    COUNT(*) AS product_count,
    SUM(price * stock) AS inventory_value
FROM Products
GROUP BY brand
HAVING COUNT(*) > 1;

-- 6. Average Price and Stock by Category with HAVING -- 
SELECT category, 
    AVG(price) AS avg_price, 
    AVG(stock) AS avg_stock
FROM Products
GROUP BY category
HAVING AVG(stock) > 100;

-- 1.Apply aggregate functions on numeric columns
-- 2.Use GROUP BY to categorize
-- 3.Filter groups using HAVING) Here are SQL query examples based on Orders table 

-- Total sales amount
SELECT SUM(total_amount) AS total_sales
FROM Orders;

-- Average order amount
SELECT AVG(total_amount) AS avg_order
FROM Orders;

-- Highest and lowest order value
SELECT MAX(total_amount) AS max_order,
       MIN(total_amount) AS min_order
FROM Orders;

-- Total quantity ordered
SELECT SUM(quantity) AS total_quantity
FROM Orders;

       -- Use GROUP BY to categorize 
-- Total sales by each customer
SELECT customer_id, SUM(total_amount) AS total_sales
FROM Orders
GROUP BY customer_id;

-- Count of orders by status
SELECT status, COUNT(*) AS total_orders
FROM Orders
GROUP BY status;

-- Average order amount per product
SELECT product_id, AVG(total_amount) AS avg_amount
FROM Orders
GROUP BY product_id;

--    Filter groups using HAVING -- 
 -- Customers whose total sales > 200
SELECT customer_id, SUM(total_amount) AS total_sales
FROM Orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200;

-- Products with average order value > 100
SELECT product_id, AVG(total_amount) AS avg_amount
FROM Orders
GROUP BY product_id
HAVING AVG(total_amount) > 100;

-- Status groups with more than 1 order
SELECT status, COUNT(*) AS order_count
FROM Orders
GROUP BY status
HAVING COUNT(*) > 1;
 