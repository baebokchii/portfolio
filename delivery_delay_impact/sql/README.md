# 🛠️ SQL Pipeline Guide

This folder contains the SQL pipeline for building reproducible analytics outputs.

## ▶️ Execution Order
1. `sql/00_init.sql` - initialize database and schemas
2. `sql/10_create_raw_tables.sql` - create raw ingest tables
3. `sql/01_load_raw.sql` - load source CSV data
4. `sql/20_build_fact_orders.sql` - build the order-level fact table
5. `sql/21_qc_fact_orders.sql` - run quality checks on fact table
6. `sql/30_build_analytics_views.sql` - create reusable analysis views
7. `sql/40_result_delay_vs_review.sql` - summarize delay vs review outcomes
8. `sql/41_state_pair_analysis.sql` - analyze customer/seller state pairs
9. `sql/50_priority_scoring.sql` - score improvement opportunities by segment
10. `sql/51_priority_views.sql` - create dashboard-ready priority views

## 🧾 Result Objects
- `raw.*` - source CSV tables
- `marts.fact_orders` - order-level fact table
- `analytics.v_orders_base` - reusable order analysis base
- `analytics.v_delay_bins` - standardized delay buckets
- `analytics.v_segment_base` - segment-level analysis base
- `analytics.segment_priority` - improvement scoring table
- `analytics.v_priority_*` - sorted priority views for reporting

## 📤 Exporting CSV
Export SELECT outputs from your SQL client and store them under `results/`.
(Example: MySQL Workbench export or `INTO OUTFILE`.)
