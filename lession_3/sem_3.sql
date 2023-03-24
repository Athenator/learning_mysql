DROP DATABASE IF EXISTS sem_3;
CREATE DATABASE sem_3;
USE sem_3;

-- персонал
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT,
	salary INT,
	age INT
);	

INSERT INTO staff (firstname,lastname,post,seniority,salary,age)
VALUES 
('Вася','Петров','Начальник','40',100000,60),
('Петр','Власов','Начальник','8',70000,30),
('Катя','Катина','Инженер','2',70000,25),
('Саша','Зайцев','Инженер','12',50000,35),
('Иван','Иванов','Рабочий','40',30000,22),
('Петр','Петров','Рабочий','20',25000,22),
('Сергей','Сидоров','Рабочий','10',20000,22),
('Антон','Ужанов','Рабочий','8',19000,28),
('Юрий','Михайлов','Рабочий','5',15000,25),
('Максим','Горький','Рабочий','2',11000,24),
('Юрий','Сергеев','Рабочий','3',12000,24),
('Людмила','Маркова','Уборщик','10',10000,49);

-- работа персонала
DROP TABLE IF EXISTS activity_staff;
CREATE TABLE activity_staff (
	id INT AUTO_INCREMENT PRIMARY KEY,
	staff_id INT NOT NULL,
	date_activity DATE,
	count_pages INT,
	FOREIGN KEY (staff_id) REFERENCES staff (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO activity_staff (staff_id, date_activity,count_pages)
VALUES 
(1,20220101,250),
(2,20220101,220),
(3,20220101,170),
(1,20220102,100),
(2,20220102,220),
(3,20220102,300),
(7,20220102,350),
(1,20220103,168),
(2,20220103,62),
(3,20220103,84);

-- вывели все записи, отсортированные по полю age по возрастанию 
SELECT *
FROM staff  
ORDER BY age;

-- вывели все записи, отсортированные по полю firstname
SELECT *
FROM staff   
ORDER BY firstname ;


-- вывели все записи полей firstname,lastname,age,отсортированные по полю fistname в алфавитном порядке по убыванию
SELECT firstname,lastname,age
FROM staff
ORDER BY firstname DESC;

-- выполните сортироваку по полям firstname и age по убыванию
SELECT firstname ,age 
FROM staff  
ORDER BY firstname DESC,age DESC;

-- DISTINCT,LIMIT
SELECT DISTINCT(post) FROM staff;

SELECT * FROM staff
LIMIT 10;

SELECT * FROM staff
LIMIT 1, 10;

-- вывод уникальных значений полей firstmane
SELECT DISTINCT id,firstname  FROM staff;

-- сортировка записи по возрастанию значений поля id, вывод первых двух записей
SELECT *
FROM staff   
ORDER BY id
LIMIT 2;

-- сортировка записи по возрастанию значений поля id. Пропуск первых 4 строк данной выборки и извлечение следующих 3
SELECT *
FROM staff   
ORDER BY id
LIMIT 4,3;

-- сортировка записей по убыванию поля id. Пропуск две строки данной выборки и извлечение за ними 3 строк 
SELECT *
FROM staff   
ORDER BY id DESC
LIMIT 2,3;

-- найти количество сотрудников с должностью рабочий 

SELECT count(*) AS Количество_рабочих
FROM staff 
WHERE post = 'Рабочий';

-- посчитать ежемесячную зарплату начальников 
SELECT SUM(salary) AS Зарплата_начальников
FROM staff
WHERE post = 'Начальник';

-- вывести средний возраст сотрудников, у которых зп больше 30000
SELECT avg(age) AS Средний_возраст FROM staff
WHERE salary > 30000;

-- вывести максимальную и минимальную заработные платы
SELECT min(salary),max(salary) FROM staff; 

# GROUP BY

-- Выведите общее количество напечатанных страниц каждым сотрудниом 
SELECT staff_id,SUM(count_pages) 
from activity_staff 
GROUP BY staff_id;

-- Посчитайте количество страниц за каждый день
SELECT date_activity,SUM(count_pages) 
FROM activity_staff 
GROUP BY date_activity;

-- Найдите среднее арифметическое по количеству ежедненых страниц
SELECT date_activity,avg(count_pages) AS среднее
FROM activity_staff 
GROUP BY date_activity;

-- сгруппируйте данные о сотрудниках по возрасту, для каждой группы найдите суммарную зарплату.
SELECT
	#id,
	CASE 
		WHEN age < 20 THEN 'Младше 20 лет'
		WHEN age BETWEEN 20 AND 40 THEN 'от 20 до 40 лет'
		WHEN age > 40 THEN 'Старше 40 лет'
		ELSE 'Не определено'
	END AS name_age,
	SUM(salary) 
FROM staff
GROUP BY name_age;
	
-- выведите id сотрудников, которые напечатали более 500 страниц за все дни
SELECT staff_id
from activity_staff 
GROUP BY staff_id
HAVING SUM(count_pages)>500;
-- выведите дни, когда работало более 3 сотрудников. Так же укажите количество сотрудников, которые работали в выбранные дни.
SELECT 
	date_activity,
	count(*) as cnt_staff
FROM activity_staff
GROUP BY date_activity
HAVING cnt_staff > 3;

-- Выведите среднюю заработною плату по должностям, которая составляет более 30000
SELECT post, avg(salary) FROM staff s 
GROUP BY post 
HAVING avg(salary) > 30000; 

-- Homework

-- 1. Отсортируйте данные по полю заработная плата(salary) в порядке: убывания, возрастания

SELECT * 
FROM staff
ORDER BY salary DESC; # по убыванию
#ORDER BY salary; # по возрастанию

-- 2. Выведите 5 максимальных заработных плат (salary)
SELECT DISTINCT salary AS Max_salary
FROM staff
ORDER BY salary DESC
LIMIT 5;

-- 3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post, SUM(salary) AS Sum_salary
FROM staff s 
GROUP BY post; 

-- 4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT post,COUNT(*) AS Count_staff
FROM staff s 
WHERE age BETWEEN 24 AND 49
GROUP BY post
HAVING post = 'Рабочий'; 

-- 5. Найдите количество специальностей
SELECT COUNT(DISTINCT(post)) AS count_post
FROM staff;

-- 6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
SELECT post, AVG(age) AS avg_age
FROM staff
GROUP BY post
HAVING avg_age < 30;





