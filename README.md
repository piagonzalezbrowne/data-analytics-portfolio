# SQL Portfolio · Pía González

**Herramientas:** SQLite · DBeaver · Google Colab · Python (pandas)

Repositorio con proyectos de análisis de datos desarrollados en el marco de cursos de SQL (Coursera). Cada proyecto incluye la configuración de la base de datos, scripts de creación de tablas, limpieza de datos y queries de análisis organizadas por complejidad.

---

## Proyectos

### 📦 [01 · Producción Agrícola por Estado (EE.UU.)](./01_agricultural_production/)
Análisis de producción de productos lácteos, miel y café por estado. Incluye joins entre múltiples tablas, filtros por año, identificación de estados sin producción y comparaciones entre commodities.

**Conceptos:** `JOIN`, `LEFT JOIN`, `subqueries`, `GROUP BY`, `WHERE`, `NOT IN`

---

### 🛒 [02 · Análisis de Plataforma E-commerce](./02_ecommerce_analysis/)
Análisis de comportamiento de usuarios, órdenes y eventos en una plataforma de comercio electrónico. Incluye análisis de series de tiempo con date spine, manejo de nulos y métricas de negocio.

**Conceptos:** `COALESCE`, `date spine`, `LEFT JOIN`, `GROUP BY`, `CASE WHEN`, `subqueries`, `CTEs`

---

## Estructura del repositorio

```
sql-portfolio/
├── 01_agricultural_production/
│   ├── README.md
│   ├── queries/
│   │   ├── 01_setup.sql          ← Creación de tablas
│   │   ├── 02_basic_queries.sql  ← SELECT, WHERE, GROUP BY
│   │   ├── 03_joins.sql          ← JOIN y LEFT JOIN
│   │   └── 04_subqueries.sql     ← Subqueries y NOT IN
│   └── data/
│       └── setup_instructions.md
├── 02_ecommerce_analysis/
│   ├── README.md
│   ├── queries/
│   │   ├── 01_setup.sql          ← Creación de tablas
│   │   ├── 02_exploratory.sql    ← Exploración inicial
│   │   ├── 03_aggregations.sql   ← GROUP BY, HAVING, CASE WHEN
│   │   ├── 04_date_spine.sql     ← Series de tiempo con COALESCE
│   │   └── 05_subqueries.sql     ← Subqueries avanzadas
│   └── data/
│       └── setup_instructions.md
└── docs/
    └── er_diagrams.md            ← Diagramas entidad-relación
```

---

## Cómo reproducir los proyectos

1. Instalar [DBeaver Community](https://dbeaver.io/) (o cualquier cliente SQLite)
2. Crear una base de datos SQLite nueva
3. Ejecutar el script `01_setup.sql` del proyecto correspondiente
4. Cargar los datos según las instrucciones en `data/setup_instructions.md`
5. Ejecutar los scripts de queries en orden numérico

---

*Contacto: [LinkedIn](https://linkedin.com/in/tu-perfil) · pia.gonzalez@email.com*
