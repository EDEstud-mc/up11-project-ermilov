# Проверка импорта данных

Студент: Ермилов Даниил Евгеньевич  
Группа: 3ИП-1-24  
Вариант 27: «Парфюмерия»

| Таблица варианта | Исходный файл | В Excel | В БД | Совпадает |
|---|---|---:|---:|---|
| categories | Products_import.xlsx, уникальные категории | 4 | 4 | Да |
| variants (sizes в общем шаблоне) | Variants_import.xlsx | 3 | 3 | Да |
| products | Products_import.xlsx | 31 | 31 | Да |
| stock_items | Stock_Items_import.xlsx | 93 | 93 | Да |
| users | Users_import.xlsx | 20 | 20 | Да |
| orders | Orders_import.xlsx, уникальные номера | 15 | 15 | Да |
| order_items | Orders_import.xlsx, строки товаров | 30 | 30 | Да |

## Запрос общей проверки

```sql
SELECT 'categories' AS table_name, COUNT(*) FROM perfume17.categories
UNION ALL SELECT 'variants', COUNT(*) FROM perfume17.variants
UNION ALL SELECT 'products', COUNT(*) FROM perfume17.products
UNION ALL SELECT 'stock_items', COUNT(*) FROM perfume17.stock_items
UNION ALL SELECT 'users', COUNT(*) FROM perfume17.users
UNION ALL SELECT 'orders', COUNT(*) FROM perfume17.orders
UNION ALL SELECT 'order_items', COUNT(*) FROM perfume17.order_items;
```

## Проверка связей

```sql
SELECT COUNT(*) AS broken_links FROM (
    SELECT s.stock_item_id
    FROM perfume17.stock_items s
    LEFT JOIN perfume17.products p ON p.product_id = s.product_id
    LEFT JOIN perfume17.variants v ON v.variant_id = s.variant_id
    WHERE p.product_id IS NULL OR v.variant_id IS NULL
    UNION ALL
    SELECT i.order_item_id
    FROM perfume17.order_items i
    LEFT JOIN perfume17.orders o ON o.order_id = i.order_id
    LEFT JOIN perfume17.products p ON p.product_id = i.product_id
    LEFT JOIN perfume17.variants v ON v.variant_id = i.variant_id
    WHERE o.order_id IS NULL OR p.product_id IS NULL OR v.variant_id IS NULL
) AS errors;
```

Результат проверки: количество строк во всех таблицах совпадает с исходными файлами. Нарушенных связей нет.
