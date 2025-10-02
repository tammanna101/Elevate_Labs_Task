             -- Customers Table
-- 1.Use CREATE VIEW with complex SELECT
-- 2.Use views for abstraction and security

-- Exaples
-- 1) Create a view that shows customer name, city,
-- and also adds a derived column showing city length
CREATE VIEW CustomerDetails AS
SELECT 
    CustomerID,
    CustomerName,
    City,
    LEN(City) AS CityNameLength
FROM Customers
WHERE City IN ('Bangalore', 'Mumbai');  -- filtering condition

                -- Using Views for Abstraction
-- 2) Suppose we want to hide the CustomerID from normal users and just show names and cities:
CREATE VIEW CustomerPublic AS
SELECT 
    CustomerName,
    City
FROM Customers;
-- ➡️ Now, a user can query:
SELECT * FROM CustomerPublic;
-- They don’t see sensitive data like CustomerID.

             --  Using Views for Security
-- 3) Imagine some users should only see customers from Pune.
CREATE VIEW PuneCustomers AS
SELECT 
    CustomerName,
    City
FROM Customers
WHERE City = 'Pune';

-- 4) View with Aggregation (COUNT per City)
CREATE VIEW CustomerCityCount AS
SELECT 
    City,
    COUNT(CustomerID) AS TotalCustomers
FROM Customers
GROUP BY City;
-- ✅ This shows how many customers are in each city.
-- Query:
-- SELECT * FROM CustomerCityCount;

-- 5) View with String Functions (Uppercase names)
CREATE VIEW CustomerFormatted AS
SELECT 
    CustomerID,
    UPPER(CustomerName) AS NameInCaps,
    LOWER(City) AS CityInSmall
FROM Customers;
--  Useful for data formatting/standardization.

-- 6) View with Filtering and Ordering
CREATE VIEW MetroCustomers AS
SELECT 
    CustomerID,
    CustomerName,
    City
FROM Customers
WHERE City IN ('Mumbai', 'Delhi')
ORDER BY CustomerName;
--  Only shows customers from Mumbai & Delhi.


-- Join-based View (Customers + Orders)
 -- 7) Let’s assume you also have an Orders table:
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderAmount DECIMAL(10,2),
    OrderDate DATE
);
-- Now, create a join view:
CREATE VIEW CustomerOrders AS
SELECT 
    c.CustomerName,
    c.City,
    o.OrderID,
    o.OrderAmount,
    o.OrderDate
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID;
--  Combines customer and order details.

--  8)View with Derived Column (Category based on City)
CREATE VIEW CustomerCategory AS
SELECT 
    CustomerID,
    CustomerName,
    City,
    CASE 
        WHEN City = 'Delhi' THEN 'North'
        WHEN City = 'Mumbai' THEN 'West'
        WHEN City = 'Bangalore' THEN 'South'
        ELSE 'Other'
    END AS Region
FROM Customers;
--  Adds a Region column automatically.

-- 9) Security-focused View (Masking IDs)
CREATE VIEW PublicCustomers AS
SELECT 
    LEFT(CustomerName, 1) + '***' AS MaskedName,
    City
FROM Customers;



               -- Orders Table
-- 1.Use CREATE VIEW with complex SELECT
-- 2.Use views for abstraction and security

--  View: Orders Above 1000 (High Value Orders)
CREATE VIEW HighValueOrders AS
SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    Amount
FROM Orders
WHERE Amount > 1000;


--  View  1): Orders with Derived Column (Tax Calculation)
CREATE VIEW OrdersWithTax AS
SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    Amount,
    Amount * 0.18 AS GST_18_Percent
FROM Orders;

--  View   2): Customers with City Length
CREATE VIEW CustomerCityLength AS
SELECT 
    CustomerID,
    CustomerName,
    City,
    LEN(City) AS CityNameLength
FROM Customers;

--  View  3): Monthly Orders Count
CREATE VIEW OrdersPerMonth AS
SELECT 
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate);

-- View   4): Recent Orders (Last 30 Days)
CREATE VIEW RecentOrders AS
SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    Amount
FROM Orders
WHERE OrderDate >= DATEADD(DAY, -30, GETDATE());

-- Example: Show Customer details with their total spending
CREATE VIEW CustomerSpending AS
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.Amount) AS TotalAmount,
    AVG(o.Amount) AS AvgOrderAmount,
    MAX(o.Amount) AS HighestOrder,
    MIN(o.Amount) AS LowestOrder
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.City;

              -- Views for Abstraction
-- Suppose you want to simplify queries for users.
-- Instead of writing long joins every time, you create a simple view:
CREATE VIEW CustomerOrderDetails AS
SELECT 
    c.CustomerName,
    c.City,
    o.OrderID,
    o.OrderDate,
    o.Amount
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID;
-- Now users can just do:
SELECT * FROM CustomerOrderDetails WHERE City = 'Mumbai';
-- ➡️ Abstraction: Users don’t need to know table joins, only query the view.


         -- Views for Security     
-- Imagine we don’t want normal users to see Order Amount (sensitive data).
-- We create a restricted view:
CREATE VIEW PublicCustomerOrders AS
SELECT 
    c.CustomerName,
    c.City,
    o.OrderDate
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID;
-- This hides Order Amount from users.
-- You can GRANT SELECT permission on this view, not on base tables.
