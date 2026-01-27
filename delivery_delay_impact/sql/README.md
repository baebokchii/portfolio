# SQL 파이프라인

이 폴더는 포트폴리오 전 과정을 재현할 수 있는 SQL 워크플로우를 포함합니다.

## 요구 사항
- MySQL 8.x
- `local_infile` 활성화 (`LOAD DATA LOCAL INFILE` 사용)

## 실행 순서
1. `sql/00_init.sql` - 데이터베이스/스키마 생성
2. `sql/10_create_raw_tables.sql` - Raw 테이블 생성
3. `sql/01_load_raw.sql` - CSV 로딩 (절대 경로 수정)
4. `sql/20_build_fact_orders.sql` - `marts.fact_orders` 생성
5. `sql/21_qc_fact_orders.sql` - 데이터 품질(QC) 점검
6. `sql/30_build_analytics_views.sql` - 분석용 뷰 생성
7. `sql/40_result_delay_vs_review.sql` - 지연 vs 리뷰 요약
8. `sql/41_state_pair_analysis.sql` - 고객/판매자 지역 페어 분석
9. `sql/50_priority_scoring.sql` - 세그먼트 우선순위 스코어링
10. `sql/51_priority_views.sql` - 대시보드용 뷰

## 결과 오브젝트
- `raw.*` - 원천 CSV 테이블
- `marts.fact_orders` - 주문 단위 팩트 테이블
- `analytics.v_orders_base` - 공통 분석 베이스
- `analytics.v_delay_bins` - 지연 구간화 뷰
- `analytics.v_segment_base` - 세그먼트 분석 베이스
- `analytics.segment_priority` - 세그먼트 우선순위 테이블
- `analytics.v_priority_*` - 대시보드용 우선순위 뷰

## 결과물 내보내기
SQL 클라이언트에서 SELECT 결과를 CSV로 저장해 `results/`에 보관합니다.
(예: MySQL Workbench 또는 `INTO OUTFILE` 사용)
