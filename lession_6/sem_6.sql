-- Транзакции
START TRANSACTION;
INSERT INTO users(firstname,lastname,email)
VALUES ('Дмитрий','Дмитриев','dima@mail.ru');

-- Опасный способ
-- SET @last_user_id = (SELECT MAX(id) FROM users);
-- SET @last_user_id = (SELECT id FROM users WHERE email = 'dima@mail.ru');
SET @last_user_id = last_insert_id();

INSERT INTO profiles (user_id,hometown,birthday,photo_id)
VALUES (@last_user_id, 'Moscow', '1999-15-15',NULL);

COMMIT;
-- ROLLBACK;

SELECT * FROM users u 
LEFT JOIN profiles p ON u.id = p.user_id 
ORDER BY u.id DESC;

-- sp stored procedure
DROP PROCEDURE IF EXISTS sp_user_add;
DELIMITER //
CREATE PROCEDURE sp_user_add(
firstname varchar(100),lastname varchar(100),email varchar(100),
phone varchar(100),hometown varchar(50), photo_id INT, birthday DATE,
OUT tran_result VARCHAR(100))
BEGIN
	DECLARE `_rollback` BIT DEFAULT b'0';
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);

	DECLARE CONTINUE handler FOR SQLEXCEPTION
	BEGIN
		SET `_rollback` = b'1';	
		GET stacked DIAGNOSTICS CONDITION 1
		code = RETURNED_SQLSTATE,error_string = MESSAGE_TEXT;
	END;

	START TRANSACTION;
		INSERT INTO users(firstname,lastname,email)
		VALUES (firstname,lastname,email);

		INSERT INTO profiles (user_id,hometown,birthday,photo_id)
		VALUES (last_insert_id(),hometown,birthday,photo_id);
	
	IF `_rollback` THEN
		SET tran_result = concat('Ошибка!!: ',code, 'Текст ошибки: ', error_string);
		ROLLBACK;
	ELSE 
		SET tran_result = 'Ок!';
		COMMIT;
	END IF;
END //
DELIMITER ;

CALL sp_user_add('New','User','new_user2@mail.com',9110001122,'Moscow',1,'1998-01-01',@tran_result);
SELECT @tran_result;

SELECT * FROM users u 
LEFT JOIN profiles p ON u.id = p.user_id 
ORDER BY u.id DESC;

-- Задача 1. Создайте процедуру, которая выберет для одного пользователя 5 пользователей в 
-- случайной комбинации, которые удовлетворяют хотя бы одному критерию: 
-- Из одного города. Состоят в одной группе. Друзья друзей.


CALL friendship_offers(1);
SELECT truncate(popular(1),2) * 100 AS `user popularity`;


-- обновляем данные в базе, чтобы появились пользователи из одного города
-- UPDATE profiles 
-- SET hometown = 'Adriannapor'
-- WHERE birthday < '1990-01-01';

ALTER TABLE `profiles`
ADD COLUMN time_update DATETIME ON UPDATE NOW();


-- Обновление таблицы profiles, добавление времени и столбца time_update
DROP PROCEDURE IF EXISTS sp_data_analysis;
DELIMITER //
CREATE PROCEDURE sp_data_analysis(start_date DATE)
BEGIN 
	DECLARE id_max_users INT;
	DECLARE count_find INT;

	SET id_max_users = (SELECT MAX(user_id) FROM profiles);
	WHILE (id_max_users > 0) DO
		BEGIN
			SET count_find = (SELECT COUNT(*) FROM profiles WHERE user_id = id_max_users AND birthday > start_date);
			IF(count_find > 0) THEN 
				UPDATE profiles 
					set birthday = NOW()
				where user_id = id_max_users -1;
		END IF;
		SET id_max_users = id_max_users -1;
	  END;
	 end while;
END //
DELIMITER ;

CALL sp_data_analysis('2000-01-01');

SELECT u.id,u.firstname,u.lastname,p.birthday FROM users u 
inner join profiles p on u.id = p.user_id 
ORDER by u.id DESC;

CALL sp_user_add('Перт','User','new_user6@mail.com',9110001122,'Moscow',1,'2045-01-01',@tran_result);

update profiles 
set birthday = '2030-01-01'
where user_id = 10;
