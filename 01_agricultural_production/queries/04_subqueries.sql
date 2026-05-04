-- ============================================================
-- Proyecto 01 · Producción Agrícola por Estado
-- Script: 04_subqueries.sql
-- Descripción: Subqueries para análisis comparativo
-- ============================================================

-- ── 1. Estados que producen miel pero NO producen café ─────
SELECT DISTINCT state
FROM honey_production
WHERE state_ANSI NOT IN (
    SELECT DISTINCT state_ANSI
    FROM coffee_production
)
ORDER BY state;

-- ── 2. Estados con producción de leche sobre el promedio ───
--    Subquery en WHERE para comparar con un agregado
SELECT
    state,
    year,
    value AS produccion_leche
FROM milk_production
WHERE year = 2022
  AND value > (
        SELECT AVG(value)
        FROM milk_production
        WHERE year = 2022
  )
ORDER BY value DESC;

-- ── 3. Estado con mayor producción de miel por año ─────────
--    Subquery correlacionada
SELECT
    hp.year,
    hp.state,
    hp.value AS produccion_maxima
FROM honey_production hp
WHERE hp.value = (
    SELECT MAX(value)
    FROM honey_production
    WHERE year = hp.year
)
ORDER BY hp.year;

-- ── 4. Estados presentes en milk pero ausentes en yogurt ───
--    Útil para detectar gaps de cobertura en el dataset
SELECT DISTINCT state
FROM milk_production
WHERE state_ANSI NOT IN (
    SELECT DISTINCT state_ANSI
    FROM yogurt_production
)
ORDER BY state;

-- ── 5. Producción de queso en años con alta producción ─────
--    de leche a nivel nacional (top 3 años)
SELECT
    year,
    state,
    value AS produccion_queso
FROM cheese_production
WHERE year IN (
    SELECT year
    FROM milk_production
    GROUP BY year
    ORDER BY SUM(value) DESC
    LIMIT 3
)
ORDER BY year, value DESC;
