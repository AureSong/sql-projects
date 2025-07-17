USE BookLearning;

SELECT vend_name, prod_name, prod_price
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id;

SELECT vend_name, prod_name, prod_price
FROM Vendors, Products;

SELECT vend_name, prod_name, prod_price
FROM Vendors
INNER JOIN Products 
ON Vendors.vend_id = Products.vend_id;

SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems, Products, Vendors
WHERE Products.vend_id = Vendors.vend_id
    AND OrderItems.prod_id = Products.prod_id
    AND order_num = 20007;

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (
    SELECT cust_id 
    FROM Orders
    WHERE order_num IN(
        SELECT order_num
        FROM OrderItems
        WHERE prod_id = 'RGAN01'
    )
);

SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
    AND Orders.order_num = OrderItems.order_num
    AND prod_id = 'RGAN01';

SELECT cust_name, order_num
FROM Customers, Orders
WHERE Customers.cust_id = Orders.cust_id
ORDER BY cust_name, order_num;

SELECT cust_name, order_num
FROM Customers
INNER JOIN Orders
ON Customers.cust_id = Orders.cust_id
ORDER BY cust_name, order_num;

SELECT c.cust_name, 
    o.order_num,
    SUM(oi.quantity * oi.item_price) AS OrderTotal
FROM Customers AS c
INNER JOIN Orders AS o ON c.cust_id = o.cust_id
INNER JOIN OrderItems AS oi ON o.order_num = oi.order_num
GROUP BY c.cust_name, o.order_num
ORDER BY c.cust_name, o.order_num;

SELECT o.cust_id, o.order_date
FROM Orders AS o
JOIN OrderItems AS oi ON o.order_num = oi.order_num
WHERE prod_id = 'BR01'
ORDER BY o.order_date;

SELECT c.cust_email
FROM Customers AS c
INNER JOIN Orders AS o ON o.cust_id = c.cust_id
INNER JOIN OrderItems AS oi ON oi.order_num = o.order_num
WHERE prod_id = 'BR01';

SELECT c.cust_name,
    SUM(oi.quantity * oi.item_price) AS total_ordered
FROM Customers AS c
INNER JOIN Orders AS o ON o.cust_id = c.cust_id
INNER JOIN OrderItems AS oi ON oi.order_num = o.order_num
GROUP BY cust_name
HAVING total_ordered >= 1000
ORDER BY c.cust_name;

SELECT cust_id, cust_name, cust_contact
FROM Customers
WHERE cust_name = (
    SELECT cust_name
    FROM Customers
    WHERE cust_contact = 'Jim Jones'
);

SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c1.cust_name = c2.cust_name
    AND c2.cust_contact = 'Jim Jones';



SELECT C.*, O.order_num, O.order_date, OI.prod_id, OI.quantity, OI.item_price
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
    AND OI.order_num = O.order_num
    AND prod_id = 'RGAN01';

SELECT Customers.cust_id, Orders.order_num
FROM Customers
INNER JOIN Orders ON Customers.cust_id = Orders.cust_id;

SELECT Customers.cust_id, Orders.order_num
FROM Customers
LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;

SELECT Customers.cust_id, Orders.order_num
FROM Customers
RIGHT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;

SELECT Customers.cust_id,
    COUNT(Orders.order_num) AS num_ord
FROM Customers
INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

SELECT Customers.cust_id,
    COUNT(Orders.order_num) AS num_ord
FROM Customers
LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

SELECT Customers.cust_name, Orders.order_num
FROM Customers
INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
ORDER BY Customers.cust_name;

SELECT Customers.cust_name, Orders.order_num
FROM Customers
LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id
ORDER BY Customers.cust_name;

SELECT Products.prod_name, OrderItems.order_num
FROM Products
LEFT OUTER JOIN OrderItems ON Products.prod_id = OrderItems.prod_id
ORDER BY Products.prod_name;

SELECT Products.prod_name, COUNT(OrderItems.order_num)
FROM Products
LEFT OUTER JOIN OrderItems ON Products.prod_id = OrderItems.prod_id
GROUP BY Products.prod_name
ORDER BY Products.prod_name;

SELECT Vendors.vend_id, COUNT(Products.prod_id)
FROM Vendors LEFT OUTER JOIN Products
    ON Vendors.vend_id = Products.vend_id
GROUP BY Vendors.vend_id;
