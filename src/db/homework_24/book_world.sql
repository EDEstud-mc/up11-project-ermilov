-- Полный скрипт учебной темы
DROP SCHEMA IF EXISTS book24 CASCADE;
CREATE SCHEMA book24;
CREATE TABLE book24.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE book24.sizes (size_id SERIAL PRIMARY KEY, value VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE book24.products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES book24.categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK(price>0));
CREATE TABLE book24.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES book24.products, size_id INTEGER NOT NULL REFERENCES book24.sizes, quantity INTEGER CHECK(quantity>=0));
CREATE TABLE book24.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE book24.users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES book24.roles);
CREATE TABLE book24.orders (order_id SERIAL PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES book24.users, order_date DATE DEFAULT CURRENT_DATE);
CREATE TABLE book24.order_items (item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES book24.orders, product_id INTEGER NOT NULL REFERENCES book24.products, size_id INTEGER NOT NULL REFERENCES book24.sizes, quantity INTEGER CHECK(quantity>0), price NUMERIC(10,2) CHECK(price>0));
INSERT INTO book24.categories(name) VALUES ('Роман');
INSERT INTO book24.sizes(value) VALUES ('Твёрдый переплёт');
INSERT INTO book24.products(category_id,name,price) VALUES (1,'Книга',900);
INSERT INTO book24.stock_items(product_id,size_id,quantity) VALUES (1,1,5);
INSERT INTO book24.roles(name) VALUES ('client');
INSERT INTO book24.users(login,role_id) VALUES ('book_user',1);
INSERT INTO book24.orders(user_id) VALUES (1);
INSERT INTO book24.order_items(order_id,product_id,size_id,quantity,price) VALUES (1,1,1,1,900);
