-- Пара 13. Таблица остатков stock_items и ограничения
-- Ермилов Даниил Евгеньевич, вариант 27 «Парфюмерия»
-- Запуск через psql из базы postgres: psql -U postgres -f 10_stock_items.sql

CREATE DATABASE stock_db;
\connect stock_db
SELECT current_database();

-- Задание 1.3
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE sizes (
    size_id SERIAL PRIMARY KEY,
    value INTEGER NOT NULL UNIQUE CHECK (value > 0)
);
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public' AND table_name IN ('categories', 'sizes');

-- Задание 1.4
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories(category_id),
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0)
);
SELECT * FROM products;

-- Задание 1.5
INSERT INTO categories (name) VALUES
('Наручные часы'), ('Спортивные часы'), ('Смарт-часы');
INSERT INTO sizes (value) VALUES (38), (39), (40);
INSERT INTO products (category_id, name, price) VALUES
(1, 'Часы «Классика»', 15000.00),
(2, 'Часы «Спорт»', 5000.00);
SELECT 'categories' AS table_name, COUNT(*) FROM categories
UNION ALL SELECT 'sizes', COUNT(*) FROM sizes
UNION ALL SELECT 'products', COUNT(*) FROM products;

-- Задание 2.1
CREATE TABLE stock_items (
    stock_item_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(product_id),
    size_id INTEGER REFERENCES sizes(size_id),
    quantity INTEGER CHECK (quantity >= 0)
);
SELECT * FROM stock_items;

-- Задание 2.2
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'stock_items'
ORDER BY ordinal_position;

-- Задание 3.1
INSERT INTO stock_items (product_id, size_id, quantity) VALUES
(1, 1, 5), (1, 2, 3), (1, 3, 7), (2, 1, 10), (2, 2, 0);
SELECT * FROM stock_items ORDER BY stock_item_id;

-- Задание 3.2
SELECT * FROM stock_items ORDER BY stock_item_id;

-- Задание 4.1
DO $$
BEGIN
    INSERT INTO stock_items (product_id, size_id, quantity) VALUES (1, 1, -5);
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'CHECK: отрицательное количество отклонено';
END $$;

-- Задание 4.2
INSERT INTO stock_items (product_id, size_id, quantity) VALUES (2, 3, 0);

-- Задание 4.3
INSERT INTO stock_items (product_id, size_id, quantity) VALUES (1, 1, 100);

-- Задание 5.1
DO $$
BEGIN
    INSERT INTO stock_items (product_id, size_id, quantity) VALUES (999, 1, 1);
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'FOREIGN KEY: товар 999 отклонён';
END $$;

-- Задание 5.2
DO $$
BEGIN
    INSERT INTO stock_items (product_id, size_id, quantity) VALUES (1, 999, 1);
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'FOREIGN KEY: размер 999 отклонён';
END $$;

-- Задание 5.3
INSERT INTO stock_items (product_id, size_id, quantity) VALUES (2, 3, 4);

-- Задание 6.1
CREATE TABLE perfume_products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0)
);
CREATE TABLE bottle_volumes (
    size_id SERIAL PRIMARY KEY,
    volume_ml INTEGER NOT NULL UNIQUE CHECK (volume_ml > 0)
);
INSERT INTO perfume_products (name, price) VALUES
('Цветочный день', 1890), ('Свежий ветер', 1590),
('Тёплый вечер', 3290), ('Весенний сад', 2490), ('Морской бриз', 1790);
INSERT INTO bottle_volumes (volume_ml) VALUES (30), (50), (100);
CREATE TABLE perfume_stock_items (
    stock_item_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES perfume_products(product_id),
    size_id INTEGER REFERENCES bottle_volumes(size_id),
    quantity INTEGER CHECK (quantity >= 0)
);
SELECT * FROM perfume_stock_items;

-- Задание 6.2
INSERT INTO perfume_stock_items (product_id, size_id, quantity) VALUES
(1, 2, 8), (2, 3, 5), (3, 1, 4), (4, 2, 0), (5, 3, 6);
SELECT * FROM perfume_stock_items ORDER BY stock_item_id;

-- Задание 6.3
DO $$
BEGIN
    INSERT INTO perfume_stock_items (product_id, size_id, quantity) VALUES (1, 2, -5);
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'CHECK: отрицательный остаток парфюмерии отклонён';
END $$;

-- Задание 7.1
CREATE SCHEMA level1;
CREATE TABLE level1.stock_items (
    stock_item_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES public.products(product_id),
    quantity INTEGER CHECK (quantity >= 0)
);
SELECT column_name FROM information_schema.columns
WHERE table_schema = 'level1' AND table_name = 'stock_items'
ORDER BY ordinal_position;

-- Задание 7.2
CREATE SCHEMA level2;
CREATE TABLE level2.stock_items (
    stock_item_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES public.products(product_id),
    size_id INTEGER REFERENCES public.sizes(size_id),
    quantity INTEGER CHECK (quantity >= 0)
);
SELECT column_name FROM information_schema.columns
WHERE table_schema = 'level2' AND table_name = 'stock_items'
ORDER BY ordinal_position;

-- Задание 7.3
CREATE SCHEMA level3;
CREATE TABLE level3.stock_items (
    stock_item_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES public.products(product_id),
    size_id INTEGER REFERENCES public.sizes(size_id),
    quantity INTEGER CHECK (quantity >= 0),
    reserved INTEGER CHECK (reserved >= 0)
);
SELECT column_name FROM information_schema.columns
WHERE table_schema = 'level3' AND table_name = 'stock_items'
ORDER BY ordinal_position;

-- Задание 8.1
CREATE TABLE board_games (
    game_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
INSERT INTO board_games (name) VALUES ('Шахматы'), ('Лото');
CREATE TABLE game_stock (
    stock_item_id SERIAL PRIMARY KEY,
    game_id INTEGER REFERENCES board_games(game_id),
    quantity INTEGER CHECK (quantity >= 0),
    reserved INTEGER CHECK (reserved >= 0 AND reserved <= quantity)
);
SELECT * FROM game_stock;
