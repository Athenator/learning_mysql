DROP DATABASE IF EXISTS sem_2;
CREATE DATABASE sem_2;
USE sem_2;

-- фильмы 
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	title VARCHAR(50) NOT NULL,
	title_eng VARCHAR(50),
	year_movie YEAR NOT NULL,
	count_min INT,
	storyline TEXT
);

-- наполнение данными 
INSERT INTO movies (title,title_eng,year_movie,count_min,storyline)
VALUES
('Игры разума', 'A beatifull Mind', 2001,135,'Memento mory'),
('Форрeст Гамп','Forrest Gump',1994,142,'Gelios'),
('Иван Васильевич меняет профессию',NULL,1998,128,'Requesqo'),
('Назад в будущее','Back to future',1985,116,'Steel of requiem'),
('Криминальное чтиво','Pulp Fiction',1994,154,NULL);

-- жанры
CREATE TABLE genres (
	id SERIAL Primary key, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	name VARCHAR(100) NOT NULL
);

CREATE TABLE actors (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	firstname VARCHAR(100) NOT NULL,
	lastname VARCHAR (100) COMMENT 'Фамилия' -- СOMMENT на случай, если имя не очевидноactors
);

-- переименование таблицы
RENAME TABLE movies TO cinema;

-- добавление новых столбцов status_active и genre_id в таблицу 
ALTER TABLE cinema
ADD COLUMN status_active BIT DEFAULT b'1',
ADD genre_id BIGINT UNSIGNED AFTER title_eng;

-- удаление столбца из таблицы
ALTER TABLE cinema
DROP COLUMN status_active;

-- удаление таблицы 
-- DROP TABLE actors;
DROP TABLE IF EXISTS actors;

-- добавление внешнего ключа от поля genre_id таблицы cinema к полю id таблицы 
ALTER TABLE cinema 
ADD FOREIGN KEY(genre_id) REFERENCES genres(id) ON UPDATE CASCADE ON DELETE SET NULL;

-- очистить таблицу от данных, с помощью удаление и возврата ключа 
ALTER TABLE cinema 
DROP FOREIGN KEY cinema_ibfk_1;

TRUNCATE TABLE genres;

ALTER TABLE cinema 
ADD FOREIGN KEY(genre_id) REFERENCES genres(id) ON UPDATE CASCADE ON DELETE SET NULL;

-- добавили поле взрастная категория фильмов 
ALTER TABLE cinema 
ADD COLUMN age_category CHAR(1);

-- присвоение фильмам категорий 
UPDATE cinema SET age_category = 'П' WHERE id =1;
UPDATE cinema SET age_category = 'Д' WHERE id =4;
UPDATE cinema SET age_category = 'В' WHERE id =5;

-- в зависимости от поля age_catgory, выведите столбец с именем Категория Д - детская, П - подростковая, В - взрослая, Ну указана
Select 
	id AS 'Номер фильма',
    title AS 'Название фильма',
    -- можно сделать так WHEN age_category = 'Д' THEN 'Детская'
    CASE age_category
		WHEN'Д' THEN 'Детская'
		WHEN 'П' THEN 'Подростковая'
		WHEN 'В' THEN 'Взрослая'
        ELSE 'Не указана'
	END AS 'Категория',
    age_category
FROM cinema c
WHERE c.id=1 ;    

-- изменение продолжительности фильмов
UPDATE cinema SET count_min = 135 WHERE id=1;
UPDATE cinema SET count_min = 88 WHERE id=2;
UPDATE cinema SET count_min = NULL WHERE id=3;
UPDATE cinema SET count_min = 34 WHERE id=4;
UPDATE cinema SET count_min = 154 WHERE id=5;

Select 
	id AS 'Номер фильма',
    title AS 'Название фильма',
    count_min AS 'Продолжительность',
    CASE 
		WHEN count_min < 50 THEN 'Короткометражный фильм'
		WHEN count_min BETWEEN 50 AND 100 THEN 'Среднеметражный фильм'
		WHEN count_min > 100 THEN 'Полнометражный фильм'
        ELSE 'Не определено'
	END AS 'Тип'
FROM cinema;

-- реализация IF 
SELECT IF(1300<200, 'Да', 'Нет') AS Result;

Select 
	id AS 'Номер фильма',
    title AS 'Название фильма',
    count_min AS 'Продолжительность',
    IF(count_min < 50,'Короткометражный фильм',
		IF(count_min BETWEEN 50 AND 100, 'Среднеметражный фильм',
			IF(count_min > 100,'Полнометражный фильм','Не определено')
        )
    ) AS 'Тип'
FROM cinema;
