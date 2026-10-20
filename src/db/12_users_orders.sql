-- Пара 15. Связанные таблицы пользователей и заказов
-- Ермилов Даниил Евгеньевич, вариант 27 «Парфюмерия»
-- Запуск через psql из базы postgres: psql -U postgres -f 12_users_orders.sql

CREATE DATABASE orders_db;
\connect orders_db
SELECT current_database();

-- Задание 1.3. Данные для учебного примера
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE sizes (
    size_id SERIAL PRIMARY KEY,
    value INTEGER NOT NULL UNIQUE CHECK (value > 0)
);
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories(category_id),
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0)
);

-- Задание 1.4
INSERT INTO categories (name) VALUES
('Наручные часы'), ('Спортивные часы'), ('Смарт-часы');
INSERT INTO sizes (value) VALUES (38), (39), (40);
INSERT INTO products (category_id, name, price) VALUES
(1, 'Часы «Классика»', 2190.00),
(2, 'Часы «Спорт»', 2790.00),
(3, 'Смарт-часы', 25000.00);

-- Задание 2.1. Роли
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Задание 2.2
INSERT INTO roles (name) VALUES
('Администратор'), ('Менеджер'), ('Авторизованный пользователь');

-- Задание 2.3. Пользователи
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    login VARCHAR(100) NOT NULL UNIQUE,
    role_id INTEGER REFERENCES roles(role_id)
);

-- Задание 2.4
INSERT INTO users (last_name, first_name, login, role_id) VALUES
('Иванов', 'Иван', 'isivanov', 1),
('Петров', 'Пётр', 'papetrov', 2),
('Сидорова', 'Анна', 'asidorova', 3);

-- Задание 3.1. Заказы
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id INTEGER REFERENCES users(user_id)
);

-- Задание 3.2. Состав заказов
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    size_id INTEGER REFERENCES sizes(size_id),
    quantity INTEGER CHECK (quantity > 0),
    price NUMERIC(10,2) CHECK (price > 0)
);

-- Задание 3.3
INSERT INTO orders (order_date, user_id) VALUES
('2026-04-02', 1), ('2026-04-05', 2);

-- Задание 3.4
INSERT INTO order_items (order_id, product_id, size_id, quantity, price) VALUES
(1, 1, 1, 1, 2190.00),
(1, 2, 2, 1, 2790.00),
(2, 3, 3, 1, 25000.00);

-- Задания 4.1–4.4. Нарушения отклоняются ограничениями
DO $$ BEGIN
    INSERT INTO users (last_name, first_name, login, role_id)
    VALUES ('Проверка', 'Роли', 'bad_role', 999);
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'FK users -> roles: роль 999 не существует';
END $$;
DO $$ BEGIN
    INSERT INTO orders (user_id) VALUES (999);
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'FK orders -> users: пользователь 999 не существует';
END $$;
DO $$ BEGIN
    INSERT INTO order_items (order_id, product_id, size_id, quantity, price)
    VALUES (999, 1, 1, 1, 2190.00);
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'FK order_items -> orders: заказ 999 не существует';
END $$;
DO $$ BEGIN
    INSERT INTO order_items (order_id, product_id, size_id, quantity, price)
    VALUES (1, 1, 1, -5, 2190.00);
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'CHECK order_items: количество -5 отклонено';
END $$;

-- Задание 5.1. Вариант 27 «Парфюмерия»
CREATE SCHEMA perfume15;
CREATE TABLE perfume15.roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE perfume15.users (
    user_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    login VARCHAR(100) NOT NULL UNIQUE,
    role_id INTEGER REFERENCES perfume15.roles(role_id)
);

-- Задание 5.2. Записи из Users_import.xlsx
INSERT INTO perfume15.roles (name) VALUES
('Администратор'), ('Менеджер'), ('Авторизованный пользователь');
INSERT INTO perfume15.users
    (last_name, first_name, middle_name, login, role_id) VALUES
('Иванов', 'Иван', 'Сергеевич', 'admin', 1),
('Петров', 'Пётр', 'Алексеевич', 'manager1', 2),
('Смирнова', 'Ольга', 'Викторовна', 'manager2', 2),
('Сидоров', 'Алексей', 'Иванович', 'client01', 3),
('Кузнецова', 'Анна', 'Ивановна', 'client02', 3);

-- Задание 5.3. Справочники для ссылок, затем заказы и их строки
CREATE TABLE perfume15.products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    manufacturer VARCHAR(100) NOT NULL
);
CREATE TABLE perfume15.variants (
    variant_id SERIAL PRIMARY KEY,
    volume_ml INTEGER NOT NULL UNIQUE CHECK (volume_ml > 0)
);
INSERT INTO perfume15.products (name, manufacturer) VALUES
('Жасминовый сад', 'АромаЛайн'),
('Роза утром', 'Нота'),
('Пион', 'ПарфюмДом');
INSERT INTO perfume15.variants (volume_ml) VALUES (30), (50), (100);
CREATE TABLE perfume15.orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id INTEGER REFERENCES perfume15.users(user_id)
);
CREATE TABLE perfume15.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES perfume15.orders(order_id),
    product_id INTEGER REFERENCES perfume15.products(product_id),
    variant_id INTEGER REFERENCES perfume15.variants(variant_id),
    quantity INTEGER CHECK (quantity > 0),
    price NUMERIC(10,2) CHECK (price > 0)
);

-- Задание 5.4. Первые два заказа из Orders_import.xlsx
INSERT INTO perfume15.orders (order_date, user_id) VALUES
('2026-04-04', 4), ('2026-04-06', 5);
INSERT INTO perfume15.order_items
    (order_id, product_id, variant_id, quantity, price) VALUES
(1, 1, 1, 2, 2490.00),
(1, 2, 2, 1, 3550.00),
(2, 3, 1, 1, 3190.00);

-- Задание 6.1. Базовый уровень
CREATE SCHEMA level1_15;
CREATE TABLE level1_15.roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Задание 6.2. Средний уровень
CREATE SCHEMA level2_15;
CREATE TABLE level2_15.roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE level2_15.users (
    user_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    login VARCHAR(100) NOT NULL UNIQUE,
    role_id INTEGER REFERENCES level2_15.roles(role_id)
);

-- Задание 6.3. Повышенный уровень
CREATE SCHEMA level3_15;
CREATE TABLE level3_15.roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE level3_15.users (
    user_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    login VARCHAR(100) NOT NULL UNIQUE,
    role_id INTEGER REFERENCES level3_15.roles(role_id)
);
CREATE TABLE level3_15.orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id INTEGER REFERENCES level3_15.users(user_id)
);
CREATE TABLE level3_15.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES level3_15.orders(order_id),
    product_id INTEGER REFERENCES public.products(product_id),
    quantity INTEGER CHECK (quantity > 0),
    price NUMERIC(10,2) CHECK (price > 0)
);

-- Задание 7.1. Своя предметная область «Книжный клуб»
CREATE SCHEMA creative15;
CREATE TABLE creative15.books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL
);
CREATE TABLE creative15.roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE creative15.users (
    user_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    login VARCHAR(100) NOT NULL UNIQUE,
    role_id INTEGER REFERENCES creative15.roles(role_id)
);
CREATE TABLE creative15.orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id INTEGER REFERENCES creative15.users(user_id)
);
CREATE TABLE creative15.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES creative15.orders(order_id),
    book_id INTEGER REFERENCES creative15.books(book_id),
    quantity INTEGER CHECK (quantity > 0),
    price NUMERIC(10,2) CHECK (price > 0)
);

SELECT 'roles' AS table_name, COUNT(*) FROM roles
UNION ALL SELECT 'users', COUNT(*) FROM users
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items;
