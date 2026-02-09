-- Run QC checks on fact_orders.
-- fact_orders is the single source of truth for analysis/dashboarding; missing/invalid/extreme values reduce reliability.

-- Acceptance criteria
-- delivered_still_early_cnt should be 0
-- estimated_still_early_cnt should be 0
-- promise_slip_days distribution should be reasonable
-- delayed_flag should contain both 0 and 1
-- delayed_rate should not collapse to only 0 or 1 for top category_main items

USE olist_portfolio;

-- Verify table creation and baseline row count.
SELECT COUNT(*) AS fact_orders_cnt
FROM marts.fact_orders;

-- Check key missing/invalid date counts.
SELECT
  COUNT(*) AS total_cnt,
  SUM(delivered_customer_ts IS NULL) AS delivered_null_cnt,
  SUM(estimated_delivery_ts IS NULL) AS estimated_null_cnt,
  SUM(promise_slip_days IS NULL) AS slip_null_cnt,
  SUM(failed_order_flag = 1) AS failed_cnt,
  SUM(delivered_customer_ts < '2000-01-01') AS delivered_still_early_cnt,
  SUM(estimated_delivery_ts < '2000-01-01') AS estimated_still_early_cnt
FROM marts.fact_orders;

-- Inspect whether promise_slip_days distribution looks reasonable.
SELECT
  MIN(promise_slip_days) AS slip_min,
  MAX(promise_slip_days) AS slip_max,
  AVG(promise_slip_days) AS slip_avg
FROM marts.fact_orders
WHERE promise_slip_days IS NOT NULL;

-- Verify both delayed and non-delayed flags exist.
SELECT
  delayed_flag,
  COUNT(*) AS cnt
FROM marts.fact_orders
WHERE delayed_flag IS NOT NULL
GROUP BY delayed_flag;

-- Check for delay-rate skew by category.
SELECT
  category_main,
  COUNT(*) AS orders_cnt,
  AVG(delayed_flag) AS delayed_rate
FROM marts.fact_orders
WHERE delivered_customer_ts IS NOT NULL
  AND estimated_delivery_ts IS NOT NULL
  AND failed_order_flag = 0
GROUP BY category_main
ORDER BY orders_cnt DESC
LIMIT 15;