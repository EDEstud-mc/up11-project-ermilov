-- Домашнее задание к паре 17. Импорт связанных данных для трёх тем
-- Ермилов Даниил Евгеньевич
-- Запуск в базе import_db

\connect import_db

-- Мир часов
DROP SCHEMA IF EXISTS watch17 CASCADE;
CREATE SCHEMA watch17;
CREATE TABLE watch17.products (product_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL);
CREATE TABLE watch17.variants (variant_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL);
CREATE TABLE watch17.users (user_id SERIAL PRIMARY KEY, full_name VARCHAR(150) NOT NULL);
CREATE TABLE watch17.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER REFERENCES watch17.products, variant_id INTEGER REFERENCES watch17.variants, quantity INTEGER CHECK (quantity >= 0));
CREATE TABLE watch17.orders (order_id SERIAL PRIMARY KEY, order_date DATE NOT NULL, user_id INTEGER REFERENCES watch17.users);
CREATE TABLE watch17.order_items (order_item_id SERIAL PRIMARY KEY, order_id INTEGER REFERENCES watch17.orders, product_id INTEGER REFERENCES watch17.products, variant_id INTEGER REFERENCES watch17.variants, quantity INTEGER CHECK (quantity > 0));
INSERT INTO watch17.products (name) VALUES ('Часы Классика'), ('Часы Спорт');
INSERT INTO watch17.variants (name) VALUES ('38 мм'), ('42 мм');
INSERT INTO watch17.users (full_name) VALUES ('Иванов Иван'), ('Петров Пётр');
INSERT INTO watch17.stock_items (product_id, variant_id, quantity) VALUES (1, 1, 8), (2, 2, 5);
INSERT INTO watch17.orders (order_date, user_id) VALUES ('2026-10-18', 1), ('2026-10-19', 2);
INSERT INTO watch17.order_items (order_id, product_id, variant_id, quantity) VALUES (1, 1, 1, 1), (2, 2, 2, 1);

-- Книжный мир
DROP SCHEMA IF EXISTS book17 CASCADE;
CREATE SCHEMA book17;
CREATE TABLE book17.products (product_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL);
CREATE TABLE book17.variants (variant_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL);
CREATE TABLE book17.users (user_id SERIAL PRIMARY KEY, full_name VARCHAR(150) NOT NULL);
CREATE TABLE book17.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER REFERENCES book17.products, variant_id INTEGER REFERENCES book17.variants, quantity INTEGER CHECK (quantity >= 0));
CREATE TABLE book17.orders (order_id SERIAL PRIMARY KEY, order_date DATE NOT NULL, user_id INTEGER REFERENCES book17.users);
CREATE TABLE book17.order_items (order_item_id SERIAL PRIMARY KEY, order_id INTEGER REFERENCES book17.orders, product_id INTEGER REFERENCES book17.products, variant_id INTEGER REFERENCES book17.variants, quantity INTEGER CHECK (quantity > 0));
INSERT INTO book17.products (name) VALUES ('Рассказы'), ('Энциклопедия');
INSERT INTO book17.variants (name) VALUES ('Твёрдый переплёт'), ('Мягкий переплёт');
INSERT INTO book17.users (full_name) VALUES ('Смирнова Ольга'), ('Сидоров Алексей');
INSERT INTO book17.stock_items (product_id, variant_id, quantity) VALUES (1, 1, 12), (2, 2, 7);
INSERT INTO book17.orders (order_date, user_id) VALUES ('2026-10-18', 1), ('2026-10-19', 2);
INSERT INTO book17.order_items (order_id, product_id, variant_id, quantity) VALUES (1, 1, 1, 1), (2, 2, 2, 2);

-- ТехноМир
DROP SCHEMA IF EXISTS tech17 CASCADE;
CREATE SCHEMA tech17;
CREATE TABLE tech17.products (product_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL);
CREATE TABLE tech17.variants (variant_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL);
CREATE TABLE tech17.users (user_id SERIAL PRIMARY KEY, full_name VARCHAR(150) NOT NULL);
CREATE TABLE tech17.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER REFERENCES tech17.products, variant_id INTEGER REFERENCES tech17.variants, quantity INTEGER CHECK (quantity >= 0));
CREATE TABLE tech17.orders (order_id SERIAL PRIMARY KEY, order_date DATE NOT NULL, user_id INTEGER REFERENCES tech17.users);
CREATE TABLE tech17.order_items (order_item_id SERIAL PRIMARY KEY, order_id INTEGER REFERENCES tech17.orders, product_id INTEGER REFERENCES tech17.products, variant_id INTEGER REFERENCES tech17.variants, quantity INTEGER CHECK (quantity > 0));
INSERT INTO tech17.products (name) VALUES ('Смартфон А1'), ('Ноутбук В2');
INSERT INTO tech17.variants (name) VALUES ('Чёрный'), ('Серебряный');
INSERT INTO tech17.users (full_name) VALUES ('Кузнецова Анна'), ('Орлов Алексей');
INSERT INTO tech17.stock_items (product_id, variant_id, quantity) VALUES (1, 1, 9), (2, 2, 4);
INSERT INTO tech17.orders (order_date, user_id) VALUES ('2026-10-18', 1), ('2026-10-19', 2);
INSERT INTO tech17.order_items (order_id, product_id, variant_id, quantity) VALUES (1, 1, 1, 1), (2, 2, 2, 1);

-- Проверка количества и связей
SELECT 'Мир часов' AS theme, (SELECT COUNT(*) FROM watch17.stock_items) AS stock_items,
    (SELECT COUNT(*) FROM watch17.orders) AS orders, (SELECT COUNT(*) FROM watch17.order_items) AS order_items
UNION ALL SELECT 'Книжный мир', (SELECT COUNT(*) FROM book17.stock_items), (SELECT COUNT(*) FROM book17.orders), (SELECT COUNT(*) FROM book17.order_items)
UNION ALL SELECT 'ТехноМир', (SELECT COUNT(*) FROM tech17.stock_items), (SELECT COUNT(*) FROM tech17.orders), (SELECT COUNT(*) FROM tech17.order_items);

SELECT 'Мир часов' AS theme, COUNT(*) AS broken_links FROM watch17.order_items i LEFT JOIN watch17.orders o ON o.order_id=i.order_id WHERE o.order_id IS NULL
UNION ALL SELECT 'Книжный мир', COUNT(*) FROM book17.order_items i LEFT JOIN book17.orders o ON o.order_id=i.order_id WHERE o.order_id IS NULL
UNION ALL SELECT 'ТехноМир', COUNT(*) FROM tech17.order_items i LEFT JOIN tech17.orders o ON o.order_id=i.order_id WHERE o.order_id IS NULL;
