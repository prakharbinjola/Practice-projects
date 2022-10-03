CREATE DATABASE 
IF NOT EXISTS 
Sales;
Use Sales;

CREATE TABLE sales(
purchase_number INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
date_of_purchase DATE NOT NULL,
customer_id INT,
item_code VARCHAR(10) NOT NULL
);

CREATE TABLE customers(
customer_id INT, 
first_name VARCHAR(255), 
last_name VARCHAR(255), 
email_address VARCHAR(255), 
number_of_complaints INT 
);

SHOW TABLES;

SELECT * FROM customers;
SELECT * FROM Sales.customers;

SELECT * FROM sales;
select * from sales.sales;

DROP TABLE sales;

CREATE TABLE sales(
purchase_number INT NOT NULL AUTO_INCREMENT,
date_of_purchase DATE NOT NULL,
customer_id INT,
item_code VARCHAR(10) NOT NULL,
PRIMARY KEY(purchase_number)
);

DROP TABLE customers;

CREATE TABLE customers(
customer_id INT, 
first_name VARCHAR(255), 
last_name VARCHAR(255), 
email_address VARCHAR(255), 
number_of_complaints INT,
PRIMARY KEY(customer_id)
);

CREATE TABLE items(
item_code VARCHAR(255), 
item VARCHAR(255), 
unit_price  NUMERIC(10, 2), 
company_id VARCHAR(255), 
PRIMARY KEY(item_code)
);

CREATE TABLE companies(
company_id VARCHAR(255), 
company_name VARCHAR(255),
headquarters_phone_number INT(12), 
PRIMARY KEY(company_id)
);

#Adding foreign key on table sales
ALTER TABLE sales
ADD FOREIGN KEY(customer_id) references customers(customer_id) ON DELETE cascade;

#Dropping foreign key
ALTER TABLE sales
DROP foreign key sales_ibfk_3;

DROP TABLE sales;
DROP TABLE customers;
DROP TABLE items;
DROP TABLE companies;

#Unique key
CREATE TABLE customers(
customer_id INT, 
first_name VARCHAR(255), 
last_name VARCHAR(255), 
email_address VARCHAR(255), 
number_of_complaints INT,
PRIMARY KEY(customer_id), 
UNIQUE KEY(email_address)
);

DROP TABLE customers;

CREATE TABLE customers(
customer_id INT, 
first_name VARCHAR(255), 
last_name VARCHAR(255), 
email_address VARCHAR(255), 
number_of_complaints INT,
PRIMARY KEY(customer_id)
);
ALTER TABLE customers
ADD UNIQUE KEY(email_address);
#Dropping unique key
ALTER TABLE customers
DROP INDEX email_address;

#Adding default value
ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;
#Dropping default value
ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

#Adding not null
CREATE TABLE companies(
company_id VARCHAR(255), 
company_name VARCHAR(255) NOT NULL,
headquarters_phone_number INT(12), 
PRIMARY KEY(company_id)
);
#Dropping not null
ALTER TABLE companies
MODIFY COLUMN company_name VARCHAR(255) NULL;
#Adding not null using alter
ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

ALTER TABLE companies
MODIFY COLUMN headquarters_phone_number VARCHAR(255) NOT NULL;