-- ============================================================
-- Proyecto 02 · Análisis de Plataforma E-commerce
-- Script: 03_aggregations.sql
-- Descripción: Métricas de negocio con GROUP BY y CASE WHEN
-- ============================================================

-- ── 1. Órdenes por día ──────────────────────────────────────
SELECT
    DATE(created_at) AS fecha,
    COUNT(order_id)  AS total_ordenes
FROM orders
GROUP BY fecha
ORDER BY fecha;

-- ── 2. Ingresos totales por día ─────────────────────────────
--    Suma el precio de cada ítem en line_items
SELECT
    DATE(o.created_at)  AS fecha,
    SUM(i.price)        AS ingresos
FROM orders o
JOIN line_items li ON o.order_id  = li.order_id
JOIN items i       ON li.item_id  = i.item_id
WHERE o.status = 'complete'
GROUP BY fecha
ORDER BY fecha;

-- ── 3. Usuarios activos por día (con al menos 1 evento) ─────
SELECT
    DATE(created_at)    AS fecha,
    COUNT(DISTINCT user_id) AS usuarios_activos
FROM events
GROUP BY fecha
ORDER BY fecha;

-- ── 4. Segmentación de usuarios: admin vs. regular ──────────
SELECT
    CASE
        WHEN COALESCE(is_admin, 0) = 1 THEN 'Administrador'
        ELSE 'Regular'
    END                 AS tipo_usuario,
    COUNT(*)            AS cantidad
FROM users
GROUP BY tipo_usuario;

-- ── 5. Eventos por tipo de plataforma ───────────────────────
SELECT
    platform,
    COUNT(*)            AS total_eventos
FROM events
GROUP BY platform
ORDER BY total_eventos DESC;

-- ── 6. Promedio de ítems por orden ──────────────────────────
SELECT
    ROUND(AVG(items_por_orden), 2) AS promedio_items_por_orden
FROM (
    SELECT order_id, COUNT(*) AS items_por_orden
    FROM line_items
    GROUP BY order_id
);

-- ── 7. Categorías de productos más vendidas ─────────────────
SELECT
    i.category,
    COUNT(li.line_item_id)  AS unidades_vendidas,
    ROUND(SUM(i.price), 2)  AS ingresos_totales
FROM line_items li
JOIN items i ON li.item_id = i.item_id
GROUP BY i.category
ORDER BY unidades_vendidas DESC;
