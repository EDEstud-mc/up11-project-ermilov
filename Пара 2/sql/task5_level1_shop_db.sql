-- Пара 2. Задание 5, Уровень 1 (базовый)
-- Ермилов Д.Е., вариант 27 «Парфюмерия»

-- Задание 1.1. Создайте БД shop_db
DROP DATABASE IF EXISTS shop_db;
CREATE DATABASE shop_db;
\c shop_db

-- Задание 1.2. Создайте таблицу products
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0)
);

-- Задание 1.3. Вставьте 3 товара
INSERT INTO products (name, price) VALUES
('Chanel No 5, 50 мл', 14500.00),
('Dior Sauvage, 100 мл', 12900.00),
('Lancome La Vie Est Belle, 75 мл', 11200.00);

SELECT * FROM products;
