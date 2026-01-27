# Olist 배송 약속 영향 분석 (포트폴리오)

배송 약속 준수율(예상 배송일 vs 실제 배송일)을 기준으로 지연이 고객 만족에 미치는 영향을 정량화하고, 개선 우선순위를 도출한 데이터 분석가 포트폴리오입니다. **문제 정의 → 지표 설계 → 재현 가능한 파이프라인 → 액션 인사이트** 흐름으로 수행하였습니다.

## 프로젝트 한눈에 보기
- 목표: 배송 지연이 리뷰/저평점에 미치는 영향을 수치화하고, 우선 개선 세그먼트를 제안
- 데이터: Olist Brazilian E-Commerce Public Dataset (Kaggle)
- 범위: 약속 배송일/실제 배송일이 존재하는 주문; 취소/배송불가 주문 제외
- 스택: MySQL 8, SQL, Tableau(또는 BI)
- 산출물: `marts.fact_orders`, `analytics` 뷰, 우선순위 테이블, `results/` CSV

## 문제 정의
- 배송 약속을 어긴 주문은 저평점 비율을 얼마나 증가시키는가?
- 어떤 지역 x 카테고리를 먼저 개선해야 리뷰 악화를 가장 많이 줄일 수 있는가?

## 핵심 지표 정의
| 지표 | 정의 |
| --- | --- |
| `promise_slip_days` | `DATEDIFF(delivered_customer_ts, estimated_delivery_ts)`; 양수면 지연 |
| `delayed_flag` | 1 if `promise_slip_days > 0`, else 0 |
| `on_time_flag` | 1 if `promise_slip_days <= 0`, else 0 |
| `early_flag` | 1 if `promise_slip_days < 0`, else 0 |
| `low_rating_flag` | 1 if `review_score_avg <= 2`, else 0 |
| `failed_order_flag` | 1 if `order_status` in (`canceled`, `unavailable`), else 0 |
| `opportunity_score` | `low_rating_lift * orders_cnt` (높을수록 개선 여지 큼) |

## 데이터 파이프라인
```text
raw CSV (raw.*)
  -> marts.fact_orders
  -> analytics views (v_orders_base, v_delay_bins, v_segment_base)
  -> analytics.segment_priority + CSV exports (results/)
```

## Tableau용 ERD (관계도)
Tableau에서는 **order-level 뷰와 segment-level 뷰를 분리**하는 것이 안전합니다.

주문 단위 분석용 데이터 소스:
```
analytics.v_orders_base  (PK: order_id)
        |
        |-- analytics.v_delay_bins   (PK: order_id)
        |
        |-- analytics.v_segment_base (PK: order_id)
```

우선순위/리스크 탭 전용 데이터 소스:
```
analytics.v_priority_impact
```
- `v_priority_*`는 동일 데이터의 정렬만 다르므로 **하나만 사용**하고 시트에서 정렬 기준을 바꿉니다.

## 결과 하이라이트
- 우선순위 기회는 SP 지역의 고거래량 카테고리에 집중됨.
- 지연 위험이 높은 세그먼트는 RJ/BA 지역의 전자/유아/통신 카테고리에 많음.
- 일부 세그먼트는 지연 시 저평점 리프트가 매우 큼.

## 임팩트 추정 (지연 개선 시 저평점 감소량)
지연 주문을 온타임으로 개선한다고 가정할 때, 예상 저평점 감소량은 아래와 같이 계산했습니다.
`preventable_low_ratings = low_rating_lift * delayed_rate * orders_cnt`

상위 세그먼트(예시):
| customer_state   | category_main         |   orders_cnt |   delayed_rate |   low_rating_lift |   preventable_low_ratings |
|:-----------------|:----------------------|-------------:|---------------:|------------------:|--------------------------:|
| RJ               | bed_bath_table        |         1308 |          0.148 |             0.606 |                     117.5 |
| SP               | health_beauty         |         3654 |          0.053 |             0.434 |                      84.7 |
| SP               | bed_bath_table        |         4220 |          0.04  |             0.462 |                      78.1 |
| RJ               | sports_leisure        |          877 |          0.14  |             0.619 |                      76.1 |
| SP               | sports_leisure        |         3168 |          0.044 |             0.504 |                      69.6 |
| RJ               | computers_accessories |          810 |          0.121 |             0.67  |                      65.7 |
| RJ               | furniture_decor       |          800 |          0.121 |             0.617 |                      59.9 |
| RJ               | watches_gifts         |          770 |          0.139 |             0.556 |                      59.5 |
| SP               | housewares            |         2669 |          0.04  |             0.54  |                      57.8 |
| SP               | furniture_decor       |         2599 |          0.047 |             0.473 |                      57.6 |

기회 우선순위(Top 10):
| customer_state   | category_main         |   orders_cnt |   delayed_rate |   low_rating_lift |   opportunity_score |
|:-----------------|:----------------------|-------------:|---------------:|------------------:|--------------------:|
| SP               | bed_bath_table        |         4220 |          0.04  |             0.462 |              1951.3 |
| SP               | sports_leisure        |         3168 |          0.044 |             0.504 |              1596   |
| SP               | health_beauty         |         3654 |          0.053 |             0.434 |              1586.9 |
| SP               | housewares            |         2669 |          0.04  |             0.54  |              1442.1 |
| SP               | furniture_decor       |         2599 |          0.047 |             0.473 |              1228.8 |
| SP               | watches_gifts         |         2065 |          0.048 |             0.503 |              1038.5 |
| SP               | computers_accessories |         2576 |          0.042 |             0.395 |              1017.5 |
| RJ               | bed_bath_table        |         1308 |          0.148 |             0.606 |               792.1 |
| SP               | toys                  |         1547 |          0.04  |             0.502 |               776.4 |
| SP               | auto                  |         1567 |          0.054 |             0.458 |               718   |

## 재현 방법
1. 스키마 생성: `sql/00_init.sql`
2. Raw 테이블 생성: `sql/10_create_raw_tables.sql`
3. CSV 로딩: `sql/01_load_raw.sql` (절대 경로 수정)
4. 마트 생성: `sql/20_build_fact_orders.sql`
5. QC 실행: `sql/21_qc_fact_orders.sql`
6. 분석 뷰 생성: `sql/30_build_analytics_views.sql`
7. 분석/스코어링: `sql/40_result_delay_vs_review.sql`, `sql/41_state_pair_analysis.sql`, `sql/50_priority_scoring.sql`, `sql/51_priority_views.sql`

## 레포 구조
```text
data_dictionary/  # 핵심 필드 및 정의
sql/              # 파이프라인 및 분석 SQL
results/          # 분석 결과 CSV
dashboard/        # 대시보드 산출물/메모
```

## 가정과 한계
- 저평점은 `review_score_avg <= 2` 기준으로 정의했습니다.
- 복수 판매자 주문은 customer_state x seller_state 페어에 중복 집계됩니다.
- 본 분석은 설명적 결과이며, 추후 가격/카테고리/시즌성 통제 분석으로 확장 가능합니다.

## 데이터 출처
- Olist Brazilian E-Commerce Public Dataset: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
