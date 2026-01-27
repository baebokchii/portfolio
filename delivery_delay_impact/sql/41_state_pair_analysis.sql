-- Customer state x seller state analysis for delay risk and volume.
-- Orders with multiple sellers contribute to multiple state pairs.
USE olist_portfolio;

WITH order_sellers AS (
  SELECT DISTINCT
    order_id,
    seller_id
  FROM raw.olist_order_items
),
order_state_pairs AS (
  SELECT
    v.order_id,
    v.customer_state,
    s.seller_state,
    v.delayed_flag,
    v.low_rating_flag
  FROM analytics.v_orders_base v
  JOIN order_sellers os
    ON os.order_id = v.order_id
  JOIN raw.olist_sellers s
    ON s.seller_id = os.seller_id
  WHERE v.failed_order_flag = 0
    AND v.delayed_flag IS NOT NULL
    AND v.low_rating_flag IS NOT NULL
    AND v.customer_state IS NOT NULL
    AND s.seller_state IS NOT NULL
)
SELECT
  customer_state,
  seller_state,
  COUNT(*) AS orders_cnt,
  AVG(delayed_flag) AS delayed_rate,
  AVG(low_rating_flag) AS low_rating_rate
FROM order_state_pairs
GROUP BY customer_state, seller_state
HAVING COUNT(*) >= 200
ORDER BY delayed_rate DESC, orders_cnt DESC
LIMIT 30;

SELECT
  customer_state,
  seller_state,
  COUNT(*) AS orders_cnt,
  AVG(delayed_flag) AS delayed_rate,
  AVG(low_rating_flag) AS low_rating_rate
FROM order_state_pairs
GROUP BY customer_state, seller_state
ORDER BY orders_cnt DESC
LIMIT 30;
