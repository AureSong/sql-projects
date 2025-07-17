USE BookLearning;

-- Create Customers table
CREATE TABLE Customers
(
    cust_id CHAR(10) NOT NULL,
    cust_name CHAR(50) NOT NULL,
    cust_address CHAR(50) NULL,
    cust_city CHAR(50) NULL,
    cust_state CHAR(5) NULL,
    cust_zip CHAR(10) NULL,
    cust_country CHAR(50) NULL,
    cust_contact CHAR(50) NULL,
    cust_email CHAR(255) NULL
);


-- ----
-- Create OrderItems table
-- ----
CREATE TABLE OrderItems
(
    order_num INT NOT NULL,
    order_item INT NOT NULL,
    prod_id CHAR(10) NOT NULL,
    quantity INT NOT NULL,
    item_price DECIMAL(8, 2) NOT NULL
);

-- ----
-- Create Orders table
-- ----
CREATE TABLE Orders
(
    order_num INT NOT NULL,
    order_date DATETIME NOT NULL,
    cust_id CHAR(10) NOT NULL
);

-- ----
-- Create Products table
-- ----
CREATE TABLE Products
(
    prod_id CHAR(10) NOT NULL,
    vend_id CHAR(10) NOT NULL,
    prod_name CHAR(255) NOT NULL,
    prod_price DECIMAL(8, 2) NOT NULL,
    prod_desc TEXT NULL
);

-- ----
-- Create Vendors table
-- ----
CREATE TABLE Vendors
(
    vend_id CHAR(10) NOT NULL,
    vend_name CHAR(50) NOT NULL,
    vend_address CHAR(50) NULL,
    vend_city CHAR(50) NULL,
    vend_state CHAR(5) NULL,
    vend_zip CHAR(10) NULL,
    vend_country CHAR(50) NULL
);

-- Define primary keys
ALTER TABLE Customers ADD PRIMARY KEY(cust_id);
ALTER TABLE OrderItems ADD PRIMARY KEY(order_num, order_item);
ALTER TABLE Orders ADD PRIMARY KEY(order_num);
ALTER TABLE Products ADD PRIMARY KEY(prod_id);
ALTER TABLE Vendors ADD PRIMARY KEY (vend_id);

-- Define foreign keys
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (order_num) REFERENCES Orders (order_num);
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Products FOREIGN KEY (prod_id) REFERENCES Products (prod_id);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Vendors FOREIGN KEY (vend_id) REFERENCES Vendors (vend_id);