-- Домашнее задание к паре 20. Повторение CREATE TABLE для трёх тем.

DROP SCHEMA IF EXISTS watch20 CASCADE;
DROP SCHEMA IF EXISTS book20 CASCADE;
DROP SCHEMA IF EXISTS tech20 CASCADE;
CREATE SCHEMA watch20;
CREATE SCHEMA book20;
CREATE SCHEMA tech20;

CREATE TABLE watch20.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE watch20.sizes (size_id SERIAL PRIMARY KEY, value NUMERIC(4,1) NOT NULL UNIQUE CHECK (value > 0));
CREATE TABLE watch20.products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES watch20.categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK (price > 0));
CREATE TABLE watch20.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES watch20.products, size_id INTEGER NOT NULL REFERENCES watch20.sizes, quantity INTEGER CHECK (quantity >= 0));
CREATE TABLE watch20.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE watch20.users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES watch20.roles);
CREATE TABLE watch20.orders (order_id SERIAL PRIMARY KEY, order_date DATE NOT NULL DEFAULT CURRENT_DATE, user_id INTEGER NOT NULL REFERENCES watch20.users);
CREATE TABLE watch20.order_items (order_item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES watch20.orders, product_id INTEGER NOT NULL REFERENCES watch20.products, size_id INTEGER NOT NULL REFERENCES watch20.sizes, quantity INTEGER CHECK (quantity > 0), price NUMERIC(10,2) CHECK (price > 0));

CREATE TABLE book20.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE book20.sizes (size_id SERIAL PRIMARY KEY, value VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE book20.products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES book20.categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK (price > 0));
CREATE TABLE book20.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES book20.products, size_id INTEGER NOT NULL REFERENCES book20.sizes, quantity INTEGER CHECK (quantity >= 0));
CREATE TABLE book20.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE book20.users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES book20.roles);
CREATE TABLE book20.orders (order_id SERIAL PRIMARY KEY, order_date DATE NOT NULL DEFAULT CURRENT_DATE, user_id INTEGER NOT NULL REFERENCES book20.users);
CREATE TABLE book20.order_items (order_item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES book20.orders, product_id INTEGER NOT NULL REFERENCES book20.products, size_id INTEGER NOT NULL REFERENCES book20.sizes, quantity INTEGER CHECK (quantity > 0), price NUMERIC(10,2) CHECK (price > 0));

CREATE TABLE tech20.categories (category_id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE tech20.sizes (size_id SERIAL PRIMARY KEY, value VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE tech20.products (product_id SERIAL PRIMARY KEY, category_id INTEGER NOT NULL REFERENCES tech20.categories, name VARCHAR(200) NOT NULL, price NUMERIC(10,2) CHECK (price > 0));
CREATE TABLE tech20.stock_items (stock_item_id SERIAL PRIMARY KEY, product_id INTEGER NOT NULL REFERENCES tech20.products, size_id INTEGER NOT NULL REFERENCES tech20.sizes, quantity INTEGER CHECK (quantity >= 0));
CREATE TABLE tech20.roles (role_id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE tech20.users (user_id SERIAL PRIMARY KEY, login VARCHAR(100) NOT NULL UNIQUE, role_id INTEGER NOT NULL REFERENCES tech20.roles);
CREATE TABLE tech20.orders (order_id SERIAL PRIMARY KEY, order_date DATE NOT NULL DEFAULT CURRENT_DATE, user_id INTEGER NOT NULL REFERENCES tech20.users);
CREATE TABLE tech20.order_items (order_item_id SERIAL PRIMARY KEY, order_id INTEGER NOT NULL REFERENCES tech20.orders, product_id INTEGER NOT NULL REFERENCES tech20.products, size_id INTEGER NOT NULL REFERENCES tech20.sizes, quantity INTEGER CHECK (quantity > 0), price NUMERIC(10,2) CHECK (price > 0));
