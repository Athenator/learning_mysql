-- пример сортировки с помощью ORDER BY 
SELECT * FROM Products
ORDER BY Price;

-- использование псевдонима в запросе с ORDER BY 

SELECT ProductName, ProductCount * Price AS TotalSum
FROM Products
ORDER BY TotalSum;

-- ограничение выборки LIMIT 
SELECT поля_выборки
FROM список_таблиц
LIMIT [количество_пропущенных_записей,] количество_записей_для_вывода;
-- оператор LIMIT позволяет извлечт определенное количество строку и имеет следующий синтаксис: 
LIMIT [offser,] rowcount

-- пример использования: LIMIT 

-- выбор первых трёх строчек: 
SELECT * FROM Products
LIMIT 3;

-- или выберем три строчки, начиная со 2 позиции 

SELECT * FROM Products
LIMIT 2, 3;

-- аналог извлечения диапазона строк 
-- вывод первых 2 строк 
SELECT TOP 2 *
FROM Object

-- Ограничение выборки : FETCH
SELECT column_names FROM table_name ORDER BY column_names OFFSET
rows_to_be_skipped FETCH NEXT n ROWS ONLY;
-- пример: будут исключаться m строк и выбрать следующие p строк - будут выведены строки от (m+1) до (m+1+p)
SELECT column_names FROM table_name ORDER BY column_names OFFSET m ROWS 
FETCH NEXT p ROWS ONLY;

-- уникальные значения -distinct
-- пример вывода уникальных значений из таблицы 
SELECT DISTINCT manufacturer FROM products;
-- вывод по нескольким столбцам 
SELECT DISTINCT manufacturer,product_count FROM products;

-- группировка - GROUP BY
-- пример
SELECT  manufacturer, count(*) AS models_count -- подсчет и вывод в отдельной колонке
from products
GROUP BY manufacturer;

-- агрегатные функции 

-- AVG - средняя величина
SELECT avg(price) AS average_price FROM products; 

SELECT avg(price) AS average_price FROM products
WHERE manufacturer='apple';

-- COUNT - количество строк 
SELECT count(*) FROM products;

-- MIN и MAX 
SELECT min(price),max(price) FROM products;  

-- HAVING - фильт групп
-- найдем все группы товаров по производителям, для которых определено более 1 модели: 
SELECT manufacturer, count(*) AS model_count
FROM products 
GROUP BY manufacturer
HAVING COUNT(*) > 1;

SELECT manufacturer, count(*) AS models, SUM(product_count) AS units
FROM products 
WHERE price * product_count > 80000
GROUP BY manufacturer
HAVING SUM(product_count) > 2
ORDER BY units DESC;



-- ПРАКТИКА

-- сортировка по цене, по возрастанию
SELECT *
FROM products 
ORDER BY price;

-- сотировка по убыванию
SELECT *
FROM products 
ORDER BY price DESC;

-- получаем количество записей из таблички 
SELECT count(*) as sum
from products;

-- TOP LIMIT
# указан только 1 параметр, вывод всех значений, до 5 
SELECT * FROM products
LIMIT 5;

# 2 параметра, 1 - с какой строки начинаем выводить 2 - до какой

SELECT * FROM products
LIMIT 2,6; # cо 2 до 6 строчки

-- SUM 

SELECT SUM(price) FROM products; # сумма всех продукций в табличке 

-- MIN, MAX 
SELECT MIN(price)
FROM product
WHERE manufacturer = 'apple';

SELECT 
	MIN(price),
	max(price),
	avg(price)
FROM products
WHERE manufacturer = 'samsung';

-- вывод: цена выше 40000, и производилась группировка 
SELECT manufacturer, COUNT(*) AS models,price,product_count
from products
WHERE price > 40000
GROUP BY manufacturer;
