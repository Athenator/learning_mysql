# Оператор UNION , примеры

SELECT 1,2 UNION SELECT 'a','b';

# выборка значений из разных таблиц
# UNION удаляет повторяющиеся значения
SELECT first_name, last_name
FROM customers
UNION SELECT first_name,last_name FROM empoyees;

-- ORDER BY
SELECT first_name, last_name
FROM customers
UNION SELECT first_name,last_name FROM empoyees
ORDER BY first_name DESC;

-- UNION ALL - объединение двух селектов
-- чтобы повторяющиеся значения не удалялись
SELECT first_name, last_name
FROM customers
UNION ALL SELECT first_name,last_name 
FROM empoyees
ORDER BY first_name;

-- UNION в пределах одной таблицы. начисление проценто в на вклад: 
-- если сумма меньше 3000, то проценты в размере 10%, если больше,то проценты увеличиваются до 30%
SELECT first_name,last_name,account_sum + account_sum * 0.1 AS totas_sum
FROM customers WHERE account_sun < 3000
UNION SELECT first_name,last_name,account_sum + account_sum * 0.3 AS total_sum
FROM costomers WHERE account_sum => 3000;

-- Соединение таблиц - JOIN

# Inner join выберем все заказы и добавим к ним информацию о товарах
SELECT orders.created_at, orders.product_count,products.product_name
FROM orders
JOIN products ON products.id = orders.product_id;

# LEFT OUTER JOIN: пример 
SELECT first_name, created_at,product_count,price,product_id
FROM orders LEFT JOIN customers 
ON orders.customer_id = customers.id;

# RIGHT OUTER JOIN: пример 
SELECT first_name, created_at,product_count,price,product_id
FROM customers RIGHT JOIN orders 
ON orders.customer_id = customers.id;

-- FULL JOIN в SQL нету, поэтому заменяем его с помощью UNION:
SELECT p.product_name, c.category_name
FROM products p
LEFT JOIN categories c ON p.category = c.category_id

UNION 

SELECT p.product_name, c.category_name
FROM products p
RIGHT JOIN categories c ON p.category = c.category_id;
-- одинаковые значения так же уходят

-- Подзапросы: оператор IN 
# Выберем все товары из таблицы producst, на которые есть заказы в таблице oreders 
SELECT * FROM products 
WHERE id IN (SELECT product_id FROM orders)

# можем выбрать те товары, на которые нет заказов в таблице orders:
SELECT * FROM products 
WHERE id NOT IN (SELECT product_id FROM orders)

-- Подзапросы: оператор EXISTS, WHERE [NOT] EXISTS
SELECT * FROM products 
WHERE EXISTS
(SELECT * FROM orders WHERE orders.product_id = products.id)

# CREATE TABLE SELECT tableName SELECT * FROM youOriginalTable; - копирование таблички в новую таблицу 
SELECT * FROM myTable;
CREATE TABLE newTable SELECT * FROM myTable;
SELECT * FROM newTable;

# Порядок выполнения запроса 
SELECT [DISTINCT | ALL] поля_таблиц 
FROM список_таблиц
[WHERE условия_на_ограничения_строк]
[GROUP BY условия_группировки]
[HAVING условия_на_ограничения_строк_после_группировки]
[ORDER BY орядок_сортировки[ASC|DESC]]
[LIMIT ограничение_количества_записей]

