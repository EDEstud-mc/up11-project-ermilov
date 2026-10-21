-- Полный скрипт учебной темы
DROP SCHEMA IF EXISTS tech24 CASCADE;
CREATE SCHEMA tech24;
CREATE TABLE tech24.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE tech24.sizes (size_id SERIAL PRIMARY KEY, value VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE tech24.products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES tech24.categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK(price>0));
CREATE TABLE tech24.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES tech24.products, size_id INTEGER NOT NULL REFERENCES tech24.sizes, quantity INTEGER CHECK(quantity>=0));
CREATE TABLE tech24.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE tech24.users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES tech24.roles);
CREATE TABLE tech24.orders (order_id SERIAL PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES tech24.users, order_date DATE DEFAULT CURRENT_DATE);
CREATE TABLE tech24.order_items (item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES tech24.orders, product_id INTEGER NOT NULL REFERENCES tech24.products, size_id INTEGER NOT NULL REFERENCES tech24.sizes, quantity INTEGER CHECK(quantity>0), price NUMERIC(10,2) CHECK(price>0));
INSERT INTO tech24.categories(name) VALUES ('Смартфоны');
INSERT INTO tech24.sizes(value) VALUES ('128 ГБ');
INSERT INTO tech24.products(category_id,name,price) VALUES (1,'Смартфон',45000);
INSERT INTO tech24.stock_items(product_id,size_id,quantity) VALUES (1,1,5);
INSERT INTO tech24.roles(name) VALUES ('client');
INSERT INTO tech24.users(login,role_id) VALUES ('tech_user',1);
INSERT INTO tech24.orders(user_id) VALUES (1);
INSERT INTO tech24.order_items(order_id,product_id,size_id,quantity,price) VALUES (1,1,1,1,45000);
