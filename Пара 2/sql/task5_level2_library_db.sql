-- Пара 2. Задание 5, Уровень 2 (средний)
-- Ермилов Д.Е., вариант 27 «Парфюмерия»

-- Задание 2.1. Создайте БД library_db
DROP DATABASE IF EXISTS library_db;
CREATE DATABASE library_db;
\c library_db

-- Задание 2.2. Создайте таблицу books
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    year INTEGER CHECK (year > 1900),
    price NUMERIC(10,2) CHECK (price > 0)
);

-- Задание 2.3. Вставьте 5 книг
INSERT INTO books (title, author, year, price) VALUES
('Парфюмер. История одного убийцы', 'Патрик Зюскинд', 1985, 450.00),
('Мастер и Маргарита', 'Михаил Булгаков', 1967, 520.00),
('Гарри Поттер и философский камень', 'Джоан Роулинг', 1997, 780.00),
('Код да Винчи', 'Дэн Браун', 2003, 610.00),
('Марсианин', 'Энди Вейер', 2011, 490.00);

-- Задание 2.4. Выполните запросы
SELECT * FROM books;                        -- 1. Все книги
SELECT * FROM books WHERE year > 2000;      -- 2. Книги после 2000 года
SELECT * FROM books ORDER BY price;         -- 3. Сортировка по цене
SELECT * FROM books WHERE price > 500;      -- 4. Книги дороже 500 руб.
