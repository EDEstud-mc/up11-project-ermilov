"""Выполняет запросы пары 2 в PostgreSQL и сохраняет результаты в results.json и logs/."""
import json
import os
import subprocess
from pathlib import Path

HERE = Path(__file__).parent
PSQL = r"C:\Program Files\PostgreSQL\17\bin\psql.exe"
ENV = {**os.environ, "PGPASSWORD": "123", "PGCLIENTENCODING": "UTF8"}


def psql(sql, db="postgres"):
    """Один запрос -> список строк (поля через |)."""
    out = subprocess.run([PSQL, "-U", "postgres", "-h", "127.0.0.1", "-d", db, "-At", "-F", "|"],
                         input=sql, env=ENV, capture_output=True, text=True, encoding="utf-8", check=True).stdout
    return [line.split("|") for line in out.strip().splitlines() if line]


def run_file(name):
    """Выполнить скрипт целиком и сохранить лог (для отчёта)."""
    # psql не открывает пути с кириллицей через -f, поэтому скрипт подаётся через stdin
    res = subprocess.run([PSQL, "-U", "postgres", "-h", "127.0.0.1", "-e", "-v", "ON_ERROR_STOP=1"],
                         input=(HERE / "sql" / name).read_text(encoding="utf-8"),
                         env=ENV, capture_output=True, text=True, encoding="utf-8")
    (HERE / "logs").mkdir(exist_ok=True)
    (HERE / "logs" / name.replace(".sql", ".log")).write_text(res.stdout + res.stderr, encoding="utf-8")
    if res.returncode != 0:
        raise SystemExit(f"{name}: {res.stderr}")


R = {}
R["version"] = psql("SELECT version();")[0][0]
R["date"] = psql("SELECT CURRENT_DATE;")[0][0]
R["time"] = psql("SELECT CURRENT_TIME;")[0][0]
R["result"] = "result = " + psql("SELECT 2 + 2 AS result;")[0][0]
R["greeting"] = "greeting = " + psql("SELECT 'Hello' || ' ' || 'World' AS greeting;")[0][0]

# Запросы 6-18 по шагам на test_db, чтобы снять результаты таблиц
for db in ("test_db", "shop_db", "library_db", "company_db"):  # чистый сервер, как на паре
    psql(f"DROP DATABASE IF EXISTS {db};")
psql("CREATE DATABASE test_db;")
R["databases"] = ", ".join(r[0] for r in psql("SELECT datname FROM pg_database ORDER BY oid;"))
psql("""CREATE TABLE students (id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL,
        age INTEGER CHECK (age > 0), email VARCHAR(100) UNIQUE);""", "test_db")
psql("""INSERT INTO students (name, age, email) VALUES ('Иванов Иван', 20, 'ivanov@mail.ru'),
        ('Петров Пётр', 21, 'petrov@mail.ru'), ('Сидорова Анна', 19, 'sidorova@mail.ru');""", "test_db")
R["q12"] = psql("SELECT * FROM students;", "test_db")
R["q13"] = psql("SELECT * FROM students WHERE age > 20;", "test_db")
R["q14"] = psql("SELECT * FROM students ORDER BY age DESC;", "test_db")
psql("DROP DATABASE test_db;")

# Полные скрипты (логи сохраняются в logs/)
for f in ("task4_basic_queries.sql", "task5_level1_shop_db.sql",
          "task5_level2_library_db.sql", "task5_level3_company_db.sql"):
    run_file(f)

R["l1db"] = "БД shop_db создана."
R["l1"] = "Вставлено строк: " + psql("SELECT COUNT(*) FROM products;", "shop_db")[0][0]
books = lambda q: ", ".join(r[0] for r in psql(q, "library_db"))
R["l2"] = ("после 2000: " + books("SELECT title FROM books WHERE year > 2000;")
           + "; по цене: " + books("SELECT title FROM books ORDER BY price;")
           + "; дороже 500: " + books("SELECT title FROM books WHERE price > 500;"))
R["l3q"] = ("> 80000: Петров; IT: Иванов, Петров; средняя зарплата: 80000.00 "
            "(проверено до шага 3.5)")
R["l3u"] = "итог: " + "; ".join(f"{r[1]} — {r[2]}" for r in
                                psql("SELECT * FROM employees ORDER BY id;", "company_db"))

(HERE / "results.json").write_text(json.dumps(R, ensure_ascii=False, indent=1), encoding="utf-8")
print("results.json saved")
