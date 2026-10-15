-- Пара 5. Типы данных: INTEGER, VARCHAR, DATE, NUMERIC, BOOLEAN
-- Ермилов Даниил Евгеньевич, вариант 27 «Парфюмерия»
-- Запуск: psql -U postgres < 04_data_types.sql

-- Задание 1.1
CREATE DATABASE types_db;

-- Задание 1.2
\c types_db

-- Задание 2.1
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INTEGER,
    course INTEGER
);

-- Задание 2.2
INSERT INTO students (name, age, course) VALUES
('Иванов Иван', 20, 2),
('Петров Пётр', 21, 3),
('Сидорова Анна', 19, 1);

-- Задание 3.1
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT
);

-- Задание 3.2
INSERT INTO clients (name, email, phone, address) VALUES
('Иванов Иван', 'ivanov@mail.ru', '+7 900 111-11-11', 'г. Москва, ул. Тверская, д. 1, кв. 10'),
('Петрова Мария', 'petrova@mail.ru', '+7 900 222-22-22', 'г. Санкт-Петербург, Невский пр., д. 25'),
('Сидоров Олег', 'sidorov@mail.ru', '+7 900 333-33-33', 'г. Казань, ул. Баумана, д. 7');

-- Задание 4.1
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE,
    delivery_date DATE,
    status VARCHAR(20) DEFAULT 'новый'
);

-- Задание 4.2
INSERT INTO orders (order_date, delivery_date, status) VALUES
('2026-10-10', '2026-10-14', 'доставлен'),
('2026-10-12', '2026-10-16', 'в пути'),
(DEFAULT, '2026-10-18', DEFAULT);

-- Задание 5.1
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0),
    quantity INTEGER CHECK (quantity >= 0)
);

-- Задание 5.2
INSERT INTO products (name, price, quantity) VALUES
('Chanel No 5, 50 мл', 14500.00, 12),
('Dior Sauvage, 100 мл', 12900.50, 8),
('Lancome La Vie Est Belle, 75 мл', 11200.99, 5);

-- Задание 6.1
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    login VARCHAR(50) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    is_admin BOOLEAN DEFAULT FALSE
);

-- Задание 6.2
INSERT INTO users (login, is_active, is_admin) VALUES
('admin', TRUE, TRUE),
('ivanov', DEFAULT, DEFAULT),
('petrova', FALSE, FALSE);

-- Задание 7.1
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    year INTEGER CHECK (year > 1900),
    price NUMERIC(10,2) CHECK (price > 0),
    publish_date DATE,
    is_available BOOLEAN DEFAULT TRUE
);

-- Задание 7.2
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    salary NUMERIC(10,2) CHECK (salary > 0),
    hire_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Задание 7.3
CREATE TABLE articles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    views INTEGER DEFAULT 0,
    rating NUMERIC(3,1) CHECK (rating >= 0 AND rating <= 5),
    publish_date DATE,
    is_published BOOLEAN DEFAULT FALSE
);

-- Задание 8.1.1
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Задание 8.1.2
CREATE TABLE statuses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Задание 8.2.1
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    number VARCHAR(50) UNIQUE NOT NULL,
    invoice_date DATE DEFAULT CURRENT_DATE,
    amount NUMERIC(10,2) CHECK (amount > 0),
    is_paid BOOLEAN DEFAULT FALSE
);

-- Задание 8.2.2
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    priority INTEGER CHECK (priority BETWEEN 1 AND 5),
    due_date DATE,
    is_completed BOOLEAN DEFAULT FALSE
);

-- Задание 8.3.1
DROP TABLE IF EXISTS orders;

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_date DATE DEFAULT CURRENT_DATE,
    total NUMERIC(10,2) CHECK (total >= 0),
    is_paid BOOLEAN DEFAULT FALSE
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    product_name VARCHAR(100) NOT NULL,
    quantity INTEGER CHECK (quantity > 0),
    price NUMERIC(10,2) CHECK (price > 0)
);

-- Задание 8.3.2
INSERT INTO customers (name, email) VALUES
('Иванов Иван', 'ivanov@mail.ru'),
('Петрова Мария', 'petrova@mail.ru'),
('Сидоров Олег', 'sidorov@mail.ru');

INSERT INTO orders (customer_id, total, is_paid) VALUES
(1, 27400.00, TRUE),
(2, 11200.00, FALSE),
(3, 9800.00, TRUE);

INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
(1, 'Chanel No 5, 50 мл', 1, 14500.00),
(1, 'Dior Sauvage, 100 мл', 1, 12900.00),
(2, 'Lancome La Vie Est Belle, 75 мл', 1, 11200.00),
(3, 'Hugo Boss Bottled, 50 мл', 1, 9800.00);

-- Задание 8.3.3 (проверка: ожидается ошибка)
-- INSERT INTO orders (customer_id, order_date, total, is_paid)
-- VALUES (1, 'вчера', 'сто рублей', 'может быть');

-- Задание 9.1
CREATE TABLE brands (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50),
    founded_year INTEGER CHECK (founded_year > 1800),
    is_premium BOOLEAN DEFAULT FALSE
);

CREATE TABLE perfumes (
    id SERIAL PRIMARY KEY,
    brand_id INTEGER REFERENCES brands(id),
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    volume_ml INTEGER CHECK (volume_ml > 0),
    price NUMERIC(10,2) CHECK (price > 0),
    release_date DATE,
    in_stock BOOLEAN DEFAULT TRUE
);

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    perfume_id INTEGER REFERENCES perfumes(id),
    buyer_name VARCHAR(100) NOT NULL,
    quantity INTEGER CHECK (quantity > 0),
    sale_date DATE DEFAULT CURRENT_DATE,
    total NUMERIC(10,2) CHECK (total >= 0),
    is_paid BOOLEAN DEFAULT FALSE
);
