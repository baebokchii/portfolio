# 데이터 사전 (Data Dictionary)

이 프로젝트는 주문 단위 팩트 테이블(`marts.fact_orders`)을 중심으로 분석합니다.

## marts.fact_orders
| 컬럼 | 설명 |
| --- | --- |
| `order_id` | 주문 ID |
| `customer_id` | 고객 ID |
| `customer_unique_id` | 고객 통합 ID |
| `customer_state` | 고객 주(지역) |
| `customer_city` | 고객 도시 |
| `order_status` | 주문 상태 |
| `purchase_ts` | 구매 시각 |
| `approved_ts` | 승인 시각 |
| `delivered_carrier_ts` | 택배사 인계 시각 |
| `delivered_customer_ts` | 고객 배송 완료 시각 |
| `estimated_delivery_ts` | 예상 배송일 |
| `item_count` | 주문 아이템 수 |
| `product_count` | 상품 수 |
| `seller_count` | 판매자 수 |
| `price_total` | 주문 금액 합계 |
| `freight_total` | 배송비 합계 |
| `category_main` | 대표 카테고리 |
| `payment_value_total` | 결제 금액 합계 |
| `installments_max` | 최대 할부 개월 |
| `payment_type_main` | 주요 결제 수단 |
| `review_score_avg` | 평균 리뷰 점수 |
| `review_score_max` | 최대 리뷰 점수 |
| `low_rating_cnt` | 저평점(1-2) 수 |
| `review_comment_len_max` | 리뷰 코멘트 최대 길이 |
| `lead_time_days` | 구매~배송 리드타임(일) |
| `ship_time_days` | 승인~배송 리드타임(일) |
| `promise_slip_days` | 실제 - 예상 배송일(일) |
| `delayed_flag` | 지연 여부 |
| `on_time_flag` | 정시/조기 여부 |
| `early_flag` | 조기 여부 |
| `failed_order_flag` | 취소/배송불가 여부 |

## analytics.v_orders_base
| 컬럼 | 설명 |
| --- | --- |
| `low_rating_flag` | 평균 리뷰가 2 이하이면 1 |
| `purchase_month` | 구매 월(YYYY-MM-01) |

## analytics.v_segment_base
| 컬럼 | 설명 |
| --- | --- |
| `price_band` | 가격 구간 |
| `freight_band` | 배송비 구간 |

## analytics.segment_priority
| 컬럼 | 설명 |
| --- | --- |
| `orders_cnt` | 세그먼트 주문 수 |
| `delayed_rate` | 지연율 |
| `low_rating_rate` | 저평점율 |
| `low_rating_rate_delayed` | 지연 시 저평점율 |
| `low_rating_rate_on_time` | 온타임 저평점율 |
| `low_rating_lift` | 저평점율 차이 |
| `opportunity_score` | 개선 우선순위 점수 |
