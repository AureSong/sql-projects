USE BookLearning;

INSERT INTO Customers
VALUES(1000000006,
    'Toy Land',
    '123 Any Street',
    'New York',
    'NY',
    '11111',
    'USA',
    NULL,
    NULL
);

INSERT INTO Customers(cust_id,
    cust_name, 
    cust_address,
    cust_city,
    cust_state,
    cust_zip,
    cust_country,
    cust_contact,
    cust_email
    )
VALUES(1000000006,
    'Toy Land',
    '123 Any Street',
    'New York',
    'NY',
    '11111',
    'USA',
    NULL,
    NULL
);

USE BookLearning;

INSERT INTO Customers(cust_id, 
    cust_contact,
    cust_email,
    cust_name,
    cust_address,
    cust_city,
    cust_state,
    cust_zip,
    cust_country
    )
SELECT cust_id,
    cust_contact,
    cust_email,
    cust_name,
    cust_address,
    cust_city,
    cust_state,
    cust_zip,
    cust_country
FROM CustNew;

CREATE TABLE CustCopy AS SELECT * FROM Customers;

CREATE TABLE OrdersCopy AS SELECT * FROM Orders;

CREATE TABLE OrderItemsCopy AS SELECT * FROM OrderItems;

UPDATE Customers
SET cust_email = 'kim@thetoystore.com'
WHERE cust_id = 1000000005;

UPDATE Customers
SET cust_contact = 'Sam Robers',
    cust_email = 'sam@toyland.com'
WHERE cust_id = 1000000006;

UPDATE Customers
SET cust_email = NULL
WHERE cust_id = 1000000005;

DELETE FROM Customers
WHERE cust_id = 1000000006;

TRUNCATE TABLE CustCopy;

UPDATE Vendors
SET vend_state= UPPER(vend_state)
WHERE vend_country = 'USA';

UPDATE Customers
SET cust_state = UPPER(cust_state)
WHERE cust_country = 'USA';

DELETE FROM Customers
WHERE cust_id = 1000000009;










