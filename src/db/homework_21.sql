-- Домашнее задание к паре 21. Полные скрипты трёх учебных тем.
DROP SCHEMA IF EXISTS watch21 CASCADE;
DROP SCHEMA IF EXISTS book21 CASCADE;
DROP SCHEMA IF EXISTS tech21 CASCADE;
CREATE SCHEMA watch21;
CREATE SCHEMA book21;
CREATE SCHEMA tech21;

CREATE TABLE watch21.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE watch21.sizes (size_id SERIAL PRIMARY KEY, value VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE watch21.products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES watch21.categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK(price>0));
CREATE TABLE watch21.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES watch21.products, size_id INTEGER NOT NULL REFERENCES watch21.sizes, quantity INTEGER CHECK(quantity>=0));
CREATE TABLE watch21.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE watch21.users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES watch21.roles);
CREATE TABLE watch21.orders (order_id SERIAL PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES watch21.users, order_date DATE DEFAULT CURRENT_DATE);
CREATE TABLE watch21.order_items (item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES watch21.orders, product_id INTEGER NOT NULL REFERENCES watch21.products, size_id INTEGER NOT NULL REFERENCES watch21.sizes, quantity INTEGER CHECK(quantity>0), price NUMERIC(10,2) CHECK(price>0));
INSERT INTO watch21.categories(name) VALUES ('Наручные'); INSERT INTO watch21.sizes(value) VALUES ('42 мм'); INSERT INTO watch21.products(category_id,name,price) VALUES (1,'Часы',15000); INSERT INTO watch21.stock_items(product_id,size_id,quantity) VALUES (1,1,5); INSERT INTO watch21.roles(name) VALUES ('client'); INSERT INTO watch21.users(login,role_id) VALUES ('watch_user',1); INSERT INTO watch21.orders(user_id) VALUES (1); INSERT INTO watch21.order_items(order_id,product_id,size_id,quantity,price) VALUES (1,1,1,1,15000);

CREATE TABLE book21.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE book21.sizes (size_id SERIAL PRIMARY KEY, value VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE book21.products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES book21.categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK(price>0));
CREATE TABLE book21.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES book21.products, size_id INTEGER NOT NULL REFERENCES book21.sizes, quantity INTEGER CHECK(quantity>=0));
CREATE TABLE book21.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE book21.users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES book21.roles);
CREATE TABLE book21.orders (order_id SERIAL PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES book21.users, order_date DATE DEFAULT CURRENT_DATE);
CREATE TABLE book21.order_items (item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES book21.orders, product_id INTEGER NOT NULL REFERENCES book21.products, size_id INTEGER NOT NULL REFERENCES book21.sizes, quantity INTEGER CHECK(quantity>0), price NUMERIC(10,2) CHECK(price>0));
INSERT INTO book21.categories(name) VALUES ('Роман'); INSERT INTO book21.sizes(value) VALUES ('Твёрдый переплёт'); INSERT INTO book21.products(category_id,name,price) VALUES (1,'Книга',900); INSERT INTO book21.stock_items(product_id,size_id,quantity) VALUES (1,1,10); INSERT INTO book21.roles(name) VALUES ('client'); INSERT INTO book21.users(login,role_id) VALUES ('book_user',1); INSERT INTO book21.orders(user_id) VALUES (1); INSERT INTO book21.order_items(order_id,product_id,size_id,quantity,price) VALUES (1,1,1,1,900);

CREATE TABLE tech21.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE tech21.sizes (size_id SERIAL PRIMARY KEY, value VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE tech21.products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES tech21.categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK(price>0));
CREATE TABLE tech21.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES tech21.products, size_id INTEGER NOT NULL REFERENCES tech21.sizes, quantity INTEGER CHECK(quantity>=0));
CREATE TABLE tech21.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE tech21.users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES tech21.roles);
CREATE TABLE tech21.orders (order_id SERIAL PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES tech21.users, order_date DATE DEFAULT CURRENT_DATE);
CREATE TABLE tech21.order_items (item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES tech21.orders, product_id INTEGER NOT NULL REFERENCES tech21.products, size_id INTEGER NOT NULL REFERENCES tech21.sizes, quantity INTEGER CHECK(quantity>0), price NUMERIC(10,2) CHECK(price>0));
INSERT INTO tech21.categories(name) VALUES ('Смартфоны'); INSERT INTO tech21.sizes(value) VALUES ('128 ГБ'); INSERT INTO tech21.products(category_id,name,price) VALUES (1,'Смартфон',45000); INSERT INTO tech21.stock_items(product_id,size_id,quantity) VALUES (1,1,7); INSERT INTO tech21.roles(name) VALUES ('client'); INSERT INTO tech21.users(login,role_id) VALUES ('tech_user',1); INSERT INTO tech21.orders(user_id) VALUES (1); INSERT INTO tech21.order_items(order_id,product_id,size_id,quantity,price) VALUES (1,1,1,1,45000);
