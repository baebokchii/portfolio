-- Create table for improvement-priority scoring.
-- Quantify delay impact on low ratings by segment.
-- Lift represents the low-rating-rate gap between delayed and on-time orders.
USE olist_portfolio;

-- Reset existing outputs before rebuilding.
DROP TABLE IF EXISTS analytics.segment_priority;

-- Compute core metrics and opportunity scores by segment (state x category).
CREATE TABLE analytics.segment_priority AS
SELECT
  customer_state,
  category_main,
  COUNT(*) AS orders_cnt,
  -- Calculate baseline delay and low-rating metrics.
  AVG(delayed_flag) AS delayed_rate,
  AVG(low_rating_flag) AS low_rating_rate,
-- Measure delay impact by calculating low-rating lift by delay status.
  AVG(CASE WHEN delayed_flag = 1 THEN low_rating_flag END) AS low_rating_rate_delayed,
  AVG(CASE WHEN delayed_flag = 0 THEN low_rating_flag END) AS low_rating_rate_on_time,
  (AVG(CASE WHEN delayed_flag = 1 THEN low_rating_flag END) -
   AVG(CASE WHEN delayed_flag = 0 THEN low_rating_flag END)) AS low_rating_lift,
-- Compute opportunity_score as lift (impact size) multiplied by sample size.
-- Higher opportunity_score implies greater improvement potential.
  (AVG(CASE WHEN delayed_flag = 1 THEN low_rating_flag END) -
   AVG(CASE WHEN delayed_flag = 0 THEN low_rating_flag END)) * COUNT(*) AS opportunity_score
FROM analytics.v_orders_base
-- Exclude failed orders and NULL flags for consistent comparison.
WHERE failed_order_flag = 0
  AND delayed_flag IS NOT NULL
  AND low_rating_flag IS NOT NULL
-- Keep only segments with sufficient sample size.
GROUP BY customer_state, category_main
HAVING COUNT(*) >= 200
ORDER BY opportunity_score DESC;

-- Inspect top segments by opportunity score.
SELECT *
FROM analytics.segment_priority
ORDER BY opportunity_score DESC
LIMIT 30;

-- Inspect top segments by delay rate.
SELECT
  customer_state, category_main, orders_cnt,
  delayed_rate, low_rating_lift, opportunity_score
FROM analytics.segment_priority
WHERE orders_cnt >= 200
ORDER BY delayed_rate DESC
LIMIT 20;

-- Inspect top segments by low-rating lift.
SELECT
  customer_state, category_main, orders_cnt,
  delayed_rate, low_rating_lift, opportunity_score
FROM analytics.segment_priority
WHERE orders_cnt >= 200
ORDER BY low_rating_lift DESC
LIMIT 20;
