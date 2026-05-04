-- ============================================================
-- Proyecto 01 · Producción Agrícola por Estado
-- Script: 02_basic_queries.sql
-- Descripción: Exploración inicial y consultas básicas
-- ============================================================

-- ── 1. Verificar contenido de cada tabla ───────────────────
SELECT COUNT(*) AS total_registros FROM milk_production;
SELECT COUNT(*) AS total_registros FROM cheese_production;
SELECT COUNT(*) AS total_registros FROM honey_production;
SELECT COUNT(*) AS total_registros FROM state_lookup;

-- ── 2. Ver primeros registros de producción de leche ───────
SELECT *
FROM milk_production
LIMIT 10;

-- ── 3. Estados disponibles en el catálogo ──────────────────
SELECT state_ANSI, state
FROM state_lookup
ORDER BY state;

-- ── 4. Producción total de leche por año ───────────────────
SELECT
    year,
    SUM(value) AS produccion_total
FROM milk_production
GROUP BY year
ORDER BY year;

-- ── 5. Top 5 estados productores de miel (todos los años) ──
SELECT
    state,
    SUM(value) AS produccion_total_miel
FROM honey_production
GROUP BY state
ORDER BY produccion_total_miel DESC
LIMIT 5;

-- ── 6. Producción promedio de queso por período ─────────────
SELECT
    period,
    ROUND(AVG(value), 0) AS promedio_produccion
FROM cheese_production
GROUP BY period
ORDER BY promedio_produccion DESC;

-- ── 7. Años disponibles en el dataset de miel ───────────────
SELECT DISTINCT year
FROM honey_production
ORDER BY year;

-- ── 8. Estados con producción de leche mayor a 10 millones ──
--    (en el año más reciente disponible)
SELECT
    state,
    year,
    value AS produccion
FROM milk_production
WHERE year = (SELECT MAX(year) FROM milk_production)
  AND value > 10000000
ORDER BY value DESC;
