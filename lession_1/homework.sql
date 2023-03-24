DROP TABLE IF EXISTS mobile_phones;
CREATE TABLE mobile_phones (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    product_name VARCHAR(45),
    manufacturer VARCHAR(45) COMMENT 'Брэнд, компания',
    product_count INT,
    price INT
);


INSERT INTO mobile_phones (product_name,manufacturer,product_count,price)
VALUES
('iPhone X', 'Apple', 4, 62000),
('iPhone 8', 'Apple', 9, 44000),
('Galaxy S7', 'Samsung', 5, 51000),
('Galaxy S9', 'Samsung', 1, 58000),
('P20 Pro X', 'Huawei', 12, 32000);

SELECT product_name,manufacturer,price 
FROM mobile_phones WHERE product_count > 2;

SELECT id,product_name,manufacturer,product_count,price
FROM mobile_phones WHERE manufacturer = 'Samsung';