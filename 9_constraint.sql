CREATE TABLE Vendors
(
    vend_id CHAR(10) NOT NULL PRIMARY KEY,
    vned_name CHAR(50) NOT NULL,
    vend_address CHAR(50) NULL,
    vend_city CHAR(50) NULL,
    vend_state CHAR(5) NULL,
    vend_zip CHAR(10) NULL,
    vend_country CHAR(50) NULL
);

ALTER TABLE Vendor
ADD CONSTRAINT PRIMARY KEY (vend_id);

CREATE TABLE Orders 
(
    order_num INTEGER NOT NULL PRIMARY KEY,
    order_date DATETIME NOT NULL,
    cust_id CHAR(10) NOT NULL REFERENCES Customers(cust_id)
);

ALTER TABLE Orders
ADD CONSTRAINT FOREIGN KEY(cust_id) REFERENCES Customers(cust_id);

CREATER TABLE OrderItems 
(
    order_num INTEGER NOT NULL ,
    order_item INTEGER NOT NULL,
    prod_id CHAR(10) NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity > 0),
    item_price MONEY NOT NULL 
);
























