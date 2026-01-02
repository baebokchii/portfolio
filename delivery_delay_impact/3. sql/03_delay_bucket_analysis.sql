# 3. 배송 지연 일수 구간별 평균 리뷰 점수 비교
/*
해당 쿼리에서는 2번 쿼리의 결과를 더 깊게 파고들어 지연 기간이 길수록 만족도가 더 낮아지는지 확인하였습니다.
delay_days를 통해 구간을 정하였고, 값이 0과 같거나 작다면 정상 배송,
1-3 사이면 경미한 지연, 4-7 사이면 중간 지연, 8 이상이면 심각한 지연으로 판단하였습니다.
해당 쿼리 역시 리뷰가 존재하는 주문만 비교를 진행하였습니다. 
*/
SELECT
  CASE
    WHEN delay_days <= 0 THEN 'On time or early'
    WHEN delay_days BETWEEN 1 AND 3  THEN 'Delay 1-3 days'
    WHEN delay_days BETWEEN 4 AND 7  THEN 'Delay 4-7 days'
    ELSE 'Delay 8+ days'
  END AS delay_bucket,
  COUNT(*) AS orders,
  AVG(review_score) AS avg_review_score
FROM
  `raw data`.v_analysis_base
WHERE
  review_score IS NOT NULL
GROUP BY
  delay_bucket
ORDER BY
  CASE delay_bucket
    WHEN 'On time or early' THEN 1
    WHEN 'Delay 1-3 days' THEN 2
    WHEN 'Delay 4-7 days' THEN 3
    ELSE 4
  END;
