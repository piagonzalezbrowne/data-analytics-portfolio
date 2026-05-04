-- ============================================================
-- Proyecto 02 · Análisis de Plataforma E-commerce
-- Script: 01_setup.sql
-- Descripción: Creación del esquema relacional completo
-- Motor: SQLite
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
    user_id         TEXT PRIMARY KEY,
    created_at      TEXT,
    deleted_at      TEXT,
    merged_at       TEXT,
    parent_user_id  TEXT,
    is_admin        INTEGER
);

CREATE TABLE IF NOT EXISTS items (
    item_id         TEXT PRIMARY KEY,
    created_at      TEXT,
    deleted_at      TEXT,
    name            TEXT,
    category        TEXT,
    price           REAL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id        TEXT PRIMARY KEY,
    created_at      TEXT,
    paid_at         TEXT,
    user_id         TEXT,
    status          TEXT,
    invoice_id      TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS line_items (
    line_item_id    TEXT PRIMARY KEY,
    created_at      TEXT,
    order_id        TEXT,
    item_id         TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id)  REFERENCES items(item_id)
);

CREATE TABLE IF NOT EXISTS events (
    event_id        TEXT PRIMARY KEY,
    created_at      TEXT,
    event_name      TEXT,
    user_id         TEXT,
    platform        TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS item_field_history (
    item_field_history_id TEXT PRIMARY KEY,
    created_at      TEXT,
    item_id         TEXT,
    field_name      TEXT,
    new_value       TEXT,
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

CREATE TABLE IF NOT EXISTS dates (
    date TEXT PRIMARY KEY  -- formato YYYY-MM-DD
);
