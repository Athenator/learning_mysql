# Задание 1. Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой
# можно переместить любого(одного) пользователя из таблицы users в таблицу users_old. 
# используя транзакции с выбором commit или rollback

DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old LIKE users;

DELIMITER //

CREATE PROCEDURE move_user_to_old_table (IN user_id INT)
BEGIN
    DECLARE exit HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SELECT 'Ошибка!' as message;
    END;

    START TRANSACTION;
    
    INSERT INTO users_old
    SELECT * FROM users
    WHERE id = user_id
    LIMIT 1;
    
    DELETE FROM users
    WHERE id = user_id
    LIMIT 1;
    
    COMMIT;
    SELECT 'Всё ок!' as message;
END //

DELIMITER ;

CALL move_user_to_old_table(5);

SELECT * FROM users_old;
SELECT * FROM users;

# Задание 2. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости
# от текущего времени суток. с 06:00 до 12:00 функция должна возвращать фразу: 'Доброе утро',
# с 12:00 до 18:00, с 12:00 до 18:00 функция должна возвращать фразу 'добрый день' и с 18:00 до 00:00 - доброй ночи.

DROP FUNCTION IF EXISTS hello;
DELIMITER //

CREATE FUNCTION hello()
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE current_hour INT;
    DECLARE greeting VARCHAR(20);
    SET current_hour = HOUR(NOW());

    IF current_hour >= 6 AND current_hour < 12 THEN
        SET greeting = 'Доброе утро';
    ELSEIF current_hour >= 12 AND current_hour < 18 THEN
        SET greeting = 'Добрый день';
    ELSEIF current_hour >= 18 AND current_hour < 24 THEN
        SET greeting = 'Добрый вечер';
    ELSE
        SET greeting = 'Доброй ночи';
    END IF;

    RETURN greeting;
END //

DELIMITER ;

SELECT hello();

