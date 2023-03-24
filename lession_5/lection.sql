DROP DATABASE IF EXISTS lection;
CREATE DATABASE lection;
USE lection;

CREATE TABLE sales (
	sales_employee VARCHAR(50) NOT NULL,
	fiscal_year INT NOT NULL,
	sale DECIMAL(14,2) NOT NULL,
	PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES 
('Bob',2016,100),
('Bob',2017,150),
('Bob',2018,200),
('Alice',2016,150),
('Alice',2017,100),
('Alice',2018,200),
('John',2016,200),
('John',2017,150),
('John',2018,250);

SELECT * FROM sales;

-- Пример агрегатной функции 
SELECT fiscal_year, SUM(sale)
FROM sales 
GROUP BY fiscal_year;
 
# Виртуальная таблица
CREATE VIEW copy_sales AS
SELECT *
FROM sales  
WHERE sale = (SELECT MAX(sale) FROM sales);

SELECT * FROM copy_sales;

# Удаление виртуальной и обычной таблицы 
DROP VIEW copy_sales;
DROP TABLE table_name;

# Изменение представлений
ALTER VIEW copy_sales AS
SELECT sales_employee,fiscal_year,sale
FROM sales s 
WHERE sale < 150;

SELECT * FROM copy_sales;

# Добавляем новый столбец в таблицу 
ALTER TABLE sales 
ADD COLUMN sales_string VARCHAR(40); 

# Удаляем столбец из таблицы 
ALTER TABLE sales 
DROP COLUMN sales_string;

CREATE VIEW copy_sales AS 
SELECT * FROM sales
WHERE sale = 
(SELECT MAX(sale) FROM sales);

SELECT * FROM copy_sales;


