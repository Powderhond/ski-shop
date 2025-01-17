USE shopdb

-- DROP TABLE IF EXISTS review;
-- DROP TABLE IF EXISTS shipment;
-- DROP TABLE IF EXISTS productinventory;
-- DROP TABLE IF EXISTS warehouse;
-- DROP TABLE IF EXISTS orderproduct;
-- DROP TABLE IF EXISTS incart;
-- DROP TABLE IF EXISTS product;
-- DROP TABLE IF EXISTS category;
-- DROP TABLE IF EXISTS ordersummary;
-- DROP TABLE IF EXISTS paymentmethod;
-- DROP TABLE IF EXISTS customer;


CREATE TABLE IF NOT EXISTS customer (
    customerId          INT PRIMARY KEY AUTO_INCREMENT,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS paymentmethod (
    paymentMethodId     INT PRIMARY KEY AUTO_INCREMENT,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS ordersummary (
    orderId             INT PRIMARY KEY AUTO_INCREMENT,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS category (
    categoryId          INT PRIMARY KEY AUTO_INCREMENT,
    categoryName        VARCHAR(50)  
);

CREATE TABLE IF NOT EXISTS product (
    productId           INT PRIMARY KEY AUTO_INCREMENT,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        BLOB,
    productDesc         VARCHAR(1000),
    categoryId          INT,
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE IF NOT EXISTS orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS warehouse (
    warehouseId         INT PRIMARY KEY AUTO_INCREMENT,
    warehouseName       VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS shipment (
    shipmentId          INT PRIMARY KEY AUTO_INCREMENT,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS review (
    reviewId            INT PRIMARY KEY AUTO_INCREMENT,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Beverages');
INSERT INTO category(categoryName) VALUES ('Condiments');
INSERT INTO category(categoryName) VALUES ('Dairy Products');
INSERT INTO category(categoryName) VALUES ('Produce');
INSERT INTO category(categoryName) VALUES ('Meat/Poultry');
INSERT INTO category(categoryName) VALUES ('Seafood');
INSERT INTO category(categoryName) VALUES ('Confections');
INSERT INTO category(categoryName) VALUES ('Grains/Cereals');


INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chai', 1, '10 boxes x 20 bags',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chang',1,'24 - 12 oz bottles',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Aniseed Syrup',2,'12 - 550 ml bottles',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chef Anton''s Cajun Seasoning',2,'48 - 6 oz jars',22.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chef Anton''s Gumbo Mix',2,'36 boxes',21.35);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grandma''s Boysenberry Spread',2,'12 - 8 oz jars',25.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Uncle Bob''s Organic Dried Pears',4,'12 - 1 lb pkgs.',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Northwoods Cranberry Sauce',2,'12 - 12 oz jars',40.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mishi Kobe Niku',5,'18 - 500 g pkgs.',97.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ikura',6,'12 - 200 ml jars',31.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Queso Cabrales',3,'1 kg pkg.',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Queso Manchego La Pastora',3,'10 - 500 g pkgs.',38.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Tofu',4,'40 - 100 g pkgs.',23.25);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Genen Shouyu',2,'24 - 250 ml bottles',15.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pavlova',7,'32 - 500 g boxes',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Alice Mutton',5,'20 - 1 kg tins',39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Carnarvon Tigers',6,'16 kg pkg.',62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Teatime Chocolate Biscuits',7,'10 boxes x 12 pieces',9.20);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sir Rodney''s Marmalade',7,'30 gift boxes',81.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sir Rodney''s Scones',7,'24 pkgs. x 4 pieces',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gustaf''s Knackebread',8,'24 - 500 g pkgs.',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sasquatch Ale',1,'24 - 12 oz bottles',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Steeleye Stout',1,'24 - 12 oz bottles',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Inlagd Sill',6,'24 - 250 g  jars',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Boston Crab Meat',6,'24 - 4 oz tins',18.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Jack''s New England Clam Chowder',6,'12 - 12 oz cans',9.65);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Singaporean Hokkien Fried Mee',8,'32 - 1 kg pkgs.',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Louisiana Fiery Hot Pepper Sauce',2,'32 - 8 oz bottles',21.05);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Laughing Lumberjack Lager',1,'24 - 12 oz bottles',14.00);
    
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');


SET @oid := 1;
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (@oid, '2019-10-15 10:25:55', 91.70);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 1, 1, 18);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 5, 2, 21.35);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 10, 1, 31);

SET @oid := 2;
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (@oid, '2019-10-16 18:00:00', 106.75);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 5, 5, 21.35);

SET @oid := 3;
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (@oid, '2019-10-15 3:30:22', 140);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 6, 2, 25);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 7, 3, 30);

SET @oid := 2;
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (@oid, '2019-10-17 05:45:11', 327.85);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 3, 4, 10);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 8, 3, 40);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 13, 3, 23.25);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 28, 2, 21.05);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 29, 4, 14);

SET @oid := 5;
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (@oid, '2019-10-15 10:25:55', 277.40);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 5, 4, 21.35);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 19, 2, 81);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@oid, 20, 3, 10);
