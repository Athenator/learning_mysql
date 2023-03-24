-- показать базу данных
show databases;

-- Удаление базы данных - DROP DATABASE IF EXISTS название; 

DROP DATABASE IF EXISTS lesson; 
CREATE DATABASE lesson;
USE lesson;

CREATE TABLE Customers 
(
	Id INT PRIMARY KEY auto_increment,
    Age INT,
    FirstName varchar(20) NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Orders 
(
Id INT PRIMARY KEY AUTO_INCREMENT,
CustomerId INT,
CreatedId INT,
FOREIGN KEY (CustomerId) REFERENCES Customers (Id)
);

CREATE TABLE Products 
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL, 
    ProductCount INT DEFAULT 0,
    Price DECIMAL
);

CASE 
	WHEN ProductCount = 1
		THEN 'Товар заканчивается'
	WHEN ProductCount = 2
		THEN 'Мало товара'
	WHEN ProductCount = 3 
		THEN 'Есть в наличии'
	ELSE 'Много товара'
END AS Category 
FROM  Products;



SELECT ProductName, Manufacturer,
	if(ProductCount > 3, 'Много товара', 'Мало товара')
FROM Products;
    
UPDATE Products 
SET Price = Price + 3000;

DELETE FROM Products 
WHERE Manufacturet = 'Samsung';

SELECT * FROM Products 
where NOT Manufacturer in ("Apple",'Samsung');
    
SELECT * FROM Customers;

select 3-5;

# Комментарий 
-- Коментарий 
/*
Коментарий
Коментарий
Коментарий
*/
