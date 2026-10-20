-- Полный скрипт базы данных «Мир часов».
\connect postgres
DROP DATABASE IF EXISTS mir_chasov WITH (FORCE);
CREATE DATABASE mir_chasov;
\connect mir_chasov

CREATE TABLE categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE sizes (size_id SERIAL PRIMARY KEY, value NUMERIC(4,1) NOT NULL UNIQUE CHECK (value > 0));
CREATE TABLE products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK (price > 0));
CREATE TABLE stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES products, size_id INTEGER NOT NULL REFERENCES sizes, quantity INTEGER CHECK (quantity >= 0));
CREATE TABLE roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES roles);
CREATE TABLE orders (order_id SERIAL PRIMARY KEY, order_date DATE NOT NULL DEFAULT CURRENT_DATE, user_id INTEGER NOT NULL REFERENCES users);
CREATE TABLE order_items (order_item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES orders, product_id INTEGER NOT NULL REFERENCES products, size_id INTEGER NOT NULL REFERENCES sizes, quantity INTEGER CHECK (quantity > 0), price NUMERIC(10,2) CHECK (price > 0));

INSERT INTO categories(name) VALUES ('Наручные'),('Аксессуары'),('Настенные');
INSERT INTO sizes(value) VALUES (38),(42),(46);
INSERT INTO products(category_id,name,price) VALUES (1,'Часы «Классика»',15000),(2,'Браслет',5000),(3,'Будильник',12000);
INSERT INTO stock_items(product_id,size_id,quantity) VALUES (1,1,8),(2,2,12),(3,3,5);
INSERT INTO roles(name) VALUES ('client'),('manager');
INSERT INTO users(login,role_id) VALUES ('client1',1),('manager1',2);
INSERT INTO orders(order_date,user_id) VALUES ('2026-10-19',1),('2026-10-20',1);
INSERT INTO order_items(order_id,product_id,size_id,quantity,price) VALUES (1,1,1,1,15000),(1,2,2,1,5000),(2,3,3,1,12000);

SELECT 'categories' AS table_name, COUNT(*) FROM categories
UNION ALL SELECT 'sizes',COUNT(*) FROM sizes
UNION ALL SELECT 'products',COUNT(*) FROM products
UNION ALL SELECT 'stock_items',COUNT(*) FROM stock_items
UNION ALL SELECT 'users',COUNT(*) FROM users
UNION ALL SELECT 'orders',COUNT(*) FROM orders
UNION ALL SELECT 'order_items',COUNT(*) FROM order_items;
