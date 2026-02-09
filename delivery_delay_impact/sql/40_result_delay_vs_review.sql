-- Summarize the relationship between delivery delay and review ratings.
-- Compare order counts, average ratings, and low-rating rates by delay bucket.
USE olist_portfolio;

-- Aggregate key metrics by delay bucket (slip_bin).
-- Include only records with both review and delay data, excluding failed orders.
SELECT
  slip_bin,
  COUNT(*) AS orders_cnt,
  AVG(review_score_avg) AS avg_review_score,
  AVG(low_rating_flag) AS low_rating_rate,
  AVG(delayed_flag) AS delayed_rate,
  AVG(promise_slip_days) AS avg_slip_days
FROM analytics.v_delay_bins
WHERE review_score_avg IS NOT NULL
  AND promise_slip_days IS NOT NULL
  AND failed_order_flag = 0
GROUP BY slip_bin
ORDER BY
  CASE slip_bin
    WHEN 'on_time_or_early' THEN 1
    WHEN 'late_1' THEN 2
    WHEN 'late_2' THEN 3
    WHEN 'late_3' THEN 4
    WHEN 'late_4_plus' THEN 5
    ELSE 99
  END;
