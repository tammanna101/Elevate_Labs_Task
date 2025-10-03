-- Stored Procedure Example(Customers Table)
We will create a procedure that accepts a city name and returns customers from that city. 
If no records are found, it will display a message.
--1). Procedure to fetch customers by city
DELIMITER //
CREATE PROCEDURE GetCustomersByCity(IN input_city VARCHAR(50))
BEGIN
    DECLARE count_customers INT;

    -- Count how many customers are in that city
    SELECT COUNT(*) INTO count_customers
    FROM Customers
    WHERE City = input_city;

    -- Conditional logic
    IF count_customers > 0 THEN
        SELECT * 
        FROM Customers
        WHERE City = input_city;
    ELSE
        SELECT CONCAT('No customers found in ', input_city) AS Message;
    END IF;
END //
DELIMITER ;

-- Call Procedure
CALL GetCustomersByCity('Pune');
CALL GetCustomersByCity('Chennai');


-- 2). Insert Customer with Conditional Check
This procedure inserts a new customer only if the CustomerID doesn’t already exist.

DELIMITER //
CREATE PROCEDURE AddCustomer(
    IN cust_id INT,
    IN cust_name VARCHAR(50),
    IN cust_city VARCHAR(50)
)
BEGIN
    DECLARE cnt INT;

    -- Check if customer already exists
    SELECT COUNT(*) INTO cnt 
    FROM Customers 
    WHERE CustomerID = cust_id;

    IF cnt = 0 THEN
        INSERT INTO Customers VALUES (cust_id, cust_name, cust_city);
        SELECT 'Customer Added Successfully' AS Message;
    ELSE
        SELECT 'CustomerID Already Exists!' AS Message;
    END IF;
END //
DELIMITER ;

-- Call Procedure
CALL AddCustomer(5, 'John', 'Hyderabad');
CALL AddCustomer(1, 'Ravi', 'Bangalore'); -- Duplicate ID

-- 3). Update Customer City with Check
This procedure updates the city of a customer. If not found, show a message.
DELIMITER //
CREATE PROCEDURE UpdateCustomerCity(
    IN cust_id INT,
    IN new_city VARCHAR(50)
)
BEGIN
    DECLARE cnt INT;

    SELECT COUNT(*) INTO cnt FROM Customers WHERE CustomerID = cust_id;

    IF cnt > 0 THEN
        UPDATE Customers
        SET City = new_city
        WHERE CustomerID = cust_id;
        SELECT 'City Updated Successfully' AS Message;
    ELSE
        SELECT 'Customer Not Found!' AS Message;
    END IF;
END //
DELIMITER ;

-- Call Procedure
CALL UpdateCustomerCity(3, 'Chennai');
CALL UpdateCustomerCity(10, 'Delhi'); -- Not Found


-- 4). Delete Customer by ID with Confirmation
DELIMITER //
CREATE PROCEDURE DeleteCustomer(IN cust_id INT)
BEGIN
    DECLARE cnt INT;

    SELECT COUNT(*) INTO cnt FROM Customers WHERE CustomerID = cust_id;

    IF cnt > 0 THEN
        DELETE FROM Customers WHERE CustomerID = cust_id;
        SELECT 'Customer Deleted Successfully' AS Message;
    ELSE
        SELECT 'Customer Not Found!' AS Message;
    END IF;
END //
DELIMITER ;

-- Call Procedure
CALL DeleteCustomer(4);
CALL DeleteCustomer(100);

            -- Function Example(Customers Table)
We will create a function that returns the city name of a customer based on CustomerID.
If the customer does not exist, it will return 'Not Found'.
DELIMITER //
CREATE FUNCTION GetCustomerCity(cust_id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE city_name VARCHAR(50);

    -- Get city of customer
    SELECT City INTO city_name
    FROM Customers
    WHERE CustomerID = cust_id;

    -- Conditional check
    IF city_name IS NULL THEN
        SET city_name = 'Not Found';
    END IF;

    RETURN city_name;
END //
DELIMITER ;

-- Call Function
SELECT GetCustomerCity(2);   -- Output: Pune
SELECT GetCustomerCity(10);  -- Output: Not Found







          --  STORED PROCEDURE EXAMPLES ( Orders Table)
-- 1. Get Total Amount by Customer
DELIMITER //
CREATE PROCEDURE GetTotalAmountByCustomer (CustID INT)
BEGIN
    DECLARE Total DECIMAL(10,2);

    SELECT SUM(Amount) INTO Total
    FROM Orders
    WHERE CustomerID = CustID;

    IF Total IS NULL THEN
        SELECT 'No orders found for this customer' AS Message;
    ELSE
        SELECT Total AS TotalAmount;
    END IF;
END //
DELIMITER ;


-- 2. Insert Order with Validation

DELIMITER //
CREATE PROCEDURE InsertOrder (OrderID INT, OrderDate DATE, CustomerID INT, Amount DECIMAL(10,2))
BEGIN
    IF Amount <= 0 THEN
        SELECT 'Amount must be greater than 0' AS Message;
    ELSE
        INSERT INTO Orders (OrderID, OrderDate, CustomerID, Amount)
        VALUES (OrderID, OrderDate, CustomerID, Amount);
        SELECT 'Order inserted successfully' AS Message;
    END IF;
END //
DELIMITER ;


-- 3. Update Order Amount
DELIMITER //
CREATE PROCEDURE UpdateOrder (OrderID INT, NewAmount DECIMAL(10,2))
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = OrderID) THEN
        SELECT 'Order does not exist' AS Message;
    ELSE
        UPDATE Orders
        SET Amount = NewAmount
        WHERE OrderID = OrderID;
        SELECT 'Order updated successfully' AS Message;
    END IF;
END //
DELIMITER ;


-- 4. Get Orders Above Certain Amount
DELIMITER //
CREATE PROCEDURE GetOrdersAbove (MinAmount DECIMAL(10,2))
BEGIN
    SELECT OrderID, CustomerID, Amount
    FROM Orders
    WHERE Amount > MinAmount;
END //
DELIMITER ;


-- 5. Delete Order
DELIMITER //
CREATE PROCEDURE DeleteOrder (OrderID INT)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = OrderID) THEN
        SELECT 'Order not found' AS Message;
    ELSE
        DELETE FROM Orders WHERE OrderID = OrderID;
        SELECT 'Order deleted successfully' AS Message;
    END IF;
END //
DELIMITER ;


🔹 FUNCTION EXAMPLES  (Orders Table)
-- 1. Get Order Status
DELIMITER //
CREATE FUNCTION GetOrderStatus (OrderID INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE Amt DECIMAL(10,2);
    DECLARE Result VARCHAR(50);

    SELECT Amount INTO Amt FROM Orders WHERE OrderID = OrderID;

    IF Amt IS NULL THEN
        SET Result = 'Order not found';
    ELSEIF Amt > 1000 THEN
        SET Result = 'High Value Order';
    ELSE
        SET Result = 'Regular Order';
    END IF;

    RETURN Result;
END //
DELIMITER ;


-- 2. Get Total Orders by Customer
DELIMITER //
CREATE FUNCTION GetTotalOrders (CustID INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE Total INT;

    SELECT COUNT(*) INTO Total FROM Orders WHERE CustomerID = CustID;

    RETURN IFNULL(Total, 0);
END //
DELIMITER ;


-- 3. Get Discounted Amount
DELIMITER //
CREATE FUNCTION GetDiscountedAmount (OrderID INT, DiscountRate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE Amt DECIMAL(10,2);

    SELECT Amount INTO Amt FROM Orders WHERE OrderID = OrderID;

    IF Amt IS NULL THEN
        RETURN 0;
    END IF;

    RETURN Amt - (Amt * DiscountRate / 100);
END //
DELIMITER ;


-- 4. Check If Order is Recent
DELIMITER //
CREATE FUNCTION IsRecentOrder (OrderID INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE ODate DATE;
    DECLARE Result VARCHAR(20);

    SELECT OrderDate INTO ODate FROM Orders WHERE OrderID = OrderID;

    IF ODate IS NULL THEN
        SET Result = 'Not Found';
    ELSEIF ODate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) THEN
        SET Result = 'Recent';
    ELSE
        SET Result = 'Old';
    END IF;

    RETURN Result;
END //
DELIMITER ;


-- 5. Get Customer Category
DELIMITER //
CREATE FUNCTION GetCustomerCategory (CustID INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE Total INT;
    DECLARE Result VARCHAR(20);

    SELECT COUNT(*) INTO Total FROM Orders WHERE CustomerID = CustID;

    IF Total = 0 THEN
        SET Result = 'No Orders';
    ELSEIF Total >= 5 THEN
        SET Result = 'Premium';
    ELSE
        SET Result = 'Regular';
    END IF;

    RETURN Result;
END //
DELIMITER ;

