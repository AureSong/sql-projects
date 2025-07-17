USE BookLearning;

SELECT
    column_name,
    CASE
    	WHEN condition1 THEN rusult1
    	WHEN condition2 THEN rusult2
    	ELSE rusult_default
    END AS alias_name
FROM table_name;
    
SELECT
    order_num,
    quantity,
    CASE 
    	WHEN quantity >= 100 THEN '大额订单'
    	WHEN quantity >= 50 THEN '中额订单'
    	ELSE '小额订单'
    END AS order_level
FROM OrderItems;
    
SELECT
    c.cust_id, 
    c.cust_name,
    SUM(oi.item_price * oi.quantity) AS total_ordered,
    CASE
    	WHEN SUM(oi.item_price * oi.quantity) >= 1000 THEN '大客户'
    	WHEN SUM(oi.item_price * oi.quantity) >= 500 THEN '普通客户'
    	ELSE '低消费客户'
    END AS customer_type
FROM Customers c
JOIN Orders o ON c.cust_id = o.cust_id
JOIN OrderItems oi ON o.order_num = oi.order_num
GROUP BY c.cust_id, c.cust_name;
    



















