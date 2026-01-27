-- 개선 우선순위 스코어 산출 테이블 생성함.
-- 지연이 저평점에 미치는 영향을 세그먼트별로 수치화함.
-- 리프트는 지연이 있을 때와 없을 때의 저평점율 차이를 보여줘 영향도를 분리해 판단하게 함.
USE olist_portfolio;

-- 기존 결과를 초기화해 재생성함.
DROP TABLE IF EXISTS analytics.segment_priority;

-- 세그먼트(지역 x 카테고리)별 핵심 지표와 기회 점수 계산함.
CREATE TABLE analytics.segment_priority AS
SELECT
  customer_state,
  category_main,
  COUNT(*) AS orders_cnt,
  -- 지연율/저평점율 기본 지표 산출함.
  AVG(delayed_flag) AS delayed_rate,
  AVG(low_rating_flag) AS low_rating_rate,
-- 지연 여부에 따른 저평점율 차이(리프트)를 계산해 지연 영향도를 측정함.
  AVG(CASE WHEN delayed_flag = 1 THEN low_rating_flag END) AS low_rating_rate_delayed,
  AVG(CASE WHEN delayed_flag = 0 THEN low_rating_flag END) AS low_rating_rate_on_time,
  (AVG(CASE WHEN delayed_flag = 1 THEN low_rating_flag END) -
   AVG(CASE WHEN delayed_flag = 0 THEN low_rating_flag END)) AS low_rating_lift,
-- 리프트(영향 크기)와 표본 규모를 곱해 우선순위 점수(opportunity_score) 산출함.
-- opportunity_score가 클수록 개선 여지가 큰 세그먼트로 해석함.
  (AVG(CASE WHEN delayed_flag = 1 THEN low_rating_flag END) -
   AVG(CASE WHEN delayed_flag = 0 THEN low_rating_flag END)) * COUNT(*) AS opportunity_score
FROM analytics.v_orders_base
-- 실패 주문과 결측 플래그는 제외해 비교 일관성 유지함.
WHERE failed_order_flag = 0
  AND delayed_flag IS NOT NULL
  AND low_rating_flag IS NOT NULL
-- 표본 수가 충분한 세그먼트만 사용함.
GROUP BY customer_state, category_main
HAVING COUNT(*) >= 200
ORDER BY opportunity_score DESC;

-- 우선순위 상위 세그먼트 확인함.
SELECT *
FROM analytics.segment_priority
ORDER BY opportunity_score DESC
LIMIT 30;

-- 지연율 기준 상위 세그먼트 확인함.
SELECT
  customer_state, category_main, orders_cnt,
  delayed_rate, low_rating_lift, opportunity_score
FROM analytics.segment_priority
WHERE orders_cnt >= 200
ORDER BY delayed_rate DESC
LIMIT 20;

-- 저평점 리프트 기준 상위 세그먼트 확인함.
SELECT
  customer_state, category_main, orders_cnt,
  delayed_rate, low_rating_lift, opportunity_score
FROM analytics.segment_priority
WHERE orders_cnt >= 200
ORDER BY low_rating_lift DESC
LIMIT 20;
