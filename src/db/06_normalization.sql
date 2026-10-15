-- Пара 7. Нормализация до 3НФ
-- Ермилов Даниил Евгеньевич, вариант 27 «Парфюмерия»
-- Запуск: psql -U postgres < 06_normalization.sql

-- Задание 1.1. Создание БД
CREATE DATABASE normalization_db;

-- Задание 1.2. Подключение к БД
\c normalization_db

-- Задание 2.1. 1НФ
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE client_phones (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients(id),
    phone VARCHAR(20) NOT NULL
);

INSERT INTO clients (name) VALUES ('Иванов'), ('Петров');

INSERT INTO client_phones (client_id, phone) VALUES
(1, '123-45-67'),
(1, '890-12-34'),
(2, '555-55-55');

SELECT c.id, c.name, p.phone
FROM clients c
JOIN client_phones p ON p.client_id = c.id
ORDER BY c.id;

-- Задание 3.1. 2НФ
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE order_items (
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO products VALUES (10, 'Часы'), (20, 'Браслет');
INSERT INTO orders (order_id) VALUES (1), (2);
INSERT INTO order_items VALUES (1, 10, 2), (1, 20, 1), (2, 10, 1);

SELECT oi.order_id, oi.product_id, p.product_name, oi.quantity
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
ORDER BY oi.order_id, oi.product_id;

-- Задание 4.1. 3НФ (категории)
DROP TABLE IF EXISTS order_items, products CASCADE;

CREATE TABLE categories (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category_id INTEGER REFERENCES categories(id)
);

INSERT INTO categories VALUES (10, 'Наручные'), (20, 'Аксессуары'), (30, 'Настенные');
INSERT INTO products VALUES (1, 'Часы', 10), (2, 'Браслет', 20), (3, 'Будильник', 30);

SELECT p.id, p.name, p.category_id, c.name AS category_name
FROM products p
JOIN categories c ON c.id = p.category_id
ORDER BY p.id;

-- Задание 4.2. 3НФ (производители)
DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE manufacturers (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100)
);

CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manufacturer_id INTEGER REFERENCES manufacturers(id)
);

INSERT INTO manufacturers VALUES (1, 'Восток', 'Россия'), (2, 'Casio', 'Япония');
INSERT INTO products VALUES (1, 'Часы', 1), (2, 'Браслет', 2), (3, 'Будильник', 1);

SELECT p.id, p.name, m.name AS manufacturer, m.country
FROM products p
JOIN manufacturers m ON m.id = p.manufacturer_id
ORDER BY p.id;

-- Задание 5.1. Самостоятельная работа: полная нормализация
DROP TABLE IF EXISTS order_items, orders, products, categories, manufacturers, client_phones, clients CASCADE;

CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    client_phone VARCHAR(20)
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE manufacturers (
    manufacturer_id SERIAL PRIMARY KEY,
    manufacturer_name VARCHAR(100) NOT NULL,
    country VARCHAR(100)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INTEGER REFERENCES categories(category_id),
    manufacturer_id INTEGER REFERENCES manufacturers(manufacturer_id),
    price NUMERIC(10,2) CHECK (price > 0)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    client_id INTEGER REFERENCES clients(client_id)
);

CREATE TABLE order_items (
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO clients (client_name, client_phone) VALUES ('Сидорова', '123-45-67'), ('Павлова', '555-55-55');
INSERT INTO categories (category_name) VALUES ('Детская'), ('Женская');
INSERT INTO manufacturers (manufacturer_name, country) VALUES ('Восток', 'Россия'), ('Casio', 'Япония');
INSERT INTO products (product_name, category_id, manufacturer_id, price) VALUES
('Кроссовки', 1, 1, 2190), ('Сандалии', 1, 2, 2790), ('Сапоги', 2, 1, 25000);
INSERT INTO orders (order_date, client_id) VALUES ('2026-04-02', 1), ('2026-04-05', 2);
INSERT INTO order_items VALUES (1, 1, 1), (1, 2, 1), (2, 3, 1);

SELECT o.order_id, o.order_date, c.client_name, c.client_phone, p.product_name,
       cat.category_name AS category, m.manufacturer_name AS manufacturer, m.country,
       p.price, oi.quantity
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN clients c ON c.client_id = o.client_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories cat ON cat.category_id = p.category_id
JOIN manufacturers m ON m.manufacturer_id = p.manufacturer_id
ORDER BY o.order_id, p.product_id;

-- Задание 6.1.1. Уровень 1: 1НФ (увлечения)
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE student_hobbies (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(id),
    hobby VARCHAR(100) NOT NULL
);

INSERT INTO students (name) VALUES ('Иванов'), ('Петров');
INSERT INTO student_hobbies (student_id, hobby) VALUES
(1, 'Футбол'), (1, 'Шахматы'), (2, 'Плавание');

SELECT s.id, s.name, h.hobby
FROM students s
JOIN student_hobbies h ON h.student_id = s.id
ORDER BY s.id, h.id;

-- Задание 6.2.1. Уровень 2: 3НФ (заказы и категории)
CREATE TABLE shop_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE shop_products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INTEGER REFERENCES shop_categories(category_id)
);

CREATE TABLE shop_orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE shop_order_items (
    order_id INTEGER REFERENCES shop_orders(order_id),
    product_id INTEGER REFERENCES shop_products(product_id),
    quantity INTEGER CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO shop_categories (category_name) VALUES ('Наручные'), ('Аксессуары');
INSERT INTO shop_products VALUES (10, 'Часы', 1), (20, 'Браслет', 2);
INSERT INTO shop_orders (order_id) VALUES (1), (2);
INSERT INTO shop_order_items VALUES (1, 10, 2), (1, 20, 1), (2, 10, 1);

SELECT oi.order_id, p.product_id, p.product_name, c.category_name AS category, oi.quantity
FROM shop_order_items oi
JOIN shop_products p ON p.product_id = oi.product_id
JOIN shop_categories c ON c.category_id = p.category_id
ORDER BY oi.order_id, p.product_id;

-- Задание 6.3.1. Уровень 3: 3НФ (заказы, клиенты, производители)
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE makers (
    maker_id SERIAL PRIMARY KEY,
    maker_name VARCHAR(100) NOT NULL,
    country VARCHAR(100)
);

CREATE TABLE goods (
    good_id SERIAL PRIMARY KEY,
    good_name VARCHAR(100) NOT NULL,
    maker_id INTEGER REFERENCES makers(maker_id),
    price NUMERIC(10,2) CHECK (price > 0)
);

CREATE TABLE purchases (
    purchase_id SERIAL PRIMARY KEY,
    purchase_date DATE NOT NULL,
    customer_id INTEGER REFERENCES customers(customer_id)
);

CREATE TABLE purchase_items (
    purchase_id INTEGER REFERENCES purchases(purchase_id),
    good_id INTEGER REFERENCES goods(good_id),
    quantity INTEGER CHECK (quantity > 0),
    PRIMARY KEY (purchase_id, good_id)
);

INSERT INTO customers (customer_name, email, phone) VALUES
('Сидорова', 'sidorova@mail.ru', '123-45-67'),
('Павлова', 'pavlova@mail.ru', '555-55-55');
INSERT INTO makers (maker_name, country) VALUES ('Восток', 'Россия'), ('Casio', 'Япония');
INSERT INTO goods (good_name, maker_id, price) VALUES
('Кроссовки', 1, 2190), ('Сандалии', 2, 2790), ('Сапоги', 1, 25000);
INSERT INTO purchases (purchase_date, customer_id) VALUES ('2026-04-02', 1), ('2026-04-05', 2);
INSERT INTO purchase_items VALUES (1, 1, 1), (1, 2, 1), (2, 3, 1);

SELECT p.purchase_id AS order_id, p.purchase_date AS order_date, c.customer_name AS client_name,
       c.email AS client_email, c.phone AS client_phone, g.good_name AS product_name,
       m.maker_name AS manufacturer, m.country, g.price, pi.quantity
FROM purchase_items pi
JOIN purchases p ON p.purchase_id = pi.purchase_id
JOIN customers c ON c.customer_id = p.customer_id
JOIN goods g ON g.good_id = pi.good_id
JOIN makers m ON m.maker_id = g.maker_id
ORDER BY p.purchase_id, g.good_id;

-- Задание 7.1. Творческий уровень: продажи парфюмерии
CREATE TABLE buyers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE brands (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50)
);

CREATE TABLE perfumes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand_id INTEGER REFERENCES brands(id),
    price NUMERIC(10,2) CHECK (price > 0)
);

CREATE TABLE perfume_sales (
    id SERIAL PRIMARY KEY,
    sale_date DATE DEFAULT CURRENT_DATE,
    buyer_id INTEGER REFERENCES buyers(id),
    perfume_id INTEGER REFERENCES perfumes(id)
);

INSERT INTO buyers (full_name, phone) VALUES
('Иванов Иван', '+7 900 111-11-11'), ('Петрова Мария', '+7 900 222-22-22');
INSERT INTO brands (name, country) VALUES ('Chanel', 'Франция'), ('Hugo Boss', 'Германия');
INSERT INTO perfumes (name, brand_id, price) VALUES ('Chanel No 5', 1, 14500), ('Boss Bottled', 2, 9800);
INSERT INTO perfume_sales (sale_date, buyer_id, perfume_id) VALUES ('2026-10-14', 1, 1), ('2026-10-14', 2, 2);

SELECT s.id AS sale_id, b.full_name AS buyer, b.phone, p.name AS perfume, br.name AS brand, br.country
FROM perfume_sales s
JOIN buyers b ON b.id = s.buyer_id
JOIN perfumes p ON p.id = s.perfume_id
JOIN brands br ON br.id = p.brand_id
ORDER BY s.id;
