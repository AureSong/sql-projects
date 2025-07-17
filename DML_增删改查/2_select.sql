USE BookLearning;

SELECT prod_name
FROM Products;

SELECT prod_id, prod_name, prod_price
FROM Products;

SELECT *
FROM Products;

SELECT vend_id
FROM Products;

SELECT DISTINCT vend_id
FROM Products;

SELECT vend_id, prod_price FROM Products;

SELECT DISTINCT vend_id, prod_price FROM Products;

SELECT prod_name
FROM Products
LIMIT 5;

SELECT prod_name
FROM Products
LIMIT 5 OFFSET 5;

SELECT prod_name
FROM Products
LIMIT 4 OFFSET 3;

SELECT prod_name
FROM Products
LIMIT 3,4;

/* SELECT prod_name, vend_id
FROM Products;*/
SELECT prod_name
FROM Products;

SELECT cust_id 
FROM Customers;

SELECT DISTINCT prod_id
FROM OrderItems;

SELECT *
FROM Customers;

/* SELECT cust_id
FROM Customers; */

SELECT prod_name
FROM Products
ORDER BY prod_name;

USE BookLearning;

SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price, prod_name;

SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC;

SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC, prod_name;

SELECT cust_name
FROM Customers
ORDER BY cust_name DESC;

SELECT cust_id, order_num 
FROM Orders
ORDER BY cust_id, order_date DESC;

SELECT quantity, item_price
FROM OrderItems
ORDER BY quantity DESC, item_price DESC;

SELECT prod_name, prod_price
FROM Products
WHERE prod_price = 3.49;

SELECT prod_name, prod_price
FROM Products
WHERE prod_price < 10;

SELECT prod_name, prod_price
FROM Products
WHERE prod_price <= 10;

SELECT vend_id, prod_name
FROM Products
WHERE vend_id <> 'DLL01';

SELECT vend_id, prod_name
FROM Products
WHERE vend_id != 'DLL01';

SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 5 AND 10;

SELECT prod_name
FROM Products
WHERE prod_price IS NULL;

SELECT cust_name
FROM Customers
WHERE cust_email IS NULL;

SELECT prod_id, prod_name
FROM Products
WHERE prod_price = 9.49;

SELECT prod_id, prod_name
FROM Products
WHERE prod_price >= 9;

SELECT DISTINCT order_num
FROM OrderItems
WHERE quantity >= 100;

SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 3 AND 6
ORDER BY prod_price;

SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01' AND prod_price <= 4;

SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01';

SELECT prod_name, prod_price
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01')
    AND prod_price >= 10;

SELECT prod_name, prod_price
FROM Products
WHERE vend_id IN('DLL01', 'BRS01')
    ORDER BY prod_name;

SELECT prod_name
FROM Products
WHERE NOT vend_id = 'DLL01'
ORDER BY prod_name;

SELECT vend_name
FROM Vendors
WHERE vend_country = 'USA' 
    AND vend_state = 'CA';

SELECT order_num, prod_id, quantity
FROM OrderItems
WHERE prod_id IN ('BR01', 'BR02', 'BR03')
    AND quantity >= 100

USE BookLearning;  
    
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE 'Fish%';

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%';

SELECT prod_name
FROM Products
WHERE prod_name LIKE 'F%y';

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '__ inch teddy bear';

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%inch teddy bear';

SELECT prod_name, prod_desc
FROM Products
WHERE prod_desc LIKE '%toy%';

SELECT prod_name, prod_desc
FROM Products
WHERE NOT prod_desc LIKE '%toy%'
ORDER BY prod_name;

SELECT prod_name, prod_desc
FROM Products
WHERE prod_desc LIKE "%toy%"
    AND prod_desc LIKE '%carrots%';

SELECT prod_name, prod_desc 
FROM Products
WHERE prod_desc LIKE '%toy%carrots%';

SELECT CONCAT(vend_name, '(', vend_country, ')')
FROM Vendors
ORDER BY vend_name;

SELECT CONCAT(RTRIM(vend_name), '(', RTRIM(vend_country),')') AS vend_title
FROM Vendors
ORDER BY vend_name;

SELECT prod_id, quantity, item_price
FROM OrderItems
WHERE order_num = 20008;

USE BookLearning;

SELECT prod_id,
    quantity,
    item_price,
    quantity * item_price AS expanded_price
FROM OrderItems
WHERE order_num = 20008;

SELECT vend_id,
    vend_name AS vname,
    vend_address AS vaddress,
    vend_city AS vcity
FROM Vendors
ORDER BY vname ;

SELECT prod_id, prod_price, prod_price * 0.9 AS sale_price
FROM Products;

SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
FROM Vendors
ORDER BY vend_name;

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_contact = 'Michael Green';

SELECT cust_name, cust_contact
FROM Customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

SELECT order_num
FROM Orders
WHERE YEAR(order_date) = 2020;

SELECT cust_id, cust_name, 
    UPPER(CONCAT(LEFT(cust_contact, 2), LEFT(cust_city, 3))) AS user_login
FROM Customers;

SELECT order_num, order_date
FROM Orders
WHERE YEAR(order_date) = 2020
    AND MONTH(order_date) = 1
ORDER BY order_date;

SELECT AVG(prod_price) AS avg_price
FROM Products;

SELECT AVG(prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

SELECT COUNT(*) AS num_cust
FROM Customers;

SELECT COUNT(cust_email) AS num_cost
FROM Customers;

SELECT MAX(prod_price) AS max_price
FROM Products;

SELECT MIN(prod_price) AS min_price
FROM Products;

SELECT SUM(quantity) AS items_ordered
FROM OrderItems
WHERE order_num = 20005;

SELECT SUM(item_price * quantity) AS total_price
FROM OrderItems
WHERE order_num = 20005;

SELECT AVG(DISTINCT prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

SELECT COUNT(*) AS num_items,
    MIN(prod_price) AS price_min,
    MAX(prod_price) AS price_max,
    AVG(prod_price) AS price_avg
FROM Products;

SELECT SUM(quantity)
FROM OrderItems;

SELECT SUM(quantity)
FROM OrderItems
WHERE prod_id = 'BR01';

SELECT MAX(prod_price) AS max_price
FROM Products
WHERE prod_price <= 10;

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id;

SELECT cust_id, COUNT(*) AS orders
FROM Orders
GROUP BY cust_id 
HAVING COUNT(*) >= 2;

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
WHERE prod_price >= 4
GROUP BY vend_id 
HAVING COUNT(*) >= 2;

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id 
HAVING COUNT(*) >= 2;

SELECT order_num, COUNT(*) AS order_lines
FROM OrderItems
GROUP BY order_num 
ORDER BY order_lines;

SELECT vend_id, MIN(prod_price) AS cheapest_item
FROM Products
GROUP BY vend_id
ORDER BY cheapest_item;

SELECT order_num, SUM(quantity)
FROM OrderItems
GROUP BY order_num 
HAVING SUM(quantity) >= 100;

SELECT order_num
FROM OrderItems
GROUP BY order_num 
HAVING SUM(quantity) >= 100
ORDER BY order_num;

SELECT order_num, SUM(item_price * quantity) AS total_price
FROM OrderItems
GROUP BY order_num 
HAVING SUM(item_price * quantity) >= 1000
ORDER BY order_num;








