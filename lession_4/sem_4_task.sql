# Задача 1: выбрать всех пользователей, указав их id, имя и фамилию, город и аватарку

SELECT 
	id,
	CONCAT(firstname,' ',lastname) AS 'Пользователь',-- concat склеивает 2 значения в 1 строчку
	(SELECT hometown FROM profiles WHERE user_id = users.id) AS 'Город',
	(SELECT filename FROM media WHERE id  = 
	(SELECT photo_id FROM profiles WHERE user_id = users.id)) AS'Фотокарточка'
FROM users;

# Задача 2: выбрать фотографии (filename) пользователя с email: arlo50@example.org ID типа медия, соответствующий фотографиям неизвестен 

SELECT user_id , media_type_id , filename FROM media 
WHERE user_id = (SELECT id FROM users WHERE email = 'arlo50@example.org') AND 
media_type_id  IN (SELECT id FROM media_types WHERE name_type LIKE  'Photo');

# Задача 3: выбрать id друзей, пользователя с id =1

-- ID друзей, заявку которых я подтвердил
SELECT initiator_user_id AS id 
FROM friend_requests WHERE target_user_id = 1 AND status = 'approved'
UNION
-- Id друзей, подтвердивших мою заявку 
SELECT target_user_id FROM friend_requests
WHERE initiator_user_id = 1 AND status = 'approved';

-- CROSS JOIN
SELECT * FROM users JOIN messages;

-- INNER JOIN 
SELECT * FROM users u
JOIN messages m
WHERE u.id = m.from_user_id;

SELECT * FROM users u 
JOIN messages m ON u.id = m.from_user_id
WHERE u.id = 1;

-- LEFT JOIN 
SELECT u.*, m.* FROM users u 
LEFT JOIN messages m ON u.id = m.from_user_id;

-- RIGHT JOIN
SELECT u.*, m.* FROM users u 
RIGHT JOIN messages m ON u.id = m.from_user_id;

-- FULL JOIN 

SELECT u.*, m.* FROM users u 
LEFT JOIN messages m ON u.id = m.from_user_id
UNION
SELECT u.*, m.* FROM users u 
RIGHT JOIN messages m ON u.id = m.from_user_id;

# Задача 4: выбрать всех пользователей, указав их id,имя и фамилию, город и аватарку

SELECT 
	u.id,
	u.firstname,
	u.lastname,
	p.hometown AS 'Город',
	m.filename AS 'Фотокарточка'  
FROM users u 
JOIN profiles p ON u.id = p.user_id
LEFT JOIN media m ON p.photo_id = m.id;

# Задача: 5 Список медиафайлов пользователей с количеством лайков 

SELECT
	m.id,
	m.filename AS ' Медиа',
	concat(u.firstname, " ", u.lastname) AS 'Владелец', 
	COUNT(l.id)  AS 'Количество лайков'
FROM media m
LEFT JOIN likes l ON l.media_id = m.id
JOIN users u ON u.id = m.user_id 
GROUP BY m.id
ORDER BY m.id;

# Задача 6: Список медиафайлов пользователей, указав название типа медиа (id,filename,name_type)
SELECT 
	m.user_id,
	m.filename,
	mt.name_type
FROM media m 
LEFT JOIN media_types mt ON mt.id = m.media_type_id 
ORDER BY m.id;







