-- ============================================================
-- Proyecto 01 · Producción Agrícola por Estado
-- Script: 01_setup.sql
-- Descripción: Creación del esquema relacional completo
-- Motor: SQLite
-- ============================================================

-- Tabla de referencia: estados
CREATE TABLE IF NOT EXISTS state_lookup (
    state_ANSI TEXT PRIMARY KEY,
    state       TEXT NOT NULL
);

-- Producción de leche
CREATE TABLE IF NOT EXISTS milk_production (
    region      TEXT,
    state       TEXT,
    state_ANSI  TEXT,
    year        INTEGER,
    period      TEXT,
    value       REAL,
    FOREIGN KEY (state_ANSI) REFERENCES state_lookup(state_ANSI)
);

-- Producción de queso
CREATE TABLE IF NOT EXISTS cheese_production (
    region      TEXT,
    state       TEXT,
    state_ANSI  TEXT,
    year        INTEGER,
    period      TEXT,
    value       REAL,
    FOREIGN KEY (state_ANSI) REFERENCES state_lookup(state_ANSI)
);

-- Producción de miel
CREATE TABLE IF NOT EXISTS honey_production (
    region      TEXT,
    state       TEXT,
    state_ANSI  TEXT,
    year        INTEGER,
    period      TEXT,
    value       REAL,
    FOREIGN KEY (state_ANSI) REFERENCES state_lookup(state_ANSI)
);

-- Producción de yogurt
CREATE TABLE IF NOT EXISTS yogurt_production (
    region      TEXT,
    state       TEXT,
    state_ANSI  TEXT,
    year        INTEGER,
    period      TEXT,
    value       REAL,
    FOREIGN KEY (state_ANSI) REFERENCES state_lookup(state_ANSI)
);

-- Producción de huevos
CREATE TABLE IF NOT EXISTS egg_production (
    region      TEXT,
    state       TEXT,
    state_ANSI  TEXT,
    year        INTEGER,
    period      TEXT,
    value       REAL,
    FOREIGN KEY (state_ANSI) REFERENCES state_lookup(state_ANSI)
);

-- Producción de café
CREATE TABLE IF NOT EXISTS coffee_production (
    region      TEXT,
    state       TEXT,
    state_ANSI  TEXT,
    year        INTEGER,
    period      TEXT,
    value       REAL,
    FOREIGN KEY (state_ANSI) REFERENCES state_lookup(state_ANSI)
);
