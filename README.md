# УП.11 «Разработка, администрирование и защита баз данных»

**Студент:** Ермилов Даниил Евгеньевич, группа 3ИП-1-24
**Вариант 27:** Разработка базы данных и приложения «Парфюмерия» для автоматизации продаж
**СУБД:** PostgreSQL 17 + pgAdmin 4

## Структура
- `RT/` — заполненные рабочие тетради по парам (docx)
- `workbooks/` — рабочие тетради в формате Markdown
- `src/db/` — SQL-скрипты
- `docs/` — документация проекта (анализ предметной области и др.)
- `screenshots/` — скриншоты выполнения заданий по парам

## Выполненные пары

| Пара | Тема | Рабочая тетрадь |
|---|---|---|
| 1 | Инструктаж по ТБ. Выдача вариантов. Ознакомление с КИМ | — |
| 2 | Установка СУБД PostgreSQL/MySQL. Настройка pgAdmin/MySQL Workbench | [РТ пара 2](RT/) |
| 3 | Первый SQL-запрос. SELECT, WHERE, ORDER BY | [РТ пара 3](RT/) |
| 4 | CREATE TABLE. PRIMARY KEY, NOT NULL, UNIQUE, DEFAULT | [РТ пара 4](RT/) |
| 5 | Типы данных: INTEGER, VARCHAR, DATE, NUMERIC, BOOLEAN | [РТ пара 5](RT/), [md](workbooks/rabochaya-tetrad-para-05.md), [SQL](src/db/04_data_types.sql) |
| 6 | Анализ предметной области. Выделение сущностей и атрибутов | [РТ пара 6](RT/), [md](workbooks/rabochaya-tetrad-para-06.md), [анализ](docs/05_analysis.md) |
| 7 | Нормализация до 3НФ. Устранение транзитивных зависимостей | [РТ пара 7](RT/), [md](workbooks/rabochaya-tetrad-para-07.md), [SQL](src/db/06_normalization.sql) |
| 8 | Упражнение 1.4: анализ схем данных (6 вариантов) | [РТ пара 8](RT/), [md](workbooks/rabochaya-tetrad-para-08.md), [анализ](docs/07_analysis_schemas.md) |
| 9 | Построение ER-диаграммы в Draw.io. Обозначение PK и FK | [РТ пара 9](RT/), [md](workbooks/rabochaya-tetrad-para-09.md), [ERD .drawio](docs/ERD_mir_chasov.drawio), [ERD .pdf](docs/ERD_mir_chasov.pdf), [ERD «Парфюмерия»](docs/ERD_parfumeriya.drawio) |
| 10 | Сохранение ER-диаграммы в PDF. Проверка ключей и связей | [РТ пара 10](RT/), [md](workbooks/rabochaya-tetrad-para-10.md), [ERD .pdf](docs/ERD_mir_chasov.pdf), [ERD «Парфюмерия» .pdf](docs/ERD_parfumeriya.pdf) |
| 11 | Создание справочников: categories, sizes. CHECK-ограничения | [РТ пара 11](RT/), [md](workbooks/rabochaya-tetrad-para-11.md), [SQL](src/db/08_dictionaries.sql) |
| 12 | Создание таблицы товаров products. CHECK на цену > 0 | [РТ пара 12](RT/), [md](workbooks/rabochaya-tetrad-para-12.md), [SQL](src/db/09_products.sql) |
| 13 | Создание таблицы остатков stock_items. CHECK на количество ≥ 0 | [РТ пара 13](RT/), [md](workbooks/rabochaya-tetrad-para-13.md), [SQL](src/db/10_stock_items.sql), [ДЗ](src/db/homework_13.sql) |
