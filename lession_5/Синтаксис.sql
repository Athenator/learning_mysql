 /*
  * -----------------------------Синтаксис оконной функции------------------------------
SELECT 
название функции (столбец для вычислений )
OVER
( 
	PARTITION BY столбец для группировки 
	ORDER BY столбец для сортировки 
	ROWS или RANGE выражение для ограничения строк в предеах группы 
)

SELECT 
	data,
	medium,
	conversion
	SUM(conversion) OVER(PARTITION BY data) AS 'Sum'
FROM Oreders;

SELECT 
	data,
	medium,
	conversion
	SUM(conversion) OVER(PARTITION BY data ORDER BY conversion ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS 'Sum'
FROM Orders;

SELECT 
	data,
	medium,
	conversion
	SUM(conversion) OVER(PARTITION by data) AS 'Sum',
	COUNT(conversion) OVER(PARTITION by data) AS 'Count',
	AVG(conversion) OVER(PARTITION by data) AS 'Avg',
	MAX(conversion) OVER(PARTITION by data) AS 'Max',
	MIN(conversion) OVER(PARTITION by data) AS 'Min'
FROM Orders;
	
SELECT 
	data,
	medium,
	conversion
	ROW_NUMBER() - индексация строк
	OVER(PARTITION by data ORDER BY conversion) AS 'Row_number',
	RANK() - задаём ранк каждой строки 
	OVER(PARTITION by data ORDER BY conversion) AS 'RANK',
	DENSE_RANK() - так же задаём ранг строк
	OVER(PARTITION by data ORDER BY conversion) AS 'Dense_rank',
	NTITLE(3) - делим табличку на 3 группы
	OVER(PARTITION by data ORDER BY conversion) AS 'Ntitle'
FROM Orders;

SELECT 
	data,
	medium,
	conversion
	LAG(conversion) OVER(PARTITION by data OREDER BY data) AS 'lag',
	LEAD(conversion) OVER(PARTITION by data OREDER BY data) AS 'lead',
	FIRST_VALUE(conversion) OVER(PARTITION by data OREDER BY data) AS 'first_value',
	LAST_VALUE(conversion) OVER(PARTITION by data OREDER BY data) AS 'last_value'
FROM Orders;

------------------------------------------- ПОРЯДОК ФУНКЦИЙ ---------------------------------------
SELECT
FROM
WHERE
GOUP BY
HAVING
ORDER BY

--------------------------------------------- Представления ------------------------------------

CREATE [OR REPLACE] VIEW view_name AS
	SELECT columns
	FROM tables
	[WHERE conditions]
	
OR REPLACE - необязательный. Если вы не укажете этот атрибут и VIEW уже существуют, оператор CREATE VIEW вернёт ошибку.
view_name - имя VIEW, которое вы хотите создать в MySQL.
WHERE conditions - необязательный. Условия, которые должы быть выполнены для записей, которые должны быть включены в VIEW.

CREATE VIEW lodonstaff 
		AS select*
		FROM salespeople
		WHERE city = 'London';
SELECT * FROM londonstaff;

CREATE VIEW customer_archive AS
SELECT customer_id, customer_name, contact_no, purchased_amount,city
FROM customer
WHERE purchased amount > 1000;

DROP VIEW customers - удаление таблички 

Объединение 
CREATE VIEW view-name AS
SELECT column1,column2,column3
FROM table1 JOIN table2
ON table1.column = table2.column

---------------------------------- Операции с представлениями: Изменение --------------------------
ALTER VIEW view_name AS
SELECT column
FROM table
WHERE conditions

ALTER VIEW hardware_suppliers AS
SELECT suplier_id, supplier_name, addres, city 
FROM suppliers
WHERE category_type = 'Hardware';

CREATE VIEW highratings AS 
SELECT * FROM customers
WHERE rating = 
(SELECT MAX (rating) FROM customers);
*/
 
