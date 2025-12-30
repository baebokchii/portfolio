# 주문 단위로 배송 지연 여부와 지연 일수, 고객 지역, 리뷰 점수를 결합한 분석 베이스를 생성합니다
CREATE VIEW `raw data`.v_analysis_base AS
WITH
  /*
  orders 테이블의 날짜 컬럼에 빈 문자열 ''이 있는 것을 확인했습니다. 
  그래서 NULLIF로 빈 문자열을 NULL로 바꾸고, STR_TO_DATE로 VARCHAR 형태의 날짜 포맷을 DATE로 파싱했습니다.
  */
  orders_base AS (
    SELECT
      o.order_id,
      o.customer_id,
      CASE
        WHEN NULLIF(o.order_delivered_customer_date, '') IS NULL THEN NULL
        WHEN LENGTH(NULLIF(o.order_delivered_customer_date, '')) = 10 THEN STR_TO_DATE(
          NULLIF(o.order_delivered_customer_date, ''),
          '%Y-%m-%d'
        )
      END AS delivered_customer_dt,
      CASE
        WHEN NULLIF(o.order_estimated_delivery_date, '') IS NULL THEN NULL
        WHEN LENGTH(NULLIF(o.order_estimated_delivery_date, '')) = 10 THEN STR_TO_DATE(
          NULLIF(o.order_estimated_delivery_date, ''),
          '%Y-%m-%d'
        )
      END AS estimated_delivery_dt
    FROM
      `raw data`.olist_orders_dataset o
  ),
  /*
  해당 쿼리에서는 파싱된 DATE를 기반으로 배송 지연 여부와 지연된 일수를 계산합니다. 
  만약 실제 배송일이 예상 배송일보다 늦게 된다면 is_delayed의 값이 1, 아니면 0으로 산출됩니다. 
  실제 배송일 - 예상 배송일의 일수 차이는 delay_days로 계산됩니다. 
  해당 쿼리에서는 실제 배송일과 예상 배송일이 모두 존재하는 주문만 포함됩니다.
  */
  orders_delay AS (
    SELECT
      ob.order_id,
      ob.customer_id,
      CASE
        WHEN ob.delivered_customer_dt IS NULL THEN NULL
        WHEN ob.estimated_delivery_dt IS NULL THEN NULL
        WHEN ob.delivered_customer_dt > ob.estimated_delivery_dt THEN 1
        ELSE 0
      END AS is_delayed,
      CASE
        WHEN ob.delivered_customer_dt IS NULL THEN NULL
        WHEN ob.estimated_delivery_dt IS NULL THEN NULL
        ELSE DATEDIFF(
          ob.delivered_customer_dt,
          ob.estimated_delivery_dt
        )
      END AS delay_days
    FROM
      orders_base ob
    WHERE
      ob.delivered_customer_dt IS NOT NULL
      AND ob.estimated_delivery_dt IS NOT NULL
  ),
  /*
  리뷰 테이블에는 한 개의 주문당 여러 개의 리뷰가 있을 수 있기 때문에 주문별로 대표 리뷰 1개를 선정했습니다. 
  리뷰가 쓰여진 날짜를 기준으로 가장 최신의 리뷰 1개를 대표로 사용하였습니다. 
  */
  review_one AS (
    SELECT
      r.order_id,
      r.review_score
    FROM
      `raw data`.olist_order_reviews_dataset r
      JOIN (
        SELECT
          order_id,
          MAX(review_creation_date) AS max_review_creation_date
        FROM
          `raw data`.olist_order_reviews_dataset
        GROUP BY
          order_id
      ) x ON r.order_id = x.order_id
      AND r.review_creation_date = x.max_review_creation_date
  ),
  /*
  주문의 customer_id를 고객 테이블과 결합해 고객의 지역 정보(주, 도시)를 가져왔습니다.  
  */
  customer_region AS (
    SELECT
      c.customer_id,
      c.customer_state,
      c.customer_city
    FROM
      `raw data`.olist_customers_dataset c
  )
  /*
  위에서 생성한 order_delays와 customer_region은 INNER JOIN을 실시하였고,
  리뷰는 없는 주문이 있어도 남겨야 하므로 order_delays를 기준으로 LEFT JOIN을 실시하였습니다.
  조인한 결과로 주문ID, 배송 지연 여부, 지연 일수, 고객 지역, 리뷰 점수를 포함한 뷰를 최종 완성했습니다. 
  */
SELECT
  d.order_id,
  d.is_delayed,
  d.delay_days,
  cr.customer_state,
  cr.customer_city,
  rv.review_score
FROM
  orders_delay d
  JOIN customer_region cr ON d.customer_id = cr.customer_id
  LEFT JOIN review_one rv ON d.order_id = rv.order_id;
