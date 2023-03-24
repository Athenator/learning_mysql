
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
