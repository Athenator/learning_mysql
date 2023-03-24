DROP DATABASE IF EXISTS sem_5;
CREATE DATABASE sem_5;
USE sem_5;

-- Персонал
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

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Ольга', 'Васютина', 'Инженер', '2', 70000, 25),
('Петр', 'Некрасов', 'Уборщик', '36', 16000, 59),
('Саша', 'Петров', 'Инженер', '12', 50000, 49),
('Иван', 'Сидоров', 'Рабочий', '40', 50000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49),
('Юрий', 'Онегин', 'Начальник', '8', 100000, 39);

-- Ранжирование 

# Вывести список всех сотрудников и указать место в рейтинге по зарплатам
SELECT 
	-- RANK() OVER(ORDER BY salary DESC) AS rank_salary,
	DENSE_RANK() OVER(ORDER BY salary DESC) AS rank_salary,
	CONCAT(firstname,' ', lastname),
	post,
	salary
FROM staff;

# Вывести список всех сотрудников и указать место в рейтинге по зарплатам, но по отдельным категориям
SELECT 
	DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS rank_salary,
	CONCAT(firstname, ' ', lastname) AS 'Работник',
	post,
	salary
FROM staff;

# Вывести самых высокооплачиваемых сотрудников по каждой должности 
SELECT rank_salary,
	staff,
	post,
	salary
FROM
(SELECT 
	DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS rank_salary,
	CONCAT(firstname, ' ', lastname) AS staff,
	post,
	salary
FROM staff) AS list
WHERE rank_salary = 1
ORDER BY salary DESC;

# Вывести сисок всех сотрудников, отсортитовав по зарплатам в порядке убывания 
# и указать на сколько процентов ЗП меньше, чем у сотрудника со следующей зарплатой.
SELECT 
	id,
	CONCAT(firstname, ' ', lastname) AS staff,
	post,
	salary,
	LEAD(salary,1,'сотрудник отсутствует') OVER(ORDER BY salary DESC) AS last_salary,
	ROUND((salary-LEAD(salary) OVER(ORDER BY salary DESC))*100/salary) AS 'Разница в тыс.'
FROM staff;

-- Агрегация 

#Вывести всех сотрудников, отсортировав по зарплатам в рамках каждой 
# должности и рассчитать: 
# - общую сумму зарплат для каждой должности 
# - процентное соотношение каждой зарплаты от общей суммы по должности
# - среднюю зарплату по каждой должности 
# - процентное соотношение каждой зарплаты к средней зарплате по должности
SELECT 
	id,
	CONCAT(firstname, ' ', lastname) AS staff,
	post,
	salary,
	SUM(salary) OVER w AS sum_salary,
	ROUND(salary*100/SUM(salary) OVER w) AS percent_sum,
	AVG(salary) OVER w AS avg_salary,
	ROUND(salary*100/AVG(salary)OVER w) AS percent_avg
FROM staff s 
WINDOW w AS (PARTITION BY post);
-- w1 AS (PARTITION BY firstname);

# Примеры использования оконных функций
SELECT 
	id,firstname,lastname,salary,
	ROW_NUMBER() OVER(ORDER BY salary DESC) AS 'Row_number',
	RANK() OVER(ORDER BY salary DESC) AS 'Rank',
	DENSE_RANK() OVER(ORDER BY salary DESC) AS 'Dense_rank',
	NTILE(3) OVER(ORDER BY salary DESC) AS 'Ntitle'
	FROM staff;


DROP TABLE IF EXISTS academic_record;
CREATE TABLE academic_record (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(45),
	quartal  VARCHAR(45),
    subject VARCHAR(45),
	grade INT
);

INSERT INTO academic_record (name, quartal, subject, grade)
values
	('Александр','1 четверть', 'математика', 4),
	('Александр','2 четверть', 'русский', 4),
	('Александр', '3 четверть','физика', 5),
	('Александр', '4 четверть','история', 4),
	('Антон', '1 четверть','математика', 4),
	('Антон', '2 четверть','русский', 3),
	('Антон', '3 четверть','физика', 5),
	('Антон', '4 четверть','история', 3),
    ('Петя', '1 четверть', 'физика', 4),
	('Петя', '2 четверть', 'физика', 3),
	('Петя', '3 четверть', 'физика', 4),
	('Петя', '2 четверть', 'математика', 3),
	('Петя', '3 четверть', 'математика', 4),
	('Петя', '4 четверть', 'физика', 5);

-- Задача 1. Получить с помощью оконных функций: 
-- средний балл ученика 
-- наименьшую оценку ученика
-- наибольшую оценку ученика 
-- сумму всех оценок 
-- количество всех оценок 

SELECT 
	name,quartal,subject,grade,
	AVG(grade) OVER(PARTITION BY name) AS avg_grade,
	MIN(grade) OVER(PARTITION BY name) AS min_grade,
	MAX(grade) OVER(PARTITION BY name) AS max_grade,
	SUM(grade) OVER(PARTITION BY name) AS sum_grade,
	COUNT(grade) OVER(PARTITION BY name) AS count_grade
FROM academic_record;
	
-- Более сокращенный вариант 
SELECT 
	name,quartal,subject,grade,
	AVG(grade) OVER w AS avg_grade,
	MIN(grade) OVER w AS min_grade,
	MAX(grade) OVER w AS max_grade,
	SUM(grade) OVER w AS sum_grade,
	COUNT(grade) OVER w AS count_grade
FROM academic_record 
WINDOW w AS (PARTITION BY name);

-- Задача2. Получить информацию об оценках Пети по физике по четвертям:
-- текущая успеваемость 
-- оценка в следущей четверти
-- оценка в предыдущей четверти

SELECT 
	name,quartal,subject,grade,
	#LEAD(grade) OVER(ORDER BY quartal) AS last_grade
	LEAD(grade,1,'нет оценки') OVER(ORDER BY quartal) AS 'оценка в следущей четверти', -- смещение на 1 и вместо NULL строка
	LAG(grade,1,'нет оценки') OVER(ORDER BY quartal) AS 'оценка в предыдущей четверти' 
FROM academic_record
WHERE name = 'Петя' AND subject = 'физика';


-- -------------------------------------------TEMPORARY TABLE, CTE, VIEW--------------------------------------
# получение друзей пользователя с id = 1 из базы  sem_4

SELECT initiator_user_id AS friend_id FROM sem_4.friend_requests 
WHERE target_user_id = 1 AND status ='approved' -- id друзей, заявку которых подтвердили
UNION 
SELECT target_user_id FROM sem_4.friend_requests 
WHERE initiator_user_id = 1 AND status = 'approved'; -- id друзей, под

-- Временная таблица
DROP TABLE IF EXISTS tbl_friends;
CREATE TEMPORARY TABLE tbl_friends
SELECT initiator_user_id AS user_id,target_user_id AS friend_id FROM sem_4.friend_requests 
WHERE status = 'approved'
UNION 
SELECT target_user_id,initiator_user_id FROM sem_4.friend_requests 
WHERE status = 'approved';

SELECT friend_id FROM tbl_friends
WHERE user_id =1;

-- Общее табличное выражение
WITH friends AS 
(SELECT initiator_user_id AS user_id,target_user_id AS friend_id FROM sem_4.friend_requests 
WHERE status = 'approved'
UNION 
SELECT target_user_id,initiator_user_id FROM sem_4.friend_requests 
WHERE status = 'approved'
)
SELECT friend_id FROM tbl_friends
WHERE user_id =1;

-- С помощью СТЕ реализуйте таблицу квадратов чисел от 1 до 10
WITH RECURSIVE cte AS
(
	SELECT 1 AS a, 1 AS result
	UNION ALL
	SELECT a + 1, pow(a+1,2) AS RESULT FROM cte 
	WHERE a < 10
)
SELECT a, result FROM cte;

-- ---------------------------Представления----------------------

CREATE OR REPLACE VIEW v_friends AS
(SELECT initiator_user_id AS user_id,target_user_id AS friend_id FROM sem_4.friend_requests 
WHERE status = 'approved'
UNION 
SELECT target_user_id,initiator_user_id FROM sem_4.friend_requests 
WHERE status = 'approved');

SELECT friend_id FROM v_friends 
WHERE user_id = 1;