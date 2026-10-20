-- Домашнее задание к паре 13. Три таблицы остатков
-- Ермилов Даниил Евгеньевич
-- Запуск после 10_stock_items.sql из базы postgres

\connect stock_db

-- Мир часов: создание таблицы
CREATE TABLE watches (
    watch_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL);
CREATE TABLE watch_sizes (
    size_id SERIAL PRIMARY KEY, value INTEGER NOT NULL UNIQUE);
INSERT INTO watches (name) VALUES ('Классика'), ('Спорт');
INSERT INTO watch_sizes (value) VALUES (38), (39), (40);
CREATE TABLE watch_stock (
    stock_item_id SERIAL PRIMARY KEY,
    watch_id INTEGER REFERENCES watches(watch_id),
    size_id INTEGER REFERENCES watch_sizes(size_id),
    quantity INTEGER CHECK (quantity >= 0)
);
SELECT * FROM watch_stock;

-- Мир часов: пять остатков
INSERT INTO watch_stock (watch_id, size_id, quantity) VALUES
(1, 1, 5), (1, 2, 3), (1, 3, 7), (2, 1, 10), (2, 2, 0);
SELECT * FROM watch_stock ORDER BY stock_item_id;

-- Книжный мир: создание таблицы
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL);
CREATE TABLE book_formats (
    format_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
INSERT INTO books (name) VALUES ('Рассказы'), ('Повести'), ('Стихи');
INSERT INTO book_formats (name) VALUES ('Твёрдый'), ('Мягкий');
CREATE TABLE book_stock (
    stock_item_id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(book_id),
    format_id INTEGER REFERENCES book_formats(format_id),
    quantity INTEGER CHECK (quantity >= 0)
);
SELECT * FROM book_stock;

-- Книжный мир: пять остатков
INSERT INTO book_stock (book_id, format_id, quantity) VALUES
(1, 1, 10), (1, 2, 5), (2, 1, 8), (2, 2, 3), (3, 1, 0);
SELECT * FROM book_stock ORDER BY stock_item_id;

-- ТехноМир: создание таблицы
CREATE TABLE gadgets (
    gadget_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL);
CREATE TABLE colors (
    color_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
INSERT INTO gadgets (name) VALUES ('Смартфон'), ('Планшет'), ('Наушники');
INSERT INTO colors (name) VALUES ('Чёрный'), ('Белый');
CREATE TABLE gadget_stock (
    stock_item_id SERIAL PRIMARY KEY,
    gadget_id INTEGER REFERENCES gadgets(gadget_id),
    color_id INTEGER REFERENCES colors(color_id),
    quantity INTEGER CHECK (quantity >= 0)
);
SELECT * FROM gadget_stock;

-- ТехноМир: пять остатков
INSERT INTO gadget_stock (gadget_id, color_id, quantity) VALUES
(1, 1, 15), (1, 2, 10), (2, 1, 5), (2, 2, 8), (3, 1, 0);
SELECT * FROM gadget_stock ORDER BY stock_item_id;

-- Проверка CHECK
DO $$
BEGIN
    INSERT INTO watch_stock (watch_id, size_id, quantity) VALUES (1, 1, -5);
EXCEPTION WHEN check_violation THEN RAISE NOTICE 'CHECK watch_stock: -5 отклонено';
END $$;
DO $$
BEGIN
    INSERT INTO book_stock (book_id, format_id, quantity) VALUES (1, 1, -5);
EXCEPTION WHEN check_violation THEN RAISE NOTICE 'CHECK book_stock: -5 отклонено';
END $$;
DO $$
BEGIN
    INSERT INTO gadget_stock (gadget_id, color_id, quantity) VALUES (1, 1, -5);
EXCEPTION WHEN check_violation THEN RAISE NOTICE 'CHECK gadget_stock: -5 отклонено';
END $$;
SELECT 'watch_stock' AS table_name, COUNT(*) FROM watch_stock
UNION ALL SELECT 'book_stock', COUNT(*) FROM book_stock
UNION ALL SELECT 'gadget_stock', COUNT(*) FROM gadget_stock;

-- Проверка FOREIGN KEY
DO $$
BEGIN
    INSERT INTO watch_stock (watch_id, size_id, quantity) VALUES (999, 1, 1);
EXCEPTION WHEN foreign_key_violation THEN RAISE NOTICE 'FK watch_stock: товар 999 отклонён';
END $$;
DO $$
BEGIN
    INSERT INTO book_stock (book_id, format_id, quantity) VALUES (1, 999, 1);
EXCEPTION WHEN foreign_key_violation THEN RAISE NOTICE 'FK book_stock: формат 999 отклонён';
END $$;
DO $$
BEGIN
    INSERT INTO gadget_stock (gadget_id, color_id, quantity) VALUES (999, 1, 1);
EXCEPTION WHEN foreign_key_violation THEN RAISE NOTICE 'FK gadget_stock: товар 999 отклонён';
END $$;
SELECT 'watch_stock' AS table_name, COUNT(*) FROM watch_stock
UNION ALL SELECT 'book_stock', COUNT(*) FROM book_stock
UNION ALL SELECT 'gadget_stock', COUNT(*) FROM gadget_stock;
