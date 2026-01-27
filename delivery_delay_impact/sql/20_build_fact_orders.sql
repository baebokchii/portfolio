-- 주문 분석용 마트/팩트 테이블 생성.
USE olist_portfolio;

-- 주문 아이템 집계 테이블 생성.
DROP TABLE IF EXISTS marts.orders_items_agg;
CREATE TABLE marts.orders_items_agg AS
SELECT
  oi.order_id,
  COUNT(*) AS item_count,
  COUNT(DISTINCT oi.product_id) AS product_count,
  COUNT(DISTINCT oi.seller_id) AS seller_count,
  SUM(oi.price) AS price_total,
  SUM(oi.freight_value) AS freight_total
FROM raw.olist_order_items oi
GROUP BY oi.order_id;

-- 주문 대표 카테고리 집계 테이블 생성.
DROP TABLE IF EXISTS marts.orders_category_agg;
CREATE TABLE marts.orders_category_agg AS
SELECT
  oi.order_id,
  SUBSTRING_INDEX(
    GROUP_CONCAT(
      COALESCE(t.product_category_name_english, p.product_category_name)
      SEPARATOR ','
    ),
    ',',
    1
  ) AS category_main
FROM raw.olist_order_items oi
LEFT JOIN raw.olist_products p
  ON p.product_id = oi.product_id
LEFT JOIN raw.product_category_name_translation t
  ON t.product_category_name = p.product_category_name
GROUP BY oi.order_id;

-- 결제 집계 테이블 생성.
DROP TABLE IF EXISTS marts.orders_payments_agg;
CREATE TABLE marts.orders_payments_agg AS
SELECT
  op.order_id,
  SUM(op.payment_value) AS payment_value_total,
  MAX(op.payment_installments) AS installments_max,
  SUBSTRING_INDEX(
    GROUP_CONCAT(op.payment_type ORDER BY op.payment_value DESC SEPARATOR ','),
    ',',
    1
  ) AS payment_type_main
FROM raw.olist_order_payments op
GROUP BY op.order_id;

-- 리뷰 집계 테이블 생성.
DROP TABLE IF EXISTS marts.orders_reviews_agg;
CREATE TABLE marts.orders_reviews_agg AS
SELECT
  r.order_id,
  AVG(r.review_score) AS review_score_avg,
  MAX(r.review_score) AS review_score_max,
  SUM(CASE WHEN r.review_score IN (1,2) THEN 1 ELSE 0 END) AS low_rating_cnt,
  MAX(CHAR_LENGTH(COALESCE(r.review_comment_message, ''))) AS review_comment_len_max
FROM raw.olist_order_reviews r
GROUP BY r.order_id;

-- 주문 팩트 테이블 생성.
DROP TABLE IF EXISTS marts.fact_orders;
CREATE TABLE marts.fact_orders AS
WITH orders_clean AS (
  -- 이상치 날짜를 NULL로 정규화해 리드타임 계산 오류를 방지.
  SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    CASE WHEN o.order_purchase_timestamp < '2000-01-01' THEN NULL ELSE o.order_purchase_timestamp END AS purchase_ts,
    CASE WHEN o.order_approved_at < '2000-01-01' THEN NULL ELSE o.order_approved_at END AS approved_ts,
    CASE WHEN o.order_delivered_carrier_date < '2000-01-01' THEN NULL ELSE o.order_delivered_carrier_date END AS delivered_carrier_ts,
    CASE WHEN o.order_delivered_customer_date < '2000-01-01' THEN NULL ELSE o.order_delivered_customer_date END AS delivered_customer_ts,
    CASE WHEN o.order_estimated_delivery_date < '2000-01-01' THEN NULL ELSE o.order_estimated_delivery_date END AS estimated_delivery_ts
  FROM raw.olist_orders o
)
-- 주문 단위로 고객/결제/리뷰/아이템/카테고리 정보를 결합.
SELECT
  oc.order_id,
  oc.customer_id,
  c.customer_unique_id,
  c.customer_state,
  c.customer_city,
  oc.order_status,
  oc.purchase_ts,
  oc.approved_ts,
  oc.delivered_carrier_ts,
  oc.delivered_customer_ts,
  oc.estimated_delivery_ts,
  -- 주문 아이템 요약 지표 연결.
  ia.item_count,
  ia.product_count,
  ia.seller_count,
  ia.price_total,
  ia.freight_total,
  -- 대표 카테고리/결제/리뷰 요약 지표 연결.
  ca.category_main,
  pa.payment_value_total,
  pa.installments_max,
  pa.payment_type_main,
  ra.review_score_avg,
  ra.review_score_max,
  ra.low_rating_cnt,
  ra.review_comment_len_max,
  -- 구매~배송 리드타임(일) 계산.
  CASE
    WHEN oc.purchase_ts IS NULL OR oc.delivered_customer_ts IS NULL THEN NULL
    ELSE DATEDIFF(oc.delivered_customer_ts, oc.purchase_ts)
  END AS lead_time_days,
  -- 승인~배송 소요(일) 계산.
  CASE
    WHEN oc.approved_ts IS NULL OR oc.delivered_customer_ts IS NULL THEN NULL
    ELSE DATEDIFF(oc.delivered_customer_ts, oc.approved_ts)
  END AS ship_time_days,
  -- 예상 대비 지연(일) 계산. (+면 지연, -면 조기)
  CASE
    WHEN oc.delivered_customer_ts IS NULL OR oc.estimated_delivery_ts IS NULL THEN NULL
    ELSE DATEDIFF(oc.delivered_customer_ts, oc.estimated_delivery_ts)
  END AS promise_slip_days,
  -- 지연/정시/조기 플래그 산출.
  CASE
    WHEN oc.delivered_customer_ts IS NULL OR oc.estimated_delivery_ts IS NULL THEN NULL
    WHEN DATEDIFF(oc.delivered_customer_ts, oc.estimated_delivery_ts) > 0 THEN 1
    ELSE 0
  END AS delayed_flag,
  CASE
    WHEN oc.delivered_customer_ts IS NULL OR oc.estimated_delivery_ts IS NULL THEN NULL
    WHEN DATEDIFF(oc.delivered_customer_ts, oc.estimated_delivery_ts) <= 0 THEN 1
    ELSE 0
  END AS on_time_flag,
  CASE
    WHEN oc.delivered_customer_ts IS NULL OR oc.estimated_delivery_ts IS NULL THEN NULL
    WHEN DATEDIFF(oc.delivered_customer_ts, oc.estimated_delivery_ts) < 0 THEN 1
    ELSE 0
  END AS early_flag,
  -- 취소/배송불가 주문 플래그 산출.
  CASE
    WHEN oc.order_status IN ('canceled','unavailable') THEN 1
    ELSE 0
  END AS failed_order_flag
FROM orders_clean oc
LEFT JOIN raw.olist_customers c
  ON c.customer_id = oc.customer_id
LEFT JOIN marts.orders_items_agg ia
  ON ia.order_id = oc.order_id
LEFT JOIN marts.orders_category_agg ca
  ON ca.order_id = oc.order_id
LEFT JOIN marts.orders_payments_agg pa
  ON pa.order_id = oc.order_id
LEFT JOIN marts.orders_reviews_agg ra
  ON ra.order_id = oc.order_id;
