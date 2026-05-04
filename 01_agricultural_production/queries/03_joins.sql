-- ============================================================
-- Proyecto 01 · Producción Agrícola por Estado
-- Script: 03_joins.sql
-- Descripción: Análisis con JOIN y LEFT JOIN entre tablas
-- ============================================================

-- ── 1. Producción de leche con nombre completo de estado ───
--    JOIN entre milk_production y state_lookup
SELECT
    sl.state                        AS estado,
    mp.year                         AS año,
    mp.value                        AS produccion_leche
FROM milk_production mp
JOIN state_lookup sl ON mp.state_ANSI = sl.state_ANSI
ORDER BY mp.year DESC, mp.value DESC
LIMIT 20;

-- ── 2. Estados que produjeron tanto leche como miel en 2022 ─
SELECT
    sl.state                        AS estado,
    mp.value                        AS produccion_leche,
    hp.value                        AS produccion_miel
FROM milk_production mp
JOIN honey_production hp
    ON  mp.state_ANSI = hp.state_ANSI
    AND mp.year       = hp.year
JOIN state_lookup sl
    ON  mp.state_ANSI = sl.state_ANSI
WHERE mp.year = 2022
ORDER BY sl.state;

-- ── 3. Todos los estados + producción de queso si existe ───
--    LEFT JOIN: muestra NULL para estados sin datos de queso
SELECT
    sl.state                        AS estado,
    cp.year                         AS año,
    cp.value                        AS produccion_queso
FROM state_lookup sl
LEFT JOIN cheese_production cp
    ON  sl.state_ANSI = cp.state_ANSI
    AND cp.year = 2022
ORDER BY sl.state;

-- ── 4. Estados que tienen leche pero NO tienen miel (2022) ──
SELECT
    sl.state                        AS estado,
    mp.value                        AS produccion_leche
FROM milk_production mp
JOIN state_lookup sl ON mp.state_ANSI = sl.state_ANSI
LEFT JOIN honey_production hp
    ON  mp.state_ANSI = hp.state_ANSI
    AND hp.year = 2022
WHERE mp.year = 2022
  AND hp.state_ANSI IS NULL
ORDER BY sl.state;
