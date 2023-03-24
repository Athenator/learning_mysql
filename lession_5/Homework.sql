# 1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.
CREATE VIEW young_users AS
SELECT users.firstname, users.lastname, profiles.hometown, profiles.gender
FROM users
JOIN profiles ON users.id = profiles.user_id
WHERE profiles.birthday > DATE_SUB(NOW(), INTERVAL 20 YEAR);

SELECT * FROM young_users;

# 2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователь, 
# указав указать имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге 
# (первое место у пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)

SELECT 
	u.id AS users_id,
	CONCAT (u.firstname,' ', u.lastname) AS name,
	COUNT(m.id) AS message_count, 
	DENSE_RANK() OVER (ORDER BY COUNT(m.id) DESC) 
	AS ranking
FROM users u
JOIN messages m ON u.id = m.from_user_id  
GROUP BY u.id, u.firstname, u.lastname
ORDER BY message_count DESC;

# 3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления 
# (created_at) и найдите разницу дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)
SELECT id, created_at, 
    LEAD(created_at) OVER (ORDER BY created_at) AS next_created_at,
    LEAD(created_at) OVER (ORDER BY created_at) - created_at AS time_diff
FROM messages
ORDER BY created_at ASC;