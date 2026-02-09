-- Create a set of views for consuming priority results.
-- Reuse consistently sorted outputs in analysis/dashboarding.
USE olist_portfolio;

-- Create view that surfaces high-opportunity segments first.
-- Sort by opportunity_score for execution prioritization.
DROP VIEW IF EXISTS analytics.v_priority_impact;
CREATE VIEW analytics.v_priority_impact AS
SELECT *
FROM analytics.segment_priority
ORDER BY opportunity_score DESC;

-- Create view that surfaces high delay-risk segments first.
-- Use delayed_rate with sample-size tie-break sorting.
DROP VIEW IF EXISTS analytics.v_priority_risk_delay;
CREATE VIEW analytics.v_priority_risk_delay AS
SELECT *
FROM analytics.segment_priority
ORDER BY delayed_rate DESC, orders_cnt DESC;

-- Create view that surfaces segments with strong delay-to-low-rating impact.
-- Prioritize low_rating_lift with sample-size tie-break for stable interpretation.
DROP VIEW IF EXISTS analytics.v_priority_risk_lift;
CREATE VIEW analytics.v_priority_risk_lift AS
SELECT *
FROM analytics.segment_priority
ORDER BY low_rating_lift DESC, orders_cnt DESC;
