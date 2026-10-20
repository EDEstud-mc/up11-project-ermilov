-- Пара 12. Таблица товаров products и ограничения
-- Ермилов Даниил Евгеньевич, вариант 27 «Парфюмерия»
-- Запуск через psql из базы postgres: psql -U postgres -f 09_products.sql

CREATE DATABASE products_db;
\connect products_db
SELECT current_database();

-- Задание 1.3
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
SELECT * FROM categories;

-- Задание 1.4
INSERT INTO categories (name) VALUES
('Наручные часы'), ('Спортивные часы'), ('Смарт-часы');
SELECT * FROM categories ORDER BY category_id;

-- Задание 2.1
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories(category_id),
    name VARCHAR(200) NOT NULL,
    manufacturer VARCHAR(100),
    description TEXT,
    composition TEXT,
    price NUMERIC(10,2) CHECK (price > 0),
    image_path VARCHAR(255)
);
SELECT * FROM products;

-- Задание 2.2
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'products'
ORDER BY ordinal_position;

-- Задание 3.1
INSERT INTO products (category_id, name, manufacturer, price, image_path) VALUES
(1, 'Часы наручные «Классика»', 'Восток', 15000.00, 'watch_1.png'),
(2, 'Часы наручные «Спорт»', 'Casio', 5000.00, 'watch_2.png'),
(3, 'Смарт-часы «Техно»', 'Samsung', 25000.00, 'watch_3.png'),
(1, 'Часы наручные «Восток»', 'Восток', 12000.00, 'watch_4.png'),
(2, 'Часы наручные «Casio»', 'Casio', 7000.00, 'watch_5.png');
SELECT product_id, category_id, name, manufacturer, price FROM products ORDER BY product_id;

-- Задание 3.2
SELECT * FROM products ORDER BY product_id;

-- Задание 4.1
DO $$
BEGIN
    INSERT INTO products (category_id, name, price) VALUES (1, 'Проверка отрицательной цены', -100);
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'CHECK: отрицательная цена отклонена';
END $$;

-- Задание 4.2
DO $$
BEGIN
    INSERT INTO products (category_id, name, price) VALUES (1, 'Проверка нулевой цены', 0);
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'CHECK: нулевая цена отклонена';
END $$;

-- Задание 4.3
INSERT INTO products (category_id, name, price) VALUES (1, 'Часы простые', 100);

-- Задание 5.1
DO $$
BEGIN
    INSERT INTO products (category_id, name, price) VALUES (999, 'Часы без категории', 100);
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'FOREIGN KEY: несуществующая категория отклонена';
END $$;

-- Задание 5.2
INSERT INTO products (category_id, name, price) VALUES (2, 'Часы туристические', 3200);

-- Задание 6.1
CREATE TABLE perfume_categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
INSERT INTO perfume_categories (name) VALUES
('Парфюмерная вода'), ('Туалетная вода'), ('Духи');
CREATE TABLE perfume_products (
    product_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES perfume_categories(category_id),
    name VARCHAR(200) NOT NULL,
    manufacturer VARCHAR(100),
    description TEXT,
    composition TEXT,
    price NUMERIC(10,2) CHECK (price > 0),
    image_path VARCHAR(255)
);
SELECT * FROM perfume_products;

-- Задание 6.2
INSERT INTO perfume_products
(category_id, name, manufacturer, description, composition, price, image_path) VALUES
(1, 'Цветочный день', 'Арома', 'Парфюмерная вода 50 мл', 'роза, жасмин', 1890.00, 'flower_day.png'),
(2, 'Свежий ветер', 'Арома', 'Туалетная вода 100 мл', 'бергамот, мята', 1590.00, 'fresh_wind.png'),
(3, 'Тёплый вечер', 'Эссенция', 'Духи 30 мл', 'ваниль, сандал', 3290.00, 'warm_evening.png'),
(1, 'Весенний сад', 'Эссенция', 'Парфюмерная вода 50 мл', 'пион, мускус', 2490.00, 'spring_garden.png'),
(2, 'Морской бриз', 'Арома', 'Туалетная вода 75 мл', 'цитрус, морские ноты', 1790.00, 'sea_breeze.png');
SELECT product_id, name, manufacturer, price FROM perfume_products ORDER BY product_id;

-- Задание 7.1
CREATE SCHEMA level1;
CREATE TABLE level1.products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0),
    image_path VARCHAR(255)
);
SELECT column_name FROM information_schema.columns
WHERE table_schema = 'level1' AND table_name = 'products'
ORDER BY ordinal_position;

-- Задание 7.2
CREATE SCHEMA level2;
CREATE TABLE level2.products (
    product_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES public.categories(category_id),
    name VARCHAR(200) NOT NULL,
    manufacturer VARCHAR(100),
    price NUMERIC(10,2) CHECK (price > 0),
    image_path VARCHAR(255)
);
SELECT column_name FROM information_schema.columns
WHERE table_schema = 'level2' AND table_name = 'products'
ORDER BY ordinal_position;

-- Задание 7.3
CREATE SCHEMA level3;
CREATE TABLE level3.products (
    product_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES public.categories(category_id),
    name VARCHAR(200) NOT NULL,
    manufacturer VARCHAR(100),
    description TEXT,
    composition TEXT,
    price NUMERIC(10,2) CHECK (price > 0),
    quantity INTEGER CHECK (quantity >= 0),
    image_path VARCHAR(255)
);
SELECT column_name FROM information_schema.columns
WHERE table_schema = 'level3' AND table_name = 'products'
ORDER BY ordinal_position;

-- Задание 8.1
CREATE TABLE flower_products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0),
    stem_count INTEGER CHECK (stem_count > 0)
);
SELECT * FROM flower_products;

-- Домашнее задание 1
CREATE TABLE book_categories (
    category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
INSERT INTO book_categories (name) VALUES ('Художественная'), ('Учебная');
CREATE TABLE book_products (
    product_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES book_categories(category_id),
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0));
INSERT INTO book_products (category_id, name, price) VALUES
(1, 'Рассказы', 350), (1, 'Повести', 420), (2, 'Алгебра', 590),
(2, 'История', 510), (1, 'Стихи', 290);
SELECT * FROM book_products;

-- Домашнее задание 2
CREATE TABLE flower_categories (
    category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
INSERT INTO flower_categories (name) VALUES ('Букеты'), ('Комнатные');
ALTER TABLE flower_products ADD COLUMN category_id INTEGER
REFERENCES flower_categories(category_id);
INSERT INTO flower_products (category_id, name, price, stem_count) VALUES
(1, 'Букет роз', 1800, 7), (1, 'Букет тюльпанов', 950, 9),
(2, 'Орхидея', 2200, 1), (2, 'Фикус', 1450, 1), (1, 'Букет ромашек', 800, 11);
SELECT * FROM flower_products;

-- Домашнее задание 3
CREATE TABLE coffee_categories (
    category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
INSERT INTO coffee_categories (name) VALUES ('Зерновой'), ('Молотый');
CREATE TABLE coffee_products (
    product_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES coffee_categories(category_id),
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0));
INSERT INTO coffee_products (category_id, name, price) VALUES
(1, 'Арабика 250 г', 650), (1, 'Робуста 250 г', 500),
(2, 'Эспрессо 200 г', 590), (2, 'Капучино 200 г', 560), (1, 'Смесь 500 г', 990);
SELECT * FROM coffee_products;

-- Домашнее задание. Проверка ограничений
DO $$
BEGIN
    INSERT INTO book_products (category_id, name, price) VALUES (1, 'Ошибка цены', 0);
EXCEPTION WHEN check_violation THEN RAISE NOTICE 'CHECK: цена 0 отклонена';
END $$;
DO $$
BEGIN
    INSERT INTO coffee_products (category_id, name, price) VALUES (999, 'Ошибка категории', 100);
EXCEPTION WHEN foreign_key_violation THEN RAISE NOTICE 'FK: категория 999 отклонена';
END $$;
SELECT 'books' AS theme, COUNT(*) FROM book_products
UNION ALL SELECT 'flowers', COUNT(*) FROM flower_products
UNION ALL SELECT 'coffee', COUNT(*) FROM coffee_products;
