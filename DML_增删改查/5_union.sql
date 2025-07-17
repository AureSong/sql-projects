USE BookLearning;

SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL', 'IN', 'MI')
UNION 
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4AIl';

SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL', 'IN', 'MI')
UNION ALL
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4AIl'
ORDER BY cust_name, cust_contact;

SELECT prod_id, quantity
FROM OrderItems
WHERE quantity = 100
UNION
SELECT prod_id, quantity
FROM OrderItems
WHERE prod_id LIKE 'BNBG%'
ORDER BY prod_id;

SELECT prod_id, quantity
FROM OrderItems
WHERE quantity = 100
    OR prod_id LIKE 'BNBG%'
ORDER BY prod_id;







