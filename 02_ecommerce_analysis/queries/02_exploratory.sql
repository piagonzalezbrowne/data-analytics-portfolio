-- ============================================================
-- Proyecto 02 · Análisis de Plataforma E-commerce
-- Script: 02_exploratory.sql
-- Descripción: Exploración inicial del dataset
-- ============================================================

-- ── 1. Conteo general de registros por tabla ────────────────
SELECT 'users'      AS tabla, COUNT(*) AS registros FROM users
UNION ALL
SELECT 'items',              COUNT(*) FROM items
UNION ALL
SELECT 'orders',             COUNT(*) FROM orders
UNION ALL
SELECT 'line_items',         COUNT(*) FROM line_items
UNION ALL
SELECT 'events',             COUNT(*) FROM events;

-- ── 2. Rango de fechas del dataset ─────────────────────────
SELECT
    MIN(DATE(created_at)) AS primera_orden,
    MAX(DATE(created_at)) AS ultima_orden
FROM orders;

-- ── 3. Usuarios registrados por fecha ──────────────────────
--    Detecta qué fechas tienen datos (sin date spine)
SELECT
    DATE(created_at) AS fecha_registro,
    COUNT(*)         AS nuevos_usuarios
FROM users
GROUP BY fecha_registro
ORDER BY fecha_registro;

-- ── 4. Primeros 10 usuarios registrados ────────────────────
SELECT user_id, created_at, is_admin
FROM users
ORDER BY created_at
LIMIT 10;

-- ── 5. Distribución de órdenes por status ──────────────────
SELECT
    status,
    COUNT(*) AS cantidad
FROM orders
GROUP BY status
ORDER BY cantidad DESC;

-- ── 6. Items más frecuentes en line_items ──────────────────
SELECT
    li.item_id,
    i.name,
    COUNT(*) AS veces_comprado
FROM line_items li
JOIN items i ON li.item_id = i.item_id
GROUP BY li.item_id, i.name
ORDER BY veces_comprado DESC
LIMIT 10;

-- ── 7. Verificar NULLs en columna is_admin ─────────────────
SELECT
    COALESCE(is_admin, 0) AS is_admin_limpio,
    COUNT(*)              AS usuarios
FROM users
GROUP BY is_admin_limpio;
