-- Пара 2. Задание 4: Базовые SQL-запросы (PostgreSQL 17)
-- Студент: Ермилов Даниил Евгеньевич, группа 3ИП-1-24, вариант 27 «Парфюмерия»
-- Запуск: psql -U postgres -f task4_basic_queries.sql

-- Часть 1: Простые запросы
SELECT version();                               -- Запрос 1. Версия СУБД
SELECT CURRENT_DATE;                            -- Запрос 2. Текущая дата
SELECT CURRENT_TIME;                            -- Запрос 3. Текущее время
SELECT 2 + 2 AS result;                         -- Запрос 4. Арифметика
SELECT 'Hello' || ' ' || 'World' AS greeting;   -- Запрос 5. Конкатенация

-- Часть 2: Работа с БД
DROP DATABASE IF EXISTS test_db;
CREATE DATABASE test_db;                        -- Запрос 6. Создание БД
SELECT datname FROM pg_database;                -- Запрос 7. Список БД
\c test_db
-- Запрос 8. Подключение выполнено
\c postgres
DROP DATABASE test_db;                          -- Запрос 9. Удаление БД

-- Часть 3: Работа с таблицами
CREATE DATABASE test_db;                        -- Запрос 10. Создание таблицы
\c test_db

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INTEGER CHECK (age > 0),
    email VARCHAR(100) UNIQUE
);

-- Запрос 11. Вставка данных
INSERT INTO students (name, age, email) VALUES
('Иванов Иван', 20, 'ivanov@mail.ru'),
('Петров Пётр', 21, 'petrov@mail.ru'),
('Сидорова Анна', 19, 'sidorova@mail.ru');

SELECT * FROM students;                                     -- Запрос 12. Выбор всех данных
SELECT * FROM students WHERE age > 20;                      -- Запрос 13. Фильтрация (WHERE)
SELECT * FROM students ORDER BY age DESC;                   -- Запрос 14. Сортировка (ORDER BY)
UPDATE students SET age = 22 WHERE name = 'Иванов Иван';    -- Запрос 15. Обновление (UPDATE)
DELETE FROM students WHERE name = 'Петров Пётр';            -- Запрос 16. Удаление (DELETE)
SELECT * FROM students;
DROP TABLE students;                                        -- Запрос 17. Удаление таблицы

-- Запрос 18. Удаление БД
\c postgres
DROP DATABASE test_db;
