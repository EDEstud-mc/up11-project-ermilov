-- Пара 11. Справочники и ограничения
-- Ермилов Даниил Евгеньевич, вариант 27 «Парфюмерия»
-- Запуск через psql из базы postgres: psql -U postgres -f 08_dictionaries.sql

-- Задание 1
CREATE DATABASE dictionaries_db;
\connect dictionaries_db

-- Задание 2. Категории
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    subcategory VARCHAR(100)
);

INSERT INTO categories (name, subcategory) VALUES
('Парфюмерная вода', 'Цветочные'),
('Туалетная вода', 'Цитрусовые'),
('Одеколоны', 'Древесные'),
('Парфюмерные спреи', 'Свежие'),
('Подарочные наборы', 'Ассорти');

-- Проверка UNIQUE: повторное название не добавляется.
DO $$
BEGIN
    INSERT INTO categories (name) VALUES ('Парфюмерная вода');
EXCEPTION WHEN unique_violation THEN
    RAISE NOTICE 'UNIQUE работает: повторная категория отклонена';
END $$;

-- Задание 3. Размеры из учебного примера
CREATE TABLE sizes (
    size_id SERIAL PRIMARY KEY,
    value NUMERIC(4,1) NOT NULL UNIQUE CHECK (value > 0)
);

INSERT INTO sizes (value) VALUES
(18), (19), (20), (21), (22), (23), (24), (25);

DO $$
BEGIN
    INSERT INTO sizes (value) VALUES (-5);
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'CHECK работает: отрицательный размер отклонён';
END $$;

-- Задание 4. Товары
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    category_id INTEGER NOT NULL REFERENCES categories(category_id)
);

DO $$
BEGIN
    INSERT INTO products (name, price, quantity, category_id)
    VALUES ('Проверка цены', -100, 1, 1);
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'CHECK работает: отрицательная цена отклонена';
END $$;

DO $$
BEGIN
    INSERT INTO products (name, price, quantity, category_id)
    VALUES ('Проверка остатка', 100, -5, 1);
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'CHECK работает: отрицательное количество отклонено';
END $$;

INSERT INTO products (name, price, quantity, category_id) VALUES
('Цветочный аромат', 1890.00, 8, 1),
('Свежий аромат', 1590.00, 5, 2);

-- Задание 5. Справочники для темы «Парфюмерия»
CREATE TABLE fragrance_families (
    family_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO fragrance_families (name) VALUES
('Цветочные'), ('Цитрусовые'), ('Древесные'), ('Восточные'), ('Свежие');

CREATE TABLE bottle_volumes (
    volume_id SERIAL PRIMARY KEY,
    volume_ml INTEGER NOT NULL UNIQUE CHECK (volume_ml > 0)
);

INSERT INTO bottle_volumes (volume_ml) VALUES (15), (30), (50), (75), (100);

-- Задание 6. Уровень 1
CREATE TABLE statuses (
    status_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO statuses (name) VALUES ('новый'), ('оплачен'), ('доставлен');

-- Задание 6. Уровень 2
CREATE TABLE colors (
    color_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    code VARCHAR(7) NOT NULL CHECK (code ~ '^#[0-9A-Fa-f]{6}$')
);

INSERT INTO colors (name, code) VALUES
('Белый', '#FFFFFF'),
('Чёрный', '#000000'),
('Розовый', '#FFC0CB'),
('Зелёный', '#008000'),
('Голубой', '#87CEEB');

-- Задание 6. Уровень 3
CREATE TABLE brands (
    brand_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(100) NOT NULL,
    founded_year INTEGER NOT NULL CHECK (founded_year > 1800 AND founded_year <= 2026)
);

CREATE TABLE units (
    unit_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    short_name VARCHAR(10) NOT NULL UNIQUE CHECK (length(short_name) > 0)
);

INSERT INTO brands (name, country, founded_year) VALUES
('Северный аромат', 'Россия', 2015),
('Лёгкий ветер', 'Россия', 2020);

INSERT INTO units (name, short_name) VALUES
('Миллилитр', 'мл'),
('Штука', 'шт.');

-- Задание 7. Творческая тема «Кофейня»
CREATE TABLE coffee_sizes (
    coffee_size_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    volume_ml INTEGER NOT NULL UNIQUE CHECK (volume_ml > 0)
);

CREATE TABLE roast_levels (
    roast_level_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    level_number INTEGER NOT NULL UNIQUE CHECK (level_number BETWEEN 1 AND 5)
);

CREATE TABLE drink_types (
    drink_type_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    caffeine_mg INTEGER NOT NULL CHECK (caffeine_mg >= 0)
);

INSERT INTO coffee_sizes (name, volume_ml) VALUES
('Мини', 100), ('Маленький', 200), ('Средний', 300), ('Большой', 400), ('Макси', 500);
INSERT INTO roast_levels (name, level_number) VALUES
('Очень светлая', 1), ('Светлая', 2), ('Средняя', 3), ('Тёмная', 4), ('Очень тёмная', 5);
INSERT INTO drink_types (name, caffeine_mg) VALUES
('Эспрессо', 60), ('Американо', 80), ('Капучино', 70), ('Латте', 50), ('Без кофеина', 0);

-- Итоговая проверка
SELECT 'categories' AS table_name, COUNT(*) AS rows_count FROM categories
UNION ALL SELECT 'sizes', COUNT(*) FROM sizes
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'fragrance_families', COUNT(*) FROM fragrance_families
UNION ALL SELECT 'bottle_volumes', COUNT(*) FROM bottle_volumes
UNION ALL SELECT 'statuses', COUNT(*) FROM statuses
UNION ALL SELECT 'colors', COUNT(*) FROM colors
UNION ALL SELECT 'brands', COUNT(*) FROM brands
UNION ALL SELECT 'units', COUNT(*) FROM units
UNION ALL SELECT 'coffee_sizes', COUNT(*) FROM coffee_sizes
UNION ALL SELECT 'roast_levels', COUNT(*) FROM roast_levels
UNION ALL SELECT 'drink_types', COUNT(*) FROM drink_types;
