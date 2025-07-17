USE BookLearning;

SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01';

SELECT cust_id
FROM Orders
WHERE order_num IN (20007, 20008);

SELECT cust_id
FROM Orders
WHERE order_num IN(
    SELECT order_num 
    FROM OrderItems
    WHERE prod_id = 'RGAN01'
);

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id iN(
    SELECT cust_id
    FROM Orders
    WHERE order_num IN(
        SELECT order_num 
        FROM OrderItems
        WHERE prod_id = 'RGAN01'
    )
);

SELECT COUNT(*) AS orders
FROM Orders
WHERE cust_id = 1000000001;

SELECT cust_name, 
    cust_state,
    (SELECT COUNT(*)
    FROM Orders
    WHERE Orders.cust_id = Customers.cust_id) AS orders
FROM Customers
ORDER BY cust_name;

SELECT cust_id
FROM Orders
WHERE order_num IN (
    SELECT order_num 
    FROM OrderItems
    WHERE item_price >= 10
);

SELECT cust_id, order_date
FROM Orders
WHERE order_num IN (
    SELECT order_num
    FROM OrderItems
    WHERE prod_id = 'BR01'
)
ORDER BY order_date;

SELECT cust_email
FROM Customers
WHERE cust_id IN (
    SELECT cust_id 
    FROM Orders
    WHERE order_num IN(
        SELECT order_num
        FROM OrderItems
        WHERE prod_id = 'BR01'
    )
);





SELECT cust_id,
    (SELECT SUM(quantity * item_price) 
    FROM OrderItems
    WHERE Orders.order_num = OrderItems.order_num
    ) AS total_ordered
FROM Orders
ORDER BY total_ordered DESC;


USE BookLearning;

SELECT cust_id,
    (SELECT SUM(quantity * item_price)
    FROM OrderItems
    WHERE order_num IN (
        SELECT order_num
        FROM Orders 
        WHERE Orders.cust_id = Customers.cust_id)
    ) AS total_ordered
FROM Customers
ORDER BY total_ordered DESC;

SELECT prod_name, 
    (SELECT SUM(quantity)
    FROM OrderItems
    WHERE OrderItems.prod_id = Products.prod_id) AS quant_sold
FROM Products;













