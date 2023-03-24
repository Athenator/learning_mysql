# Синтаксис транзакций 

# START TRANSACTION;
# SELECT total FROM accounts WHERE user_id = 2;
# UPDATE accounts SET total = total - 3000 WHERE user_id = 2;
# UPDATE accounts SET total - total + 3000 WHERE user_id IS NULL;
# COMMIT;

/*
 * Переменная MySQL
 * 
 * SET @variable_name := value;
 * SET @counter := 100l;
 * 
 * SELECT @variable_name = value; 
 * 
 *  Получаем самый дорогой продукт в таблице products
 * SELECT @msrp := MAX(msrp)
 * FROM products;
 * 
 * Оператор IF
 * IF(expr,if_true_expr,if_false_expr)
 * SELECT IF(400<2000,'YES','NO');
 * 
 * Отображения N\A вместо NULL
 * SELECT 
 * 	customerNumber,
 * 	customerName,
 * 	IF(state is NULL, 'N/A', state) state,
 * 	country
 * FROM 
 * 	customers;
 * 
 * Оператор IF вместе с агрегатными функциями
 * 
 * SELECT 
 * 	SUM(IF(status = 'Snipped', 1,0)) AS Shipped,
 * 	SUM(IF(status = 'Cancelled',1,0)) AS Cancelled
 * FROM
 * 	orders;
 * 
 * Оператор COUNT IF
 * 
 * SELECT DISTINCT
 * 	status
 * FROM
 * 	orders
 * ORDER BY STATUS;
 * 
 * SELECT 
 * 	COUNT(IF(status = 'Cancelled',1,NULL)) Cabcelled,
 * 	COUNT(IF(status = 'Disputed',1,NULL)) Disputed,
 * 	COUNT(IF(status = 'In process',1,NULL)) 'In process,
 * 	COUNT(IF(status = 'On hold',1,NULL)) 'On hold',
 * 	COUNT(IF(status = 'Resolved',1,NULL)) 'Resolved',
 * 	COUNT(IF(status = 'Snipped',1,NULL)) 'Snipped'
 * FROM 
 * 	orders;
 * 
 * Синтаксис процедуры 
 * CREATE PROCEDURE procedure_name [(parameter datatype [,paramenter datatype])]
 * BEGIN 
 * 	declaration_section
 * 	executable_section
 * END;
 * 
 * Цикл WHILE
 * 
 * [label_name:] WHILE condition DO
 * 	{...statements...}
 * END WHiLE [label_name];
 * 
 * Пишем уороченный запрос, с помощью while:
 * DECLARE i INT DEFAULT 3;
 * 	WHILE i > 0 DO
 * 		SELECT magazine.id_incoming,products.name,products,author,magazine_incoming.quantuty
 * 		FROM magazine,products
 * 		WHERE magazine.id_product = product.id_product AND magazine.id_incoming = i;
 * 		SET i = i-1;
 * END WHILE;
 * 
 * Процедура с помощью while(модификация процедуры):
 * 
 * CREATE PROCEDURE books (IN num INT)
 * 	begin
 * 		DECLARE i INT DEFAULT 0;
 * 		IF (num > 0) THEN 
 * 			WHILE i < num DO 
 * 				SELECT magazine.id_incoming, products.name,products.author,
 * 						magazine.quantity
 * 				FROM magazine,products
 * 				WHERE magazine.id_products=products.id_product AND magazine.id_incoming = i;
 * 				SET i = i+1;
 * 			END WHILE;
 * 		ELSE
 * 			SELECT 'Задайте правильный параметр';
 * 		END IF;
 * end
*/				