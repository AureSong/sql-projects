USE BookLearning;

SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
    AND OrderItems.order_num = Orders.order_num
    AND prod_id = 'RGAN01';

CREATE VIEW ProductCustomers AS
SELECT cust_name, cust_contact, prod_id
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
    AND OrderItems.order_num = Orders.order_num;

SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01';

CREATE VIEW VendorLocations AS
SELECT CONCAT(RTRIM(vend_name), '(', RTRIM(vend_country), ')') AS vend_title
FROM Vendors;

SELECT * 
FROM VendorLocations;

CREATE VIEW CustomerEmailList AS 
SELECT cust_id, cust_name, cust_email
FROM Customers
WHERE cust_email IS NOT NULL;

SELECT *
FROM CustomerEmailList;

CREATE VIEW OrderItemsExpanded AS
SELECT order_num,
    prod_id,
    quantity,
    item_price,
    quantity * item_price AS expanded_price
FROM OrderItems;
    
SELECT *
FROM OrderItemsExpanded
WHERE order_num = 20008;

CREATE VIEW CustomerWithOrders AS
SELECT Customers.cust_id,
    Customers.cust_name,
    Customers.cust_address,
    Customers.cust_city,
    Customers.cust_state,
    Customers.cust_zip,
    Customers.cust_country,
    Customers.cust_contact,
    Customers.cust_email
FROM Customers
INNER JOIN Orders
ON Customers.cust_id = Orders.cust_id;

SELECT * FROM Customers;

SELECT *
FROM CustomerWithOrders;









