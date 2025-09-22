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

show tables;
drop table review;


