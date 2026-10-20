-- Домашнее задание к паре 16. Импорт данных для трёх тем
-- Ермилов Даниил Евгеньевич
-- Запуск после 13_import_1.sql в базе import_db

\connect import_db

-- Мир часов
CREATE SCHEMA watch16;
CREATE TABLE watch16.categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE watch16.sizes (
    size_id SERIAL PRIMARY KEY,
    value INTEGER NOT NULL UNIQUE CHECK (value > 0)
);
CREATE TABLE watch16.products (
    product_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES watch16.categories(category_id),
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0)
);
INSERT INTO watch16.categories (name) VALUES
('Наручные'),
('Спортивные'),
('Смарт-часы'),
('Настенные'),
('Аксессуары');
INSERT INTO watch16.sizes (value) VALUES
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39);
INSERT INTO watch16.products (category_id, name, price) VALUES
(1, 'Классика', 2190),
(1, 'Минимал', 2790),
(2, 'Спорт', 3490),
(2, 'Таймер', 3990),
(3, 'Смарт Лайт', 12990),
(3, 'Смарт Про', 25990),
(4, 'Настенные Круг', 1890),
(4, 'Настенные Квадрат', 2190),
(5, 'Ремешок кожаный', 990),
(5, 'Ремешок тканевый', 690);
-- Книжный мир
CREATE SCHEMA book16;
CREATE TABLE book16.genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE book16.formats (
    format_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE book16.books (
    book_id SERIAL PRIMARY KEY,
    genre_id INTEGER NOT NULL REFERENCES book16.genres(genre_id),
    title VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0)
);
INSERT INTO book16.genres (name) VALUES
('Художественная'),
('Учебная'),
('Детская'),
('Научная'),
('Справочная');
INSERT INTO book16.formats (name) VALUES
('Твёрдый переплёт'),
('Мягкий переплёт'),
('Карманный формат'),
('Иллюстрированное издание'),
('PDF'),
('EPUB'),
('MOBI'),
('Аудиокнига MP3'),
('Аудиокнига FLAC'),
('Крупный шрифт');
INSERT INTO book16.books (genre_id, title, price) VALUES
(1, 'Рассказы', 650),
(1, 'Повести', 780),
(2, 'Алгебра', 590),
(2, 'История', 510),
(3, 'Сказки', 390),
(3, 'Азбука', 450),
(4, 'Космос', 1200),
(4, 'Биология', 990),
(5, 'Энциклопедия', 1650),
(5, 'Атлас', 920);
-- ТехноМир
CREATE SCHEMA tech16;
CREATE TABLE tech16.brands (
    brand_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE tech16.colors (
    color_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE tech16.gadgets (
    gadget_id SERIAL PRIMARY KEY,
    brand_id INTEGER NOT NULL REFERENCES tech16.brands(brand_id),
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0)
);
INSERT INTO tech16.brands (name) VALUES
('Квант'),
('Вектор'),
('Пульс'),
('Орбита'),
('Техно');
INSERT INTO tech16.colors (name) VALUES
('Чёрный'),
('Белый'),
('Серый'),
('Синий'),
('Красный'),
('Зелёный'),
('Золотой'),
('Серебряный'),
('Фиолетовый'),
('Бежевый');
INSERT INTO tech16.gadgets (brand_id, name, price) VALUES
(1, 'Смартфон А1', 35000),
(1, 'Смартфон А2', 42000),
(2, 'Планшет В1', 38000),
(2, 'Ноутбук В2', 68000),
(3, 'Наушники С1', 7500),
(3, 'Колонка С2', 9900),
(4, 'Монитор D1', 26000),
(4, 'Клавиатура D2', 5900),
(5, 'Мышь E1', 2500),
(5, 'Веб-камера E2', 6900);
-- Проверка количества строк
SELECT 'Мир часов' AS theme,
    (SELECT COUNT(*) FROM watch16.categories) AS dictionary_1,
    (SELECT COUNT(*) FROM watch16.sizes) AS dictionary_2,
    (SELECT COUNT(*) FROM watch16.products) AS products
UNION ALL SELECT 'Книжный мир',
    (SELECT COUNT(*) FROM book16.genres),
    (SELECT COUNT(*) FROM book16.formats),
    (SELECT COUNT(*) FROM book16.books)
UNION ALL SELECT 'ТехноМир',
    (SELECT COUNT(*) FROM tech16.brands),
    (SELECT COUNT(*) FROM tech16.colors),
    (SELECT COUNT(*) FROM tech16.gadgets);
