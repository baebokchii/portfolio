-- 포트폴리오용 초기 설정: 데이터베이스와 핵심 스키마 생성.
-- 데모 중에도 안전하게 재실행할 수 있도록 idempotent하게(멱동성있게) 유지.
CREATE DATABASE IF NOT EXISTS olist_portfolio
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

-- 원천 적재(raw), 정제 마트(marts), 분석용(analytics) 레이어를 구분.
CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS marts;
CREATE SCHEMA IF NOT EXISTS analytics;
