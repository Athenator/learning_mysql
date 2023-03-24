/*
PascalCase: MyAwesomeVariable
camelCase: myAwesomevariable
венгерская нотация: tblHugarianNotation, tblPassword
kebab-case: my-awesome-variable

_snake_case,snake_case : my_awesome_variable
UPPER_CASE_SNAKE_CASE

*/

-- создаём базу данных 
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

-- студенты
CREATE TABLE students (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name_student VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    phone_number BIGINT 
);

-- учителя 
CREATE TABLE teachers (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name_teacher VARCHAR(45) NOT NULL,
    post VARCHAR(100)
);

-- курсы 
CREATE TABLE courses (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name_course VARCHAR(100) NOT NULL,
    name_teacher VARCHAR(45),
    name_student VARCHAR (45)
);

-- наполнение
insert into students (name_student,email,phone_number)
values
('Миша','micha@mail.ru',96216114),
('Антон','anton@mail.ru',2516261243);

insert into teachers (name_teacher,post)
values
('Иванов И.И.','Профессор');

insert into courses (name_course,name_teacher,name_student)
values
('БД','Иванов И.И','Миша');

-- показать всех студентов, * - дурной тон, лучше перечислять все поля
-- select * from students;
SELECT id,name_student, email, phone_number FROM students;

-- Получить список всех студентов с именем Антон:
SELECT id,name_student, email, phone_number FROM students
WHERE name_student = 'Антон';

-- Вывести имя и почту из таблицы Студент по всем студентам 
SELECT name_student,email FROM students;

-- Выбрать информацию о студентах, имена которых начинаются с буквы - А.
SELECT id,name_student, email, phone_number
FROM students WHERE name_student LIKE 'А%';
-- чтобы выести имена, которые заканчиваются на букву - А, напишите - LIKE '%A', вывести тех, у кого 4 символа - LIKE '____'

-- создание таблицы для работы через командную строку
DROP TABLE IF EXISTS workers;
CREATE TABLE workers (
id INT NOT NULL ,
name_worker VARCHAR(45),
dept VARCHAR(100) COMMENT 'Подразделение', -- COMMENT на случай, если имя неочевидное,
salary INT,
PRIMARY KEY(id)
);

INSERT INTO workers (id, name_worker, dept, salary)
VALUES
(100, 'AndreyEx', 'Sales', 5000),
(200, 'Boris', 'IT', 5500), 
(300, 'Anna', 'IT', 7000),
(400, 'Anton', 'Marketing', 9500),
(500, 'Dima', 'IT', 6000),
(501, 'Maxs', 'Accounting', NULL);

DROP TABLE IF EXISTS mobile_phones;
CREATE TABLE mobile_phones (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    product_name VARCHAR(45),
    manufacturer VARCHAR(45) COMMENT 'Брэнд, компания',
    product_count INT,
    price INT
);


INSERT INTO mobile_phones (product_name,manufacturer,product_count,price)
VALUES
('iPhone X', 'Apple', 4, 62000),
('iPhone 8', 'Apple', 9, 44000),
('Galaxy S7', 'Samsung', 5, 51000),
('Galaxy S9', 'Samsung', 1, 58000),
('P20 Pro X', 'Huawei', 12, 32000);

SELECT product_name,manufacturer,price 
FROM mobile_phones WHERE product_count > 2;

SELECT id,product_name,manufacturer,product_count,price
FROM mobile_phones WHERE manufacturer = 'Samsung';



