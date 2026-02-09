-- Create analytics views.
-- Prevent metric drift from reimplemented logic and simplify downstream consumption.
USE olist_portfolio;

-- Create base analysis view.
-- Expose core fact_orders columns and derived flags for reuse.
DROP VIEW IF EXISTS analytics.v_orders_base;
CREATE VIEW analytics.v_orders_base AS
SELECT
  order_id,
  order_status,
  purchase_ts,
  approved_ts,
  delivered_customer_ts,
  estimated_delivery_ts,
  promise_slip_days,
  delayed_flag,
  on_time_flag,
  early_flag,
  failed_order_flag,
  lead_time_days,
  ship_time_days,
  customer_state,
  category_main,
  price_total,
  freight_total,
  payment_value_total,
  review_score_avg,
  -- Classify ratings <= 2 as low ratings.
  CASE WHEN review_score_avg IS NULL THEN NULL
       WHEN review_score_avg <= 2 THEN 1 ELSE 0 END AS low_rating_flag,
  -- Create purchase-month column for monthly aggregation.
  DATE_FORMAT(purchase_ts, '%Y-%m-01') AS purchase_month
FROM marts.fact_orders;

-- Create view for delay-day bucketing.
-- Standardize slip_bin so all analyses use the same bucket definitions.
DROP VIEW IF EXISTS analytics.v_delay_bins;
CREATE VIEW analytics.v_delay_bins AS
SELECT
  *,
  CASE
    WHEN promise_slip_days IS NULL THEN NULL
    -- Group values <= 0 into on_time_or_early.
    WHEN promise_slip_days <= 0 THEN 'on_time_or_early'
    WHEN promise_slip_days = 1 THEN 'late_1'
    WHEN promise_slip_days = 2 THEN 'late_2'
    WHEN promise_slip_days = 3 THEN 'late_3'
    ELSE 'late_4_plus'
  END AS slip_bin
FROM analytics.v_orders_base;

-- Create base view for segment analysis.
-- Provide price/freight bands together with core target metrics.
DROP VIEW IF EXISTS analytics.v_segment_base;
CREATE VIEW analytics.v_segment_base AS
SELECT
  purchase_month,
  customer_state,
  category_main,
  CASE
    WHEN price_total IS NULL THEN NULL
    -- Bucket order value to enable price-band comparisons.
    WHEN price_total < 50 THEN 'p_0_50'
    WHEN price_total < 100 THEN 'p_50_100'
    WHEN price_total < 200 THEN 'p_100_200'
    WHEN price_total < 500 THEN 'p_200_500'
    ELSE 'p_500_plus'
  END AS price_band,
  CASE
    WHEN freight_total IS NULL THEN NULL
    -- Bucket freight value to compare shipping-cost impact.
    WHEN freight_total < 20 THEN 'f_0_20'
    WHEN freight_total < 40 THEN 'f_20_40'
    WHEN freight_total < 80 THEN 'f_40_80'
    ELSE 'f_80_plus'
  END AS freight_band,
  order_id,
  delayed_flag,
  low_rating_flag,
  promise_slip_days
FROM analytics.v_orders_base
-- Exclude failed orders to maintain analysis consistency.
WHERE failed_order_flag = 0;
