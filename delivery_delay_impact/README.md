# Olist Delivery Delay Impact Analysis

This portfolio project quantifies how delivery promise adherence (estimated date vs actual delivery date) affects customer satisfaction and identifies high-priority improvement areas. The project follows a clear analytics workflow: **problem definition -> metric design -> reproducible pipeline -> action-oriented insights**.

## Project Snapshot
- Objective: Measure the impact of delivery delays on ratings/low-rating risk and propose priority segments for improvement.
- Data: Olist Brazilian E-Commerce Public Dataset (Kaggle)
- Scope: Orders with both estimated and actual delivery dates; canceled/unavailable orders excluded.
- Stack: MySQL 8, SQL, Tableau (or equivalent BI tools)
- Outputs: `marts.fact_orders`, `analytics` views, priority scoring tables, and `results/` CSV exports

## Business Questions
- How much do delayed deliveries increase the low-rating rate?
- Which region x category segments should be addressed first to maximize rating recovery?

## Core Metrics
| Metric | Definition |
| --- | --- |
| `promise_slip_days` | `DATEDIFF(delivered_customer_ts, estimated_delivery_ts)`; positive values indicate delay |
| `delayed_flag` | 1 if `promise_slip_days > 0`, else 0 |
| `on_time_flag` | 1 if `promise_slip_days <= 0`, else 0 |
| `early_flag` | 1 if `promise_slip_days < 0`, else 0 |
| `low_rating_flag` | 1 if `review_score_avg <= 2`, else 0 |
| `failed_order_flag` | 1 if `order_status` in (`canceled`, `unavailable`), else 0 |
| `opportunity_score` | `low_rating_lift * orders_cnt` (higher = stronger improvement potential) |

## Data Pipeline
```text
raw CSV (raw.*)
  -> marts.fact_orders
  -> analytics views (v_orders_base, v_delay_bins, v_segment_base)
  -> analytics.segment_priority + CSV exports (results/)
```

## Tableau ERD (Recommended Data Sources)
In Tableau, it is safer to separate **order-level views** and **segment-level views**.

Order-level analysis source:
```
analytics.v_orders_base  (PK: order_id)
        |
        |-- analytics.v_delay_bins   (PK: order_id)
        |
        |-- analytics.v_segment_base (PK: order_id)
```

Priority/risk dashboard source:
```
analytics.v_priority_impact
```
- `v_priority_*` views differ only in sorting logic, so you can use **one view** and change sort order in worksheets.

## Result Highlights
- The largest improvement opportunities are concentrated in high-volume categories in São Paulo (SP).
- High delay-risk segments are more frequent in RJ/BA across electronics, baby, and telecom-related categories.
- Some segments show very high low-rating lift when deliveries are delayed.

## Impact Estimation (Potential Low-Rating Reduction)
Assuming delayed orders are converted to on-time delivery, expected low-rating reduction is estimated as:
`preventable_low_ratings = low_rating_lift * delayed_rate * orders_cnt`

Top segments (sample):
| customer_state   | category_main         |   orders_cnt |   delayed_rate |   low_rating_lift |   preventable_low_ratings |
|:-----------------|:----------------------|-------------:|---------------:|------------------:|--------------------------:|
| RJ               | bed_bath_table        |         1308 |          0.148 |             0.606 |                     117.5 |
| SP               | health_beauty         |         3654 |          0.053 |             0.434 |                      84.7 |
| SP               | bed_bath_table        |         4220 |          0.04  |             0.462 |                      78.1 |
| RJ               | sports_leisure        |          877 |          0.14  |             0.619 |                      76.1 |
| SP               | sports_leisure        |         3168 |          0.044 |             0.504 |                      69.6 |
| RJ               | computers_accessories |          810 |          0.121 |             0.67  |                      65.7 |
| RJ               | furniture_decor       |          800 |          0.121 |             0.617 |                      59.9 |
| RJ               | watches_gifts         |          770 |          0.139 |             0.556 |                      59.5 |
| SP               | housewares            |         2669 |          0.04  |             0.54  |                      57.8 |
| SP               | furniture_decor       |         2599 |          0.047 |             0.473 |                      57.6 |

Top opportunity segments (Top 10):
| customer_state   | category_main         |   orders_cnt |   delayed_rate |   low_rating_lift |   opportunity_score |
|:-----------------|:----------------------|-------------:|---------------:|------------------:|--------------------:|
| SP               | bed_bath_table        |         4220 |          0.04  |             0.462 |              1951.3 |
| SP               | sports_leisure        |         3168 |          0.044 |             0.504 |              1596   |
| SP               | health_beauty         |         3654 |          0.053 |             0.434 |              1586.9 |
| SP               | housewares            |         2669 |          0.04  |             0.54  |              1442.1 |
| SP               | furniture_decor       |         2599 |          0.047 |             0.473 |              1228.8 |
| SP               | watches_gifts         |         2065 |          0.048 |             0.503 |              1038.5 |
| SP               | computers_accessories |         2576 |          0.042 |             0.395 |              1017.5 |
| RJ               | bed_bath_table        |         1308 |          0.148 |             0.606 |               792.1 |
| SP               | toys                  |         1547 |          0.04  |             0.502 |               776.4 |
| SP               | auto                  |         1567 |          0.058 |             0.492 |               770.7 |

## How to Run
Run the SQL files in order:
1. `sql/00_init.sql` - create database and schemas
2. `sql/10_create_raw_tables.sql` - create raw tables
3. `sql/01_load_raw.sql` - load source CSV files
4. `sql/20_build_fact_orders.sql` - build `marts.fact_orders`
5. `sql/21_qc_fact_orders.sql` - quality checks
6. `sql/30_build_analytics_views.sql` - build analytics views
7. `sql/40_result_delay_vs_review.sql` - summarize delay vs review patterns
8. `sql/41_state_pair_analysis.sql` - customer/seller state-pair analysis
9. `sql/50_priority_scoring.sql` - segment priority scoring
10. `sql/51_priority_views.sql` - dashboard views

## Output Objects
- `raw.*` - source CSV tables
- `marts.fact_orders` - order-level fact table
- `analytics.v_orders_base` - common analysis base view
- `analytics.v_delay_bins` - delay-bucket view
- `analytics.v_segment_base` - segment analysis base view
- `analytics.segment_priority` - segment priority table
- `analytics.v_priority_*` - dashboard-ready priority views

## Exporting Results
Save SQL SELECT outputs as CSV files and store them under `results/`.
(Example: MySQL Workbench export or `INTO OUTFILE`.)
