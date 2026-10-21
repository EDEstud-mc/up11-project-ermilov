-- Полный скрипт учебной темы
DROP SCHEMA IF EXISTS watch24 CASCADE;
CREATE SCHEMA watch24;
CREATE TABLE watch24.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE watch24.sizes (size_id SERIAL PRIMARY KEY, value VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE watch24.products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES watch24.categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK(price>0));
CREATE TABLE watch24.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES watch24.products, size_id INTEGER NOT NULL REFERENCES watch24.sizes, quantity INTEGER CHECK(quantity>=0));
CREATE TABLE watch24.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE watch24.users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES watch24.roles);
CREATE TABLE watch24.orders (order_id SERIAL PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES watch24.users, order_date DATE DEFAULT CURRENT_DATE);
CREATE TABLE watch24.order_items (item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES watch24.orders, product_id INTEGER NOT NULL REFERENCES watch24.products, size_id INTEGER NOT NULL REFERENCES watch24.sizes, quantity INTEGER CHECK(quantity>0), price NUMERIC(10,2) CHECK(price>0));
INSERT INTO watch24.categories(name) VALUES ('Наручные');
INSERT INTO watch24.sizes(value) VALUES ('42 мм');
INSERT INTO watch24.products(category_id,name,price) VALUES (1,'Часы',15000);
INSERT INTO watch24.stock_items(product_id,size_id,quantity) VALUES (1,1,5);
INSERT INTO watch24.roles(name) VALUES ('client');
INSERT INTO watch24.users(login,role_id) VALUES ('watch_user',1);
INSERT INTO watch24.orders(user_id) VALUES (1);
INSERT INTO watch24.order_items(order_id,product_id,size_id,quantity,price) VALUES (1,1,1,1,15000);
