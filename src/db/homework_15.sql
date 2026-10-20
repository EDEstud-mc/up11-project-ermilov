-- Домашнее задание к паре 15. Три темы, связанные таблицы и проверка FK
-- Ермилов Даниил Евгеньевич
-- Запуск после 12_users_orders.sql в базе orders_db

\connect orders_db

-- Мир часов
CREATE SCHEMA watch15;
CREATE TABLE watch15.products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
INSERT INTO watch15.products (name) VALUES
('Классика'), ('Спорт'), ('Хронограф'), ('Электронные'), ('Смарт-часы');
CREATE TABLE watch15.roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE watch15.users (
    user_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    login VARCHAR(100) NOT NULL UNIQUE,
    role_id INTEGER REFERENCES watch15.roles(role_id)
);
CREATE TABLE watch15.orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id INTEGER REFERENCES watch15.users(user_id)
);
CREATE TABLE watch15.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES watch15.orders(order_id),
    product_id INTEGER REFERENCES watch15.products(product_id),
    quantity INTEGER CHECK (quantity > 0),
    price NUMERIC(10,2) CHECK (price > 0)
);
INSERT INTO watch15.roles (name) VALUES
('Администратор'), ('Менеджер'), ('Авторизованный пользователь');
INSERT INTO watch15.users (last_name, first_name, login, role_id) VALUES
('Иванов', 'Иван', 'watch_admin', 1),
('Петров', 'Пётр', 'watch_manager', 2),
('Сидорова', 'Анна', 'watch_client1', 3),
('Кузнецов', 'Олег', 'watch_client2', 3),
('Орлова', 'Мария', 'watch_client3', 3);
INSERT INTO watch15.orders (order_date, user_id) VALUES
('2026-04-02', 1), ('2026-04-03', 2), ('2026-04-04', 3),
('2026-04-05', 4), ('2026-04-06', 5);
INSERT INTO watch15.order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 2190.00), (2, 2, 2, 2790.00), (3, 3, 1, 3590.00),
(4, 4, 1, 1990.00), (5, 5, 1, 25000.00);

-- Книжный мир
CREATE SCHEMA book15;
CREATE TABLE book15.products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
INSERT INTO book15.products (name) VALUES
('Рассказы'), ('Повести'), ('Стихи'), ('Энциклопедия'), ('Атлас');
CREATE TABLE book15.roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE book15.users (
    user_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    login VARCHAR(100) NOT NULL UNIQUE,
    role_id INTEGER REFERENCES book15.roles(role_id)
);
CREATE TABLE book15.orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id INTEGER REFERENCES book15.users(user_id)
);
CREATE TABLE book15.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES book15.orders(order_id),
    product_id INTEGER REFERENCES book15.products(product_id),
    quantity INTEGER CHECK (quantity > 0),
    price NUMERIC(10,2) CHECK (price > 0)
);
INSERT INTO book15.roles (name) VALUES
('Администратор'), ('Менеджер'), ('Авторизованный пользователь');
INSERT INTO book15.users (last_name, first_name, login, role_id) VALUES
('Иванова', 'Елена', 'book_admin', 1),
('Миронов', 'Павел', 'book_manager', 2),
('Орлова', 'Мария', 'book_client1', 3),
('Смирнов', 'Артём', 'book_client2', 3),
('Белова', 'Анна', 'book_client3', 3);
INSERT INTO book15.orders (order_date, user_id) VALUES
('2026-04-02', 1), ('2026-04-03', 2), ('2026-04-04', 3),
('2026-04-05', 4), ('2026-04-06', 5);
INSERT INTO book15.order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 650.00), (2, 2, 1, 780.00), (3, 3, 2, 490.00),
(4, 4, 1, 1650.00), (5, 5, 1, 920.00);

-- ТехноМир
CREATE SCHEMA tech15;
CREATE TABLE tech15.products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
INSERT INTO tech15.products (name) VALUES
('Смартфон'), ('Планшет'), ('Ноутбук'), ('Наушники'), ('Монитор');
CREATE TABLE tech15.roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE tech15.users (
    user_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    login VARCHAR(100) NOT NULL UNIQUE,
    role_id INTEGER REFERENCES tech15.roles(role_id)
);
CREATE TABLE tech15.orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id INTEGER REFERENCES tech15.users(user_id)
);
CREATE TABLE tech15.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES tech15.orders(order_id),
    product_id INTEGER REFERENCES tech15.products(product_id),
    quantity INTEGER CHECK (quantity > 0),
    price NUMERIC(10,2) CHECK (price > 0)
);
INSERT INTO tech15.roles (name) VALUES
('Администратор'), ('Менеджер'), ('Авторизованный пользователь');
INSERT INTO tech15.users (last_name, first_name, login, role_id) VALUES
('Смирнов', 'Игорь', 'tech_admin', 1),
('Петрова', 'Ольга', 'tech_manager', 2),
('Козлов', 'Илья', 'tech_client1', 3),
('Волкова', 'Анна', 'tech_client2', 3),
('Зайцев', 'Марк', 'tech_client3', 3);
INSERT INTO tech15.orders (order_date, user_id) VALUES
('2026-04-02', 1), ('2026-04-03', 2), ('2026-04-04', 3),
('2026-04-05', 4), ('2026-04-06', 5);
INSERT INTO tech15.order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 35000.00), (2, 2, 1, 42000.00), (3, 3, 1, 68000.00),
(4, 4, 2, 7500.00), (5, 5, 1, 26000.00);

-- Проверка трёх внешних ключей в каждой теме
DO $$ BEGIN
    INSERT INTO watch15.users (last_name, first_name, login, role_id)
    VALUES ('Тест', 'Роль', 'watch_bad_role', 999);
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'Мир часов: роль 999 отклонена';
END $$;
DO $$ BEGIN
    INSERT INTO book15.orders (user_id) VALUES (999);
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'Книжный мир: пользователь 999 отклонён';
END $$;
DO $$ BEGIN
    INSERT INTO tech15.order_items (order_id, product_id, quantity, price)
    VALUES (999, 1, 1, 35000.00);
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'ТехноМир: заказ 999 отклонён';
END $$;

SELECT 'Мир часов' AS theme, COUNT(*) AS roles FROM watch15.roles
UNION ALL SELECT 'Книжный мир', COUNT(*) FROM book15.roles
UNION ALL SELECT 'ТехноМир', COUNT(*) FROM tech15.roles;
