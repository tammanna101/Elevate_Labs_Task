create database Task;
use Task;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    registered_date DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT,
    brand VARCHAR(50),
    added_date DATE
);


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


    
     --  Entities (Tables)    -- 
-- Customer → Stores customer details (customer_id, cust_name,email,etc .)
-- Product → Stores product details ( product_id , product_name, price, stock, etc.)
-- Order → Stores order details ( order_id,customer_id,product_id,total amount, etc.)
-- Order_Item (or Order_Details) → Resolves the many-to-many relationship between Order and Product

--     Relationships
--  1)Customer ↔ Order →
--      .One customer can place many orders (1-to-Many).
-- 	 .Each order belongs to exactly one customer.

-- Relationships
-- 2)Order ↔ Product →
-- 	 .One order can contain multiple products.
-- 	 .One product can be in multiple orders.
-- 	 .This is a Many-to-Many relationship, resolved using Order_Item.


select *
from customers;
select *
from orders;
select *
from products;
select *
