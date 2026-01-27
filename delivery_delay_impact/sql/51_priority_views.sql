-- 우선순위 결과를 소비하기 위한 뷰 모음 생성함.
-- 분석/대시보드에서 동일 기준으로 정렬된 결과를 재사용하게 함.
USE olist_portfolio;

-- 개선 여지가 큰 세그먼트를 상단에 노출하는 뷰 생성함.
-- opportunity_score 기준으로 정렬해 실행 우선순위 판단에 사용함.
DROP VIEW IF EXISTS analytics.v_priority_impact;
CREATE VIEW analytics.v_priority_impact AS
SELECT *
FROM analytics.segment_priority
ORDER BY opportunity_score DESC;

-- 지연 리스크가 큰 세그먼트를 상단에 노출하는 뷰 생성함.
-- delayed_rate와 표본 규모를 함께 고려하도록 보조 정렬을 두었음.
DROP VIEW IF EXISTS analytics.v_priority_risk_delay;
CREATE VIEW analytics.v_priority_risk_delay AS
SELECT *
FROM analytics.segment_priority
ORDER BY delayed_rate DESC, orders_cnt DESC;

-- 지연이 저평점에 미치는 영향이 큰 세그먼트를 상단에 노출하는 뷰 생성함.
-- low_rating_lift 우선, 표본 규모 보조 정렬로 해석 안정성 확보함.
DROP VIEW IF EXISTS analytics.v_priority_risk_lift;
CREATE VIEW analytics.v_priority_risk_lift AS
SELECT *
FROM analytics.segment_priority
ORDER BY low_rating_lift DESC, orders_cnt DESC;
