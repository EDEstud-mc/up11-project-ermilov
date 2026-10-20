-- Пара 17. Импорт связанных данных
-- Ермилов Даниил Евгеньевич, вариант 27 «Парфюмерия»
-- Запуск после 13_import_1.sql в базе import_db

\connect import_db

-- Подготовка таблиц и исходных справочников
DROP SCHEMA IF EXISTS perfume17 CASCADE;
CREATE SCHEMA perfume17;
CREATE TABLE perfume17.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE perfume17.variants (variant_id SERIAL PRIMARY KEY, volume_ml INTEGER NOT NULL UNIQUE CHECK (volume_ml > 0));
CREATE TABLE perfume17.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE perfume17.users (
    user_id SERIAL PRIMARY KEY, last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL, middle_name VARCHAR(100),
    login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES perfume17.roles(role_id)
);
CREATE TABLE perfume17.products (
    product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES perfume17.categories(category_id),
    name VARCHAR(200) NOT NULL, manufacturer VARCHAR(100) NOT NULL, UNIQUE(name, manufacturer)
);
CREATE TABLE perfume17.stock_items (
    stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES perfume17.products(product_id),
    variant_id INTEGER NOT NULL REFERENCES perfume17.variants(variant_id),
    quantity INTEGER NOT NULL CHECK (quantity >= 0), price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    UNIQUE(product_id, variant_id)
);
CREATE TABLE perfume17.orders (
    order_id INTEGER PRIMARY KEY, order_date DATE NOT NULL,
    user_id INTEGER NOT NULL REFERENCES perfume17.users(user_id)
);
CREATE TABLE perfume17.order_items (
    order_item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES perfume17.orders(order_id),
    product_id INTEGER NOT NULL REFERENCES perfume17.products(product_id),
    variant_id INTEGER NOT NULL REFERENCES perfume17.variants(variant_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0), price NUMERIC(10,2) NOT NULL CHECK (price > 0)
);
INSERT INTO perfume17.categories (name) VALUES
('Парфюмерная вода'),
('Туалетная вода'),
('Одеколоны'),
('Парфюмерные спреи');
INSERT INTO perfume17.variants (volume_ml) VALUES
(30),
(50),
(100);
INSERT INTO perfume17.roles (name) VALUES
('Администратор'),
('Менеджер'),
('Авторизованный пользователь');
INSERT INTO perfume17.users (last_name, first_name, middle_name, login, role_id) VALUES
('Иванов', 'Иван', 'Сергеевич', 'admin', 1),
('Петров', 'Пётр', 'Алексеевич', 'manager1', 2),
('Смирнова', 'Ольга', 'Викторовна', 'manager2', 2),
('Сидоров', 'Алексей', 'Иванович', 'client01', 3),
('Кузнецова', 'Анна', 'Ивановна', 'client02', 3),
('Орлов', 'Алексей', 'Иванович', 'client03', 3),
('Новикова', 'Анна', 'Ивановна', 'client04', 3),
('Морозов', 'Алексей', 'Иванович', 'client05', 3),
('Волкова', 'Анна', 'Ивановна', 'client06', 3),
('Соколов', 'Алексей', 'Иванович', 'client07', 3),
('Лебедева', 'Анна', 'Ивановна', 'client08', 3),
('Попов', 'Алексей', 'Иванович', 'client09', 3),
('Егорова', 'Анна', 'Ивановна', 'client10', 3),
('Зайцев', 'Алексей', 'Иванович', 'client11', 3),
('Павлова', 'Анна', 'Ивановна', 'client12', 3),
('Семёнов', 'Алексей', 'Иванович', 'client13', 3),
('Фёдорова', 'Анна', 'Ивановна', 'client14', 3),
('Козлов', 'Алексей', 'Иванович', 'client15', 3),
('Макарова', 'Анна', 'Ивановна', 'client16', 3),
('Белов', 'Алексей', 'Иванович', 'client17', 3);
INSERT INTO perfume17.products (category_id, name, manufacturer) VALUES
(1, 'Жасминовый сад', 'АромаЛайн'),
(1, 'Роза утром', 'Нота'),
(1, 'Пион', 'ПарфюмДом'),
(1, 'Белая лилия', 'Композиция'),
(1, 'Фиалка', 'АромаЛайн'),
(1, 'Сирень', 'Нота'),
(1, 'Цветочный вечер', 'ПарфюмДом'),
(1, 'Лепесток', 'Композиция'),
(2, 'Морской бриз', 'АромаЛайн'),
(2, 'Зелёный лист', 'Нота'),
(2, 'Утренний воздух', 'ПарфюмДом'),
(2, 'Цитрус', 'Композиция'),
(2, 'Лимонный свет', 'АромаЛайн'),
(2, 'Чистая линия', 'Нота'),
(2, 'Ветер', 'ПарфюмДом'),
(2, 'Прохлада', 'Композиция'),
(3, 'Бергамот', 'АромаЛайн'),
(3, 'Лайм', 'Нота'),
(3, 'Апельсин', 'ПарфюмДом'),
(3, 'Грейпфрут', 'Композиция'),
(3, 'Лимон', 'АромаЛайн'),
(3, 'Мандарин', 'Нота'),
(3, 'Нероли', 'ПарфюмДом'),
(3, 'Свежий цитрус', 'Композиция'),
(4, 'Лёгкий цветок', 'АромаЛайн'),
(4, 'Тёплая ваниль', 'Нота'),
(4, 'Ягодная нота', 'ПарфюмДом'),
(4, 'Свежий лист', 'Композиция'),
(4, 'Мягкий цитрус', 'АромаЛайн'),
(4, 'Солнечный день', 'Нота'),
(4, 'Тихий вечер', 'ПарфюмДом');

-- Задание 1.1
SELECT 'categories' AS table_name, COUNT(*) FROM perfume17.categories
UNION ALL SELECT 'variants', COUNT(*) FROM perfume17.variants
UNION ALL SELECT 'users', COUNT(*) FROM perfume17.users;

-- Задание 1.2
SELECT COUNT(*) AS products_count FROM perfume17.products;
SELECT product_id, name, manufacturer FROM perfume17.products ORDER BY product_id LIMIT 5;

-- Задание 2.3
SELECT column_name, data_type FROM information_schema.columns WHERE table_schema='perfume17' AND table_name='stock_items' ORDER BY ordinal_position;

-- Задание 2.4
INSERT INTO perfume17.stock_items (product_id, variant_id, quantity, price) VALUES
(1, 1, 11, 2490),
(1, 2, 16, 3112.5),
(1, 3, 21, 3735),
(2, 1, 14, 2840),
(2, 2, 19, 3550),
(2, 3, 24, 4260),
(3, 1, 17, 3190),
(3, 2, 22, 3987.5),
(3, 3, 27, 4785),
(4, 1, 20, 3540),
(4, 2, 25, 4425),
(4, 3, 6, 5310),
(5, 1, 23, 3890),
(5, 2, 28, 4862.5),
(5, 3, 9, 5835),
(6, 1, 26, 4240),
(6, 2, 7, 5300),
(6, 3, 12, 6360),
(7, 1, 5, 4590),
(7, 2, 10, 5737.5),
(7, 3, 15, 6885),
(8, 1, 8, 4940),
(8, 2, 13, 6175),
(8, 3, 18, 7410),
(9, 1, 11, 1490),
(9, 2, 16, 1862.5),
(9, 3, 21, 2235),
(10, 1, 14, 1740),
(10, 2, 19, 2175),
(10, 3, 24, 2610),
(11, 1, 17, 1990),
(11, 2, 22, 2487.5),
(11, 3, 27, 2985),
(12, 1, 20, 2240),
(12, 2, 25, 2800),
(12, 3, 6, 3360),
(13, 1, 23, 2490),
(13, 2, 28, 3112.5),
(13, 3, 9, 3735),
(14, 1, 26, 2740),
(14, 2, 7, 3425),
(14, 3, 12, 4110),
(15, 1, 5, 2990),
(15, 2, 10, 3737.5),
(15, 3, 15, 4485),
(16, 1, 8, 3240),
(16, 2, 13, 4050),
(16, 3, 18, 4860),
(17, 1, 11, 990),
(17, 2, 16, 1237.5),
(17, 3, 21, 1485),
(18, 1, 14, 1170),
(18, 2, 19, 1462.5),
(18, 3, 24, 1755),
(19, 1, 17, 1350),
(19, 2, 22, 1687.5),
(19, 3, 27, 2025),
(20, 1, 20, 1530),
(20, 2, 25, 1912.5),
(20, 3, 6, 2295),
(21, 1, 23, 1710),
(21, 2, 28, 2137.5),
(21, 3, 9, 2565),
(22, 1, 26, 1890),
(22, 2, 7, 2362.5),
(22, 3, 12, 2835),
(23, 1, 5, 2070),
(23, 2, 10, 2587.5),
(23, 3, 15, 3105),
(24, 1, 8, 2250),
(24, 2, 13, 2812.5),
(24, 3, 18, 3375),
(25, 1, 11, 690),
(25, 2, 16, 862.5),
(25, 3, 21, 1035),
(26, 1, 14, 840),
(26, 2, 19, 1050),
(26, 3, 24, 1260),
(27, 1, 17, 990),
(27, 2, 22, 1237.5),
(27, 3, 27, 1485),
(28, 1, 2, 1140),
(28, 2, 1, 1425),
(28, 3, 1, 1710),
(29, 1, 1, 1290),
(29, 2, 1, 1612.5),
(29, 3, 1, 1935),
(30, 1, 1, 1440),
(30, 2, 0, 1800),
(30, 3, 1, 2160),
(31, 1, 0, 1590),
(31, 2, 0, 1987.5),
(31, 3, 0, 2385);

-- Задание 2.5
SELECT COUNT(*) AS stock_items_count FROM perfume17.stock_items;

-- Задание 3.3
SELECT order_id, order_date, user_id FROM (VALUES
    (1, '2026-04-04', 4),
    (2, '2026-04-06', 5),
    (3, '2026-04-08', 6),
    (4, '2026-04-10', 7),
    (5, '2026-04-12', 8),
    (6, '2026-04-14', 9),
    (7, '2026-04-16', 10),
    (8, '2026-04-18', 11),
    (9, '2026-04-20', 12),
    (10, '2026-04-22', 13),
    (11, '2026-04-24', 14),
    (12, '2026-04-26', 15),
    (13, '2026-04-28', 16),
    (14, '2026-04-30', 17),
    (15, '2026-05-02', 18)) AS prepared(order_id, order_date, user_id) ORDER BY order_id;

-- Задание 3.4
INSERT INTO perfume17.orders (order_id, order_date, user_id) VALUES
(1, '2026-04-04', 4),
(2, '2026-04-06', 5),
(3, '2026-04-08', 6),
(4, '2026-04-10', 7),
(5, '2026-04-12', 8),
(6, '2026-04-14', 9),
(7, '2026-04-16', 10),
(8, '2026-04-18', 11),
(9, '2026-04-20', 12),
(10, '2026-04-22', 13),
(11, '2026-04-24', 14),
(12, '2026-04-26', 15),
(13, '2026-04-28', 16),
(14, '2026-04-30', 17),
(15, '2026-05-02', 18);

-- Задание 3.5
INSERT INTO perfume17.order_items (order_id, product_id, variant_id, quantity, price) VALUES
(1, 1, 1, 2, 2490),
(1, 2, 2, 1, 3550),
(2, 3, 1, 1, 3190),
(2, 4, 2, 2, 4425),
(3, 5, 1, 2, 3790),
(3, 6, 2, 1, 5200),
(4, 7, 1, 1, 4590),
(4, 8, 2, 2, 6175),
(5, 9, 1, 2, 1490),
(5, 10, 2, 1, 2175),
(6, 11, 1, 1, 1990),
(6, 12, 2, 2, 2800),
(7, 13, 1, 2, 2490),
(7, 14, 2, 1, 3425),
(8, 15, 1, 1, 2990),
(8, 16, 2, 2, 4050),
(9, 17, 1, 2, 990),
(9, 18, 2, 1, 1462.5),
(10, 19, 1, 1, 1350),
(10, 20, 2, 2, 1912.5),
(11, 21, 1, 2, 1710),
(11, 22, 2, 1, 2362.5),
(12, 23, 1, 1, 2070),
(12, 24, 2, 2, 2812.5),
(13, 25, 1, 2, 690),
(13, 26, 2, 1, 1050),
(14, 27, 1, 1, 990),
(14, 1, 2, 2, 3112.5),
(15, 2, 1, 2, 2840),
(15, 3, 2, 1, 3987.5);

-- Задание 3.6
SELECT 'orders' AS table_name, COUNT(*) FROM perfume17.orders
UNION ALL SELECT 'order_items', COUNT(*) FROM perfume17.order_items;

-- Задание 4.1
SELECT COUNT(*) AS missing_products FROM perfume17.stock_items s LEFT JOIN perfume17.products p ON p.product_id=s.product_id WHERE p.product_id IS NULL;

-- Задание 4.2
SELECT COUNT(*) AS missing_variants FROM perfume17.stock_items s LEFT JOIN perfume17.variants v ON v.variant_id=s.variant_id WHERE v.variant_id IS NULL;

-- Задание 4.3
SELECT COUNT(*) AS missing_users FROM perfume17.orders o LEFT JOIN perfume17.users u ON u.user_id=o.user_id WHERE u.user_id IS NULL;

-- Задание 4.4
SELECT COUNT(*) AS missing_orders FROM perfume17.order_items i LEFT JOIN perfume17.orders o ON o.order_id=i.order_id WHERE o.order_id IS NULL;

-- Задание 5.1
SELECT 'stock_items' AS table_name, COUNT(*) FROM perfume17.stock_items
UNION ALL SELECT 'orders', COUNT(*) FROM perfume17.orders
UNION ALL SELECT 'order_items', COUNT(*) FROM perfume17.order_items;

-- Задание 5.2
SELECT COUNT(*) AS broken_links FROM (
    SELECT s.stock_item_id FROM perfume17.stock_items s LEFT JOIN perfume17.products p ON p.product_id=s.product_id LEFT JOIN perfume17.variants v ON v.variant_id=s.variant_id WHERE p.product_id IS NULL OR v.variant_id IS NULL
    UNION ALL SELECT o.order_id FROM perfume17.orders o LEFT JOIN perfume17.users u ON u.user_id=o.user_id WHERE u.user_id IS NULL
    UNION ALL SELECT i.order_item_id FROM perfume17.order_items i LEFT JOIN perfume17.orders o ON o.order_id=i.order_id LEFT JOIN perfume17.products p ON p.product_id=i.product_id LEFT JOIN perfume17.variants v ON v.variant_id=i.variant_id WHERE o.order_id IS NULL OR p.product_id IS NULL OR v.variant_id IS NULL
) AS errors;
