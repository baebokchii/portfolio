# 4. 고객 지역별 배송 지연율과 평균 리뷰 점수
/*
해당 쿼리에서는 고객 지역 단위로 배송 성과 편차가 존재하는지 확인하고 지연율이 높은 지역에서 만족도도 낮은지 함께 확인하였습니다. 
total_orders에는 해당 지역의 총 주문 건수를 출력하였고, delayed_orders에는 해당 지역의 지연된 주문 건수를 출력하였습니다.
편차를 정규화 시키기 위해 지연율의 백분율을 delay_rate_pct에 출력하였고, avg_review_score에 지역별 평균 리뷰 점수를 출력하였습니다. 
마찬가지로 리뷰가 존재하는 주문만 포함시켰고, 표본의 신뢰도를 위해 총 주문 수 100건 미만의 지역은 제외하였습니다. 
*/
SELECT
  customer_state,
  COUNT(*) AS total_orders,
  SUM(is_delayed) AS delayed_orders,
  ROUND(SUM(is_delayed) / COUNT(*) * 100, 2) AS delay_rate_pct,
  AVG(review_score) AS avg_review_score
FROM
  `raw data`.v_analysis_base
WHERE
  review_score IS NOT NULL
GROUP BY
  customer_state
HAVING
  COUNT(*) >= 100
ORDER BY
  delay_rate_pct DESC;
