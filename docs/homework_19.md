# Домашнее задание к паре 19

Повторение выполнено для трёх учебных тем.

| Тема | Основные сущности | Нормализация | Связи |
|---|---|---|---|
| Мир часов | categories, sizes, products, stock_items, roles, users, orders, order_items | 3НФ | справочники → товары → остатки; users → orders → order_items |
| Книжный мир | genres, formats, books, stock_items, roles, users, orders, order_items | 3НФ | справочники → книги → остатки; users → orders → order_items |
| ТехноМир | brands, colors, gadgets, stock_items, roles, users, orders, order_items | 3НФ | справочники → технику → остатки; users → orders → order_items |

## Подготовка к Мини-ДЭ

- повторён анализ предметной области;
- проверены первичные и внешние ключи;
- повторены 1НФ, 2НФ и 3НФ;
- проверена структура ER-диаграмм;
- подготовлены SQL-скрипты создания и заполнения баз;
- выполнена проверка количества импортированных записей.
