-- analytics 뷰 생성.
-- 복잡한 로직 재작성으로 정의가 흔들리는 문제를 막고 소비 계층을 단순화함.
USE olist_portfolio;

-- 분석 기본 뷰 생성.
-- fact_orders의 핵심 컬럼과 파생 플래그를 그대로 노출해 재사용성을 높임.
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
  -- 평균 리뷰가 2 이하이면 저평점으로 분류함.
  CASE WHEN review_score_avg IS NULL THEN NULL
       WHEN review_score_avg <= 2 THEN 1 ELSE 0 END AS low_rating_flag,
  -- 월 단위 집계를 위한 구매 월 컬럼 생성함.
  DATE_FORMAT(purchase_ts, '%Y-%m-01') AS purchase_month
FROM marts.fact_orders;

-- 지연 일수 구간화를 위한 뷰 생성.
-- 분석에서 동일한 구간 정의를 쓰기 위해 slip_bin을 표준화함.
DROP VIEW IF EXISTS analytics.v_delay_bins;
CREATE VIEW analytics.v_delay_bins AS
SELECT
  *,
  CASE
    WHEN promise_slip_days IS NULL THEN NULL
    -- 0 이하는 정시/조기로 묶음.
    WHEN promise_slip_days <= 0 THEN 'on_time_or_early'
    WHEN promise_slip_days = 1 THEN 'late_1'
    WHEN promise_slip_days = 2 THEN 'late_2'
    WHEN promise_slip_days = 3 THEN 'late_3'
    ELSE 'late_4_plus'
  END AS slip_bin
FROM analytics.v_orders_base;

-- Segment 분석용 베이스 뷰 생성.
-- 가격/배송비 구간과 핵심 타깃 지표를 함께 제공함.
DROP VIEW IF EXISTS analytics.v_segment_base;
CREATE VIEW analytics.v_segment_base AS
SELECT
  purchase_month,
  customer_state,
  category_main,
  CASE
    WHEN price_total IS NULL THEN NULL
    -- 주문 금액 구간화를 통해 가격대별 비교가 가능함.
    WHEN price_total < 50 THEN 'p_0_50'
    WHEN price_total < 100 THEN 'p_50_100'
    WHEN price_total < 200 THEN 'p_100_200'
    WHEN price_total < 500 THEN 'p_200_500'
    ELSE 'p_500_plus'
  END AS price_band,
  CASE
    WHEN freight_total IS NULL THEN NULL
    -- 배송비 구간화를 통해 물류비 영향 비교가 가능함.
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
-- 실패 주문은 제외해 분석 일관성을 유지함.
WHERE failed_order_flag = 0;
