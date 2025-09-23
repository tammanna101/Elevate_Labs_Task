create database Task1;
use Task1;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    registered_date DATE
);
INSERT INTO Customers VALUES
(1, 'Alice Smith', 'alice@example.com', '9876543210', 'New York', 'NY', '2022-01-10'),
(2, 'Bob Johnson', 'bob@example.com', '8765432109', 'Los Angeles', 'CA', '2022-02-15'),
(3, 'Charlie Lee', 'charlie@example.com', '7654321098', 'Chicago', 'IL', '2022-03-20'),
(4, 'David Kim', 'david@example.com', '6543210987', 'Houston', 'TX', '2022-04-25'),
(5, 'Eva Brown', 'eva@example.com', '5432109876', 'Phoenix', 'AZ', '2022-05-30'),
(6, 'Frank Miller', 'frank@example.com', '4321098765', 'Philadelphia', 'PA', '2022-06-10'),
(7, 'Grace Wilson', 'grace@example.com', '3210987654', 'San Diego', 'CA', '2022-07-18');


-- UPDATE Examples  -- 
-- 1. Update phone number of Bob Johnson:-- 
UPDATE Customers
SET phone = '1112223333' 
WHERE customer_name = 'Bob Johnson';

-- 2. Update city and state for customers in California (CA):-- 
UPDATE Customers 
SET city = 'San Francisco', 
state = 'CA' WHERE state = 'CA';

-- 3. Set default email domain if email is NULL:-- 
UPDATE Customers
SET email = CONCAT(customer_name, '@defaultmail.com') 
WHERE email IS NULL;

-- 4. Extend registered_date by 30 days for Texas customers:-- 
UPDATE Customers
SET registered_date = DATE_ADD(registered_date, INTERVAL 30 DAY)
WHERE state = 'TX';

-- 5. Change phone numbers starting with '987' to '777': -- 
UPDATE Customers 
SET phone = REPLACE(phone, '987', '777') 
WHERE phone LIKE '987%';

-- DELETE Examples -- 
-- 1. Delete a customer by email:-- 
DELETE FROM Customers 
WHERE email = 'eva@example.com';

-- 2. Delete all customers from New York (NY):-- 
DELETE FROM Customers
 WHERE state = 'NY';
 
-- 3. Delete customers registered after July 2022:-- 
DELETE FROM Customers
 WHERE registered_date > '2022-07-01';
 
-- 4. Delete customers with NULL phone numbers:-- 
DELETE FROM Customers 
WHERE phone IS NULL;











CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT,
    brand VARCHAR(50),
    added_date DATE
);
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 799.99, 50, 'Dell', '2023-01-05'),
(102, 'Smartphone', 'Electronics', 599.99, 100, 'Samsung', '2023-01-10'),
(103, 'Tablet', 'Electronics', 399.99, 80, 'Apple', '2023-01-15'),
(104, 'Headphones', 'Accessories', 99.99, 200, 'Sony', '2023-01-20'),
(105, 'Monitor', 'Electronics', 199.99, 40, 'LG', '2023-01-25'),
(106, 'Keyboard', 'Accessories', 49.99, 150, 'Logitech', '2023-01-30'),
(107, 'Mouse', 'Accessories', 29.99, 180, 'HP', '2023-02-01');

-- UPDATE Examples  -- 
-- 1: Update Brand for All Electronics-- 
UPDATE Products
SET brand = 'Generic'
WHERE category = 'Electronics';

--  2: Update Price for a Specific Brand  -- 
UPDATE Products
SET price = price * 1.10
WHERE brand = 'Sony';

-- 3: Update Stock for a Range of Products  -- 
UPDATE Products
SET stock = 150
WHERE product_id BETWEEN 101 AND 103;

-- 4:Update Product Name for Specific Brand -- 
UPDATE Products
SET product_name = 'Premium Tablet'
WHERE brand = 'Apple';


-- 5: Update All Prices in a Category -- 
UPDATE Products
SET price = price - 50
WHERE category = 'Accessories';

-- 6: Update Multiple Columns Based on Stock -- 
UPDATE Products
SET price = 0, brand = 'Clearance'
WHERE stock < 50;

-- 7: Update Stock for a Particular Brand -- 
UPDATE Products
SET stock = stock + 10
WHERE brand = 'Samsung';

-- DELETE Examples --
--  1: Delete Out-of-Stock Products -- 
DELETE FROM Products
WHERE stock = 0;

-- 2: Delete Accessories Added Before a Date -- 
DELETE FROM Products
WHERE category = 'Accessories'
AND added_date < '2023-01-15';

-- 3: Delete Products After a Certain Date -- 
DELETE FROM Products
WHERE added_date > '2023-01-20';

-- 4: Delete Specific Brand and Price -- 
DELETE FROM Products
WHERE brand = 'LG'
AND price < 300;


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Orders VALUES
(201, 1, 101, 1, 799.99, '2023-03-01', 'Delivered'),
(202, 2, 102, 2, 1199.98, '2023-03-02', 'Shipped'),
(203, 3, 103, 1, 399.99, '2023-03-03', 'Pending'),
(204, 4, 104, 3, 299.97, '2023-03-04', 'Delivered'),
(205, 5, 105, 2, 399.98, '2023-03-05', 'Cancelled'),
(206, 6, 106, 1, 49.99, '2023-03-06', 'Delivered'),
(207, 7, 107, 4, 119.96, '2023-03-07', 'Shipped');


-- UPDATE Examples  -- 

--  1: Update order status -- 
UPDATE Orders
SET status = 'Delivered'
WHERE order_id = 202;

-- 2: Update total amount for a specific customer -- 
UPDATE Orders
SET total_amount = 899.99
WHERE customer_id = 103;

-- 3: Update multiple columns at once -- 
UPDATE Orders
SET status = 'Cancelled', total_amount = 0
WHERE order_id = 205;

--  4: Update based on date range
UPDATE Orders
SET status = 'Pending'
WHERE order_date BETWEEN '2023-03-01' AND '2023-03-05';

--  5: Update quantity for a specific product in an order -- 
UPDATE Orders
SET quantity = 5
WHERE order_id = 207 AND product_id = 107;

--  6: Update status for multiple orders of a customer  -- 
UPDATE Orders
SET status = 'Returned'
WHERE customer_id = 2;

-- 7: Increase total amount by 10% for all shipped orders
UPDATE Orders
SET total_amount = total_amount * 1.10
WHERE status = 'Shipped';

--  8: Set status to 'Cancelled' for orders older than a certain date

UPDATE Orders
SET status = 'Cancelled'
WHERE order_date < '2023-03-04';





-- 1:Delete one specific order by order_id -- 
DELETE FROM Orders
WHERE order_id = 205;


-- 2;Delete all orders with status 'Cancelled'-- 
DELETE FROM Orders
WHERE status = 'Cancelled';


-- 3:Delete orders older than a specific date -- 
DELETE FROM Orders
WHERE order_date < '2023-03-04';

-- 4:Delete all orders for a specific customer -- 
DELETE FROM Orders
WHERE customer_id = 7;

-- 5: Delete orders with low total amount -- 
DELETE FROM Orders
WHERE total_amount < 100;

--  6: Delete multiple orders using IN condition -- 
DELETE FROM Orders
WHERE order_id IN (201, 203, 207);

-- 8: Delete orders with a combination of conditions -- 
DELETE FROM Orders
WHERE status = 'Pending' AND quantity > 1;



