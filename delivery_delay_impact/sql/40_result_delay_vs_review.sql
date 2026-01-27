-- 배송 지연과 리뷰 평점의 관계를 요약.
-- 지연 구간별로 주문 수, 평균 평점, 저평점 비율을 함께 비교.
USE olist_portfolio;

-- 지연 구간(slip_bin) 기준으로 핵심 지표를 집계.
-- 분석 대상은 리뷰와 지연일이 모두 존재하고, 실패 주문을 제외한 건임.
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
