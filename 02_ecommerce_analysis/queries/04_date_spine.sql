-- ============================================================
-- Proyecto 02 · Análisis de Plataforma E-commerce
-- Script: 04_date_spine.sql
-- Descripción: Series de tiempo completas con date spine
--              y manejo de nulos con COALESCE
--
-- Problema que resuelve:
--   Un GROUP BY sobre órdenes por fecha omite los días sin
--   órdenes, generando gaps en el gráfico. Con LEFT JOIN a
--   la tabla `dates` (date spine) aseguramos que aparezcan
--   TODAS las fechas del rango, mostrando 0 donde no hay datos.
-- ============================================================

-- ── 1. Problema sin date spine: días sin órdenes desaparecen
SELECT
    DATE(created_at) AS fecha,
    COUNT(order_id)  AS ordenes
FROM orders
GROUP BY fecha
ORDER BY fecha;
-- Resultado: solo aparecen fechas que tienen al menos 1 orden.


-- ── 2. Solución: LEFT JOIN con date spine ───────────────────
--    Todas las fechas del rango aparecen; los días sin órdenes
--    muestran 0 gracias a COALESCE.
SELECT
    d.date                          AS fecha,
    COALESCE(COUNT(o.order_id), 0)  AS ordenes
FROM dates d
LEFT JOIN orders o ON DATE(o.created_at) = d.date
WHERE d.date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY d.date
ORDER BY d.date;


-- ── 3. Serie de tiempo de nuevos usuarios (con date spine) ──
SELECT
    d.date                              AS fecha,
    COALESCE(COUNT(u.user_id), 0)       AS nuevos_usuarios
FROM dates d
LEFT JOIN users u ON DATE(u.created_at) = d.date
WHERE d.date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY d.date
ORDER BY d.date;


-- ── 4. Órdenes y usuarios nuevos en la misma serie ──────────
--    Combina dos métricas en una sola consulta por fecha
SELECT
    d.date                              AS fecha,
    COALESCE(COUNT(DISTINCT o.order_id), 0)  AS ordenes,
    COALESCE(COUNT(DISTINCT u.user_id), 0)   AS usuarios_nuevos
FROM dates d
LEFT JOIN orders o ON DATE(o.created_at) = d.date
LEFT JOIN users  u ON DATE(u.created_at) = d.date
WHERE d.date BETWEEN '2023-01-01' AND '2023-01-07'
GROUP BY d.date
ORDER BY d.date;


-- ── 5. Eventos por día con date spine ───────────────────────
SELECT
    d.date                              AS fecha,
    COALESCE(COUNT(e.event_id), 0)      AS total_eventos
FROM dates d
LEFT JOIN events e ON DATE(e.created_at) = d.date
WHERE d.date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY d.date
ORDER BY d.date;
