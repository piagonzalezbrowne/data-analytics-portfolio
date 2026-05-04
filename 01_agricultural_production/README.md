# Proyecto 01 · Producción Agrícola por Estado (EE.UU.)

## Descripción

Análisis de datos de producción agrícola en Estados Unidos, con foco en productos lácteos (leche, queso, yogurt), miel, huevos y café. El dataset contiene registros históricos por estado y período, permitiendo comparaciones geográficas y temporales entre commodities.

Este proyecto incluye el pipeline completo: creación del esquema relacional, limpieza de datos con Python/pandas y análisis con SQL.

## Dataset

| Tabla | Descripción | Filas aprox. |
|-------|-------------|--------------|
| `state_lookup` | Catálogo de estados (código + nombre) | 50 |
| `milk_production` | Producción de leche por estado y año | ~2.000 |
| `cheese_production` | Producción de queso por estado y período | ~2.000 |
| `honey_production` | Producción de miel por estado y año | ~1.200 |
| `yogurt_production` | Producción de yogurt por estado y período | ~1.500 |
| `egg_production` | Producción de huevos por estado y año | ~2.000 |
| `coffee_production` | Producción de café por estado y año | ~500 |

**Esquema relacional:**
```
state_lookup (state_ANSI PK)
    ↑
    ├── milk_production.state_ANSI
    ├── cheese_production.state_ANSI
    ├── honey_production.state_ANSI
    ├── yogurt_production.state_ANSI
    ├── egg_production.state_ANSI
    └── coffee_production.state_ANSI
```

## Herramientas

- **SQLite** — motor de base de datos
- **DBeaver** — cliente SQL
- **Python / pandas / Google Colab** — limpieza de datos (los valores numéricos originales incluían comas como separador de miles, e.g. `"208,807,000"`, lo que causaba NULLs en la importación directa)

## Conceptos SQL demostrados

- `CREATE TABLE` con tipos de datos y claves foráneas
- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- `GROUP BY` con funciones de agregación (`SUM`, `AVG`, `COUNT`, `MAX`)
- `JOIN` e `LEFT JOIN` entre múltiples tablas
- Subqueries en `WHERE` con `IN` y `NOT IN`
- Identificación de registros faltantes entre tablas

## Queries

| Archivo | Contenido |
|---------|-----------|
| `01_setup.sql` | Creación del esquema completo |
| `02_basic_queries.sql` | Consultas básicas de exploración y filtrado |
| `03_joins.sql` | Joins entre tablas de producción y catálogo de estados |
| `04_subqueries.sql` | Subqueries para análisis comparativo entre commodities |
