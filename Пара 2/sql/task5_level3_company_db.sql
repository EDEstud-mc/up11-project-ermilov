-- Пара 2. Задание 5, Уровень 3 (повышенный)
-- Ермилов Д.Е., вариант 27 «Парфюмерия»

-- Задание 3.1. Создайте БД company_db
DROP DATABASE IF EXISTS company_db;
CREATE DATABASE company_db;
\c company_db

-- Задание 3.2. Создайте 2 таблицы
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary NUMERIC(10,2) CHECK (salary > 0),
    department_id INTEGER REFERENCES departments(id)
);

-- Задание 3.3. Вставьте данные
INSERT INTO departments (name) VALUES ('IT'), ('HR');

INSERT INTO employees (name, salary, department_id) VALUES
('Иванов', 80000, (SELECT id FROM departments WHERE name = 'IT')),
('Петров', 90000, (SELECT id FROM departments WHERE name = 'IT')),
('Сидорова', 70000, (SELECT id FROM departments WHERE name = 'HR'));

-- Задание 3.4. Выполните запросы
SELECT * FROM employees;                                -- 1. Все сотрудники
SELECT * FROM employees WHERE salary > 80000;           -- 2. Зарплата > 80000
SELECT * FROM employees ORDER BY salary DESC;           -- 3. Сортировка по зарплате (убыв.)
SELECT e.* FROM employees e
JOIN departments d ON d.id = e.department_id
WHERE d.name = 'IT';                                    -- 4. Сотрудники отдела IT
SELECT ROUND(AVG(salary), 2) AS avg_salary FROM employees;  -- 5. Средняя зарплата

-- Задание 3.5. Обновите и удалите
UPDATE employees SET salary = salary + 5000 WHERE name = 'Иванов';  -- 1. Повысить Иванову на 5000
DELETE FROM employees WHERE name = 'Сидорова';                       -- 2. Удалить Сидорову
SELECT * FROM employees ORDER BY id;
