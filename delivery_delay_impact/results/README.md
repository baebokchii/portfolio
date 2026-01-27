# Results

이 폴더는 포트폴리오 서술과 대시보드에 사용하는 결과 CSV를 보관합니다.

## 파일 목록
- `results/priority_impact_top30.csv` - `opportunity_score` 상위 30개 세그먼트
- `results/priority_risk_delay_top30.csv` - `delayed_rate` 상위 30개 세그먼트
- `results/priority_risk_lift_top30.csv` - `low_rating_lift` 상위 30개 세그먼트
- `results/state_pair_delay_top50.csv` - `delayed_rate` 상위 30개 customer_state x seller_state 페어
- `results/state_pair_volume_top50.csv` - `orders_cnt` 상위 30개 페어

## 공통 컬럼
- `orders_cnt`: 세그먼트/페어 주문 수
- `delayed_rate`: 지연 주문 비율 (`delayed_flag = 1`)
- `low_rating_rate`: 저평점 비율 (`review_score_avg <= 2`)
- `low_rating_lift`: 지연 vs 온타임 저평점률 차이
- `opportunity_score`: `low_rating_lift * orders_cnt`

## 참고
- 세그먼트 결과는 `sql/50_priority_scoring.sql`, `sql/51_priority_views.sql`에서 생성됩니다.
- state-pair 결과는 `sql/41_state_pair_analysis.sql`에서 생성되며, 리뷰 없는 주문은 제외됩니다.
- 일부 CSV의 `category_main`에는 캐리지리턴이 포함될 수 있어 필요 시 trim을 권장합니다.
