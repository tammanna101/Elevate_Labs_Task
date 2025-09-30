         -- Scalar Subquery (Customers Table)
-- (A subquery that returns a single value)
--  Example: Find customers who live in the same city as Ravi.
SELECT CustomerName, City
FROM Customers
WHERE City = (SELECT City FROM Customers WHERE CustomerName = 'Ravi');

 -- Find the city with the maximum CustomerID
SELECT City
FROM Customers
WHERE CustomerID = (SELECT MAX(CustomerID) FROM Customers);

--   Find the name of the first customer inserted (lowest ID)
SELECT CustomerName
FROM Customers
WHERE CustomerID = (SELECT MIN(CustomerID) FROM Customers);

        --   Correlated Subquery
   -- (A subquery that refers to a column in the outer query)
--   Find customers whose CustomerID is the minimum for their city.
SELECT CustomerName, City
FROM Customers c1
WHERE CustomerID = (
    SELECT MIN(CustomerID) 
    FROM Customers c2 
    WHERE c1.City = c2.City
);

--  Find customers who have the same city as at least one other customer
SELECT CustomerName, City
FROM Customers c1
WHERE EXISTS (
   SELECT 1 
   FROM Customers c2
   WHERE c1.City = c2.City 
   AND c1.CustomerID <> c2.CustomerID
);

--  Find customers whose ID is greater than the average ID of their city
SELECT CustomerName, City, CustomerID
FROM Customers c1
WHERE CustomerID > (
   SELECT AVG(CustomerID)
   FROM Customers c2
   WHERE c1.City = c2.City
);

      --  Subquery with IN  
-- 1) Get customers who are from Pune or Delhi (using subquery).
SELECT CustomerName, City
FROM Customers
WHERE City IN (SELECT City FROM Customers WHERE City IN ('Pune', 'Delhi'));

--  Get customers who live in the same cities as customers with ID ≤ 2
SELECT CustomerName, City
FROM Customers
WHERE City IN (
   SELECT City FROM Customers WHERE CustomerID <= 2
);

--  Get customers from cities where 'Anita' or 'Sita' live
SELECT CustomerName, City
FROM Customers
WHERE City IN (
   SELECT City FROM Customers WHERE CustomerName IN ('Anita', 'Sita')
);

      --  Subquery with EXISTS
--  Example: Check if there are customers in Mumbai, then return all customers.
SELECT CustomerName, City
FROM Customers c
WHERE EXISTS (SELECT 1 FROM Customers WHERE City = 'Mumbai');

--  Return all customers if at least one customer lives in Pune
SELECT *
FROM Customers c
WHERE EXISTS (SELECT 1 FROM Customers WHERE City = 'Pune');

--  Find customers who live in cities that have more than 1 customer
SELECT CustomerName, City
FROM Customers c1
WHERE EXISTS (
   SELECT 1 
   FROM Customers c2
   WHERE c1.City = c2.City 
   GROUP BY City
   HAVING COUNT(*) > 1
);

  --     Subquery with =
-- Find the customer who lives in Delhi.
SELECT CustomerName, City
FROM Customers
WHERE City = (SELECT City FROM Customers WHERE CustomerName = 'Sita');

-- Find the city where customer 'Kiran' lives
SELECT City
FROM Customers
WHERE City = (SELECT City FROM Customers WHERE CustomerName = 'Kiran');

--  Find customers who live in the same city as the customer with ID = 4
SELECT CustomerName, City
FROM Customers
WHERE City = (SELECT City FROM Customers WHERE CustomerID = 4);






-- Scalar Subquery (Orders Table)
-- Find customers whose order amount is greater than the average order amount.
SELECT CustomerID, OrderID, Amount
FROM Orders
WHERE Amount > (SELECT AVG(Amount) FROM Orders);

-- 2. Correlated Subquery (subquery depends on outer query)
--  Find each order that is greater than the average order amount of the same customer.
SELECT o.OrderID, o.CustomerID, o.Amount
FROM Orders o
WHERE o.Amount > (
    SELECT AVG(o2.Amount)
    FROM Orders o2
    WHERE o2.CustomerID = o.CustomerID
);

               --  Subquery with IN    
 -- Get customers who placed orders worth more than 1000.
SELECT CustomerName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE Amount > 1000
);

             --   Subquery with EXISTS
--  Find customers who have placed at least one order.
SELECT CustomerName
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);

                -- Subquery with =
-- Find the customer who placed the highest order.
SELECT CustomerName
FROM Customers
WHERE CustomerID = (
    SELECT CustomerID
    FROM Orders
    WHERE Amount = (SELECT MAX(Amount) FROM Orders)
);


      -- Subquery with NOT IN
-- Find customers who have not placed any orders.
SELECT CustomerName
FROM Customers
WHERE CustomerID NOT IN (
    SELECT CustomerID FROM Orders
);
      --  Subquery with ANY
-- Find orders where the amount is greater than any order placed by customer 1.
SELECT OrderID, Amount
FROM Orders
WHERE Amount > ANY (
    SELECT Amount
    FROM Orders
    WHERE CustomerID = 1
);

         --  Subquery with ALL
--  Find orders where the amount is greater than all orders placed by customer 2.
SELECT OrderID, Amount
FROM Orders
WHERE Amount > ALL (
    SELECT Amount
    FROM Orders
    WHERE CustomerID = 2
);

      --   Subquery in SELECT (scalar per row)
-- Show each order along with the average order amount of all customers.
SELECT OrderID, Amount,
       (SELECT AVG(Amount) FROM Orders) AS AvgOrderAmount
FROM Orders;

         --  Correlated subquery in SELECT
-- Show each order along with the average order amount of that customer.
SELECT o.OrderID, o.Amount,
       (SELECT AVG(o2.Amount)
        FROM Orders o2
        WHERE o2.CustomerID = o.CustomerID) AS CustomerAvg
FROM Orders o;


            -- - Subquery with HAVING
--  Find customers whose total order amount is greater than the average order amount of all customers.
SELECT CustomerID, SUM(Amount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
HAVING SUM(Amount) > (
    SELECT AVG(Amount) FROM Orders
);

   --  Nested Subquery
-- Find the second highest order amount.
SELECT MAX(Amount) AS SecondHighest
FROM Orders
WHERE Amount < (SELECT MAX(Amount) FROM Orders);
