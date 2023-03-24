-- Первое задание 
CREATE TABLE sales 
(
id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
order_data DATE NOT NULL,
count_product INT NOT NULL   
);

INSERT INTO sales (order_data,count_product)
VALUES
(20220101,156),
(20220102,180),
(20220103,21),
(20220104,124),
(20220105,341);

Select 
	id AS 'Id Заказа',
    IF(count_product < 100,'Маленький заказ',
		IF(count_product BETWEEN 100 AND 300, 'Средний заказ',
			IF(count_product > 300,'Большой заказ','Не определенный заказ')
        )
    ) AS 'Тип заказа'
FROM sales;

-- Второе задание 

CREATE TABLE orders 
(
id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
employee_id VARCHAR(10) NOT NULL,
amount DECIMAL(5,2) NOT NULL,
order_status VARCHAR(10) NOT NULL   
);

INSERT INTO orders (employee_id,amount,order_status)
VALUES
('e03',15.00,'OPEN'),
('e01',25.50,'OPEN'),
('e05',100.70,'CLOSED'),
('e02',22.18,'OPEN'),
('e04',9.50,'CANCELLED');

Select 
	id,
    employee_id,
    amount,
	order_status,
    CASE order_status
		WHEN'OPEN' THEN 'Order is in open state'
		WHEN 'CLOSED' THEN 'Order is closed'
		WHEN 'CANCELLED' THEN 'Order is cancelled'
        ELSE 'Not specified'
	END AS full_order_status
FROM orders;