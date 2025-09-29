
-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);
-- Insert Sample Data
-- Customers
INSERT INTO Customers VALUES
(1, 'Ravi', 'Bangalore'),
(2, 'Anita', 'Pune'),
(3, 'Kiran', 'Mumbai'),
(4, 'Sita', 'Delhi');

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Orders
INSERT INTO Orders VALUES
(101, '2025-09-01', 1, 500.00),
(102, '2025-09-05', 2, 1500.00),
(103, '2025-09-07', 1, 700.00),
(104, '2025-09-10', 3, 1200.00);

-- JOIN Examples
-- 1)🔹 INNER JOIN (common records only)
SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- 2)🔹 LEFT JOIN (all customers, even without orders)
SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- 3)🔹 RIGHT JOIN (all orders,even if customer missing)
SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- 4)🔹 FULL OUTER JOIN (all customers + all orders)
SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
FULL JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- 5) Customers without Orders (LEFT JOIN + WHERE NULL)
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;

--  6)2. Orders without Matching Customers (RIGHT JOIN + WHERE NULL)
SELECT Orders.OrderID, Orders.Amount, Customers.CustomerName
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.CustomerID IS NULL;

-- 7) Count Orders per Customer (INNER JOIN + GROUP BY)
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName;

-- 8) Customers with Order Amounts (INNER JOIN + SUM)
SELECT Customers.CustomerName, SUM(Orders.Amount) AS TotalAmount
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName;

-- 9) FULL JOIN with Condition (All Customers + All Orders)
SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
FULL  JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;

-- 10) SELF JOIN Example (Customers in Same City)
SELECT C1.CustomerName AS Customer1, C2.CustomerName AS Customer2, C1.City
FROM Customers C1
INNER JOIN Customers C2
ON C1.City = C2.City AND C1.CustomerID <> C2.CustomerID;

