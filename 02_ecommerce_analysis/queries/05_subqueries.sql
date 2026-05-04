-- ============================================================
-- Proyecto 02 · Análisis de Plataforma E-commerce
-- Script: 05_subqueries.sql
-- Descripción: Subqueries para análisis comparativo
-- ============================================================

-- ── 1. Usuarios con más órdenes que el promedio ─────────────
--    Subquery en WHERE para comparar con un valor agregado
SELECT
    user_id,
    COUNT(order_id) AS total_ordenes
FROM orders
GROUP BY user_id
HAVING COUNT(order_id) > (
    SELECT AVG(ordenes_por_usuario)
    FROM (
        SELECT COUNT(order_id) AS ordenes_por_usuario
        FROM orders
        GROUP BY user_id
    )
)
ORDER BY total_ordenes DESC;


-- ── 2. Órdenes de usuarios que nunca generaron eventos ──────
--    Identifica usuarios con actividad de compra pero sin
--    eventos registrados (posible gap en tracking)
SELECT
    o.order_id,
    o.user_id,
    DATE(o.created_at) AS fecha_orden
FROM orders o
WHERE o.user_id NOT IN (
    SELECT DISTINCT user_id
    FROM events
    WHERE user_id IS NOT NULL
)
ORDER BY fecha_orden;


-- ── 3. Items comprados en el mismo día que fueron creados ───
SELECT
    i.item_id,
    i.name,
    DATE(i.created_at)  AS fecha_creacion,
    DATE(o.created_at)  AS fecha_orden
FROM items i
JOIN line_items li ON i.item_id   = li.item_id
JOIN orders     o  ON li.order_id = o.order_id
WHERE DATE(i.created_at) = DATE(o.created_at)
ORDER BY fecha_creacion;


-- ── 4. Día con mayor cantidad de órdenes ────────────────────
SELECT
    DATE(created_at) AS fecha,
    COUNT(order_id)  AS ordenes
FROM orders
GROUP BY fecha
HAVING COUNT(order_id) = (
    SELECT MAX(conteo)
    FROM (
        SELECT COUNT(order_id) AS conteo
        FROM orders
        GROUP BY DATE(created_at)
    )
);


-- ── 5. Usuarios que realizaron órdenes en más de un día ─────
SELECT
    user_id,
    COUNT(DISTINCT DATE(created_at)) AS dias_con_ordenes
FROM orders
GROUP BY user_id
HAVING dias_con_ordenes > 1
ORDER BY dias_con_ordenes DESC;
