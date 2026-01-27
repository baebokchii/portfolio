-- fact_orders QC 수행.
-- fact_orders는 모든 분석/대시보드의 단일 진실 소스이므로 결측/비정상/극단치 누락 시 신뢰도가 하락함.

-- 통과 기준
--delivered_still_early_cnt는 0이어야 한다
--estimated_still_early_cnt는 0이어야 한다
--promise_slip_days 분포가 상식적이어야 한다
--delayed_flag가 0과 1이 모두 존재해야 한다
--category_main 상위 항목에서 delayed_rate가 0 또는 1로만 쏠리지 않아야 한다

USE olist_portfolio;

-- 테이블 생성 여부와 기본 행 수 확인.
SELECT COUNT(*) AS fact_orders_cnt
FROM marts.fact_orders;

-- 핵심 결측/비정상 날짜 카운트 확인.
SELECT
  COUNT(*) AS total_cnt,
  SUM(delivered_customer_ts IS NULL) AS delivered_null_cnt,
  SUM(estimated_delivery_ts IS NULL) AS estimated_null_cnt,
  SUM(promise_slip_days IS NULL) AS slip_null_cnt,
  SUM(failed_order_flag = 1) AS failed_cnt,
  SUM(delivered_customer_ts < '2000-01-01') AS delivered_still_early_cnt,
  SUM(estimated_delivery_ts < '2000-01-01') AS estimated_still_early_cnt
FROM marts.fact_orders;

-- promise_slip_days 분포가 상식적인지 점검.
SELECT
  MIN(promise_slip_days) AS slip_min,
  MAX(promise_slip_days) AS slip_max,
  AVG(promise_slip_days) AS slip_avg
FROM marts.fact_orders
WHERE promise_slip_days IS NOT NULL;

-- 지연 플래그가 양/음 모두 존재하는지 확인.
SELECT
  delayed_flag,
  COUNT(*) AS cnt
FROM marts.fact_orders
WHERE delayed_flag IS NOT NULL
GROUP BY delayed_flag;

-- 카테고리별 지연율 쏠림 여부 확인.
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