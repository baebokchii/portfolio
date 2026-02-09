-- Portfolio initialization: create database and core schemas.
-- Keep the script idempotent so it can be safely re-run during demos.
CREATE DATABASE IF NOT EXISTS olist_portfolio
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

-- Separate ingestion (raw), curated mart (marts), and analysis (analytics) layers.
CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS marts;
CREATE SCHEMA IF NOT EXISTS analytics;
