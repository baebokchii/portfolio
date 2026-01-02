# 2. 배송 지연 여부에 따른 평균 리뷰 점수 비교
/*
해당 쿼리에서는 앞서 생성한 뷰를 기반으로 배송이 지연된 주문과 정상 배송 주문의 평균 리뷰 점수를 비교했습니다. 
리뷰가 존재하는 주문만 비교를 실시하였고, is_delayed별 주문 수와 평균 리뷰 점수를 반환하였습니다. 
*/
SELECT
  is_delayed,
  COUNT(*) AS orders,
  AVG(review_score) AS avg_review_score
FROM
  `raw data`.v_analysis_base
WHERE
  review_score IS NOT NULL
GROUP BY
  is_delayed;
