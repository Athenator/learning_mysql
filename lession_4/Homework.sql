# Подсчитать общее количество лайков, которые получили пользователи младше 12.
SELECT 
	COUNT(l.id) AS 'Количество лайков, у пользователей младше 12'
FROM users u 
JOIN profiles p ON p.user_id = u.id 
JOIN likes l ON l.user_id = p.user_id 
WHERE(YEAR(NOW())-YEAR(p.birthday)) < 12;


#Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT 
	p.gender,
	COUNT(l.id) AS 'Количество лайков'
FROM profiles p
JOIN likes l ON l.user_id = p.user_id
GROUP BY gender;

#Вывести всех пользователей, которые не отправляли сообщения.

SELECT 
	concat(u.firstname, " ", u.lastname) AS 'Пользователи, которые не отпавляли сообщений'
FROM users u 
WHERE NOT EXISTS 
	(SELECT *
	FROM messages m
	WHERE u.id = m.from_user_id);

