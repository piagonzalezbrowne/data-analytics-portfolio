# Proyecto 02 · Análisis de Plataforma E-commerce

## Descripción

Análisis de datos de una plataforma de comercio electrónico con foco en comportamiento de usuarios, volumen de órdenes y actividad por fecha. El dataset simula un entorno de negocio real con tablas relacionadas entre sí mediante claves foráneas.

El proyecto pone énfasis en técnicas avanzadas de análisis temporal: construcción de series de tiempo continuas con **date spine** y manejo de valores nulos con `COALESCE`, dos patrones muy comunes en contextos de BI y Data Warehousing.

## Dataset

| Tabla | Descripción |
|-------|-------------|
| `users` | Usuarios registrados con timestamp de creación |
| `items` | Catálogo de productos |
| `orders` | Órdenes de compra por usuario |
| `line_items` | Ítems incluidos en cada orden |
| `events` | Eventos de comportamiento (views, clicks, etc.) |
| `item_field_history` | Historial de cambios en campos de productos |
| `dates` | Tabla de fechas continua (date spine) |

**Esquema relacional simplificado:**
```
users (user_id PK)
    ↓
orders (order_id PK, user_id FK)
    ↓
line_items (line_item_id PK, order_id FK, item_id FK)
    ↑
items (item_id PK)

events (event_id PK, user_id FK)
dates  (date)  ← tabla de fechas para series de tiempo
```

## Herramientas

- **SQLite** — motor de base de datos
- **DBeaver** — cliente SQL
- **Python / pandas / Google Colab** — conversión de Excel a CSV y corrección de fechas almacenadas como fórmulas (`data_only=True`, `strftime('%Y-%m-%d')`)

## Conceptos SQL demostrados

- `GROUP BY` con `COUNT`, `SUM`, `AVG`
- `CASE WHEN` para segmentación condicional
- `LEFT JOIN` con tabla de fechas para series de tiempo completas
- `COALESCE` para reemplazar NULLs por valores por defecto
- Filtros de rango en fechas
- Subqueries para comparar valores con agregados
- `DISTINCT` y análisis de cobertura de datos

## Queries

| Archivo | Contenido |
|---------|-----------|
| `01_setup.sql` | Creación del esquema con FK constraints |
| `02_exploratory.sql` | Exploración inicial: conteos, rangos, primeros registros |
| `03_aggregations.sql` | Métricas de negocio: órdenes por día, usuarios activos, segmentación |
| `04_date_spine.sql` | Series de tiempo completas con LEFT JOIN + COALESCE |
| `05_subqueries.sql` | Análisis con subqueries: usuarios sobre promedio, comparaciones |

## Patrón destacado: Date Spine

Una **date spine** (o backbone table) es una tabla con fechas continuas sin gaps. Al hacer `LEFT JOIN` con ella, garantizamos que aparezcan todas las fechas del rango en el resultado, incluso las que no tienen datos, mostrando 0 en vez de ausencia:

```sql
SELECT
    d.date,
    COALESCE(COUNT(o.order_id), 0) AS ordenes
FROM dates d
LEFT JOIN orders o ON DATE(o.created_at) = d.date
WHERE d.date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY d.date
ORDER BY d.date;
```

Este patrón es fundamental en dashboards de BI donde se necesitan series de tiempo sin interrupciones.
