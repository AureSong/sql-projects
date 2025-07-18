-- SQL 基础语法练习：数据库与数据表的创建、删除（MySQL）
-- 灵感参考：某知名 SQL 教程中的结构（已重构命名）
-- 本文件仅用于个人学习目的，非商业用途

CREATE DATABASE Learning;
DROP DATABASE Learning;

CREATE DATABASE DemoDB;

SHOW DATABASES;

USE DemoDB;

CREATE TABLE Suppliers
(
    supplier_id CHAR(10) NOT NULL PRIMARY KEY,
    supplier_name CHAR(50) NOT NULL,
    supplier_address CHAR(50),
    supplier_city CHAR(50),
    supplier_state CHAR(5),
    supplier_zip CHAR(10),
    supplier_country CHAR(50)
);

CREATE TABLE Items
(
    item_id CHAR(10) NOT NULL PRIMARY KEY,
    supplier_id CHAR(10) NOT NULL ,
    item_name CHAR(255) NOT NULL,
    item_price DECIMAL(8, 2) NOT NULL,
    item_desc TEXT,
    CONSTRAINT FK_Items_Suppliers 
        FOREIGN KEY (supplier_id)
        REFERENCES Suppliers(supplier_id)
);


CREATE TABLE Clients
(
    client_id CHAR(10) NOT NULL PRIMARY KEY,
    client_name CHAR(50) NOT NULL,
    client_address CHAR(50),
    client_city CHAR(50),
    client_state CHAR(5),
    client_zip CHAR(10),
    client_country CHAR(50),
    client_contact CHAR(50),
    client_email CHAR(255)
);

CREATE TABLE Purchases
(
    purchase_num INT NOT NULL PRIMARY KEY,
    purchase_date DATETIME NOT NULL,
    client_id CHAR(10) NOT NULL,
    CONSTRAINT FK_Purchases_Clients
        FOREIGN KEY (client_id)
        REFERENCES Clients(client_id)
);

CREATE TABLE PurchaseDetails
(
    purchase_num INT NOT NULL,
    purchase_item INT NOT NULL,
    item_id CHAR(10) NOT NULL,
    quantity INT NOT NULL,
    purchase_price DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY(purchase_num, purchase_item),
    CONSTRAINT FK_PurchaseDetails_Purchases
        FOREIGN KEY (purchase_num)
        REFERENCES Purchases(purchase_num),
    CONSTRAINT FK_PurchaseDetails_Items
        FOREIGN KEY (item_id)
        REFERENCES Items(item_id)
);

DROP TABLE PurchaseDetails;

CREATE TABLE PurchaseDetails
(
    purchase_num INT NOT NULL,
    purchase_item INT NOT NULL,
    item_id CHAR(10) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    purchase_price DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY(purchase_num, purchase_item),
    CONSTRAINT FK_PurchaseDetails_Purchases
        FOREIGN KEY (purchase_num)
        REFERENCES Purchases(purchase_num),
    CONSTRAINT FK_PurchaseDetails_Items
        FOREIGN KEY (item_id)
        REFERENCES Items(item_id)
);

