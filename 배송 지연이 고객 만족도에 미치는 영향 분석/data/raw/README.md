# Raw Data

## 데이터 출처
본 프로젝트에서 사용한 데이터는 Kaggle에 공개된
Brazilian E-Commerce Public Dataset by Olist 데이터셋입니다. 

- 출처 링크
  https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
- 데이터 제공 주체
  Olist (Brazilian e-commerce platform)

## 데이터 개요
해당 데이터셋은 2016년부터 2018년까지의 브라질 이커머스 주문 데이터를 포함하고 있으며,
주문, 배송, 고객, 판매자, 결제, 리뷰 등 이커머스 운영 전반을 분석할 수 있는 구조를 지니고 있습니다.

본 프로젝트에서는 배송 지연과 고객 만족도 간의 관계를 분석하기 위해
주문 단위 데이터와 배송 일정, 고객 리뷰 데이터를 중심으로 활용하였습니다.

## 원본 데이터 처리 원칙
본 프로젝트에서는 원본 데이터의 구조와 의미를 최대한 유지하는 것을 원칙으로 하였습니다.
다만 GitHub 저장소 업로드 용량 제한으로 인해, 분석 목적과 직접적인 관련이 없는 일부 컬럼은 제거한 후 raw 데이터로 관리하였습니다.

삭제된 컬럼은 다음과 같습니다.

- olist_geolocation_dataset  
  - geolocation_lat  
  - geolocation_lng  

  위 컬럼들은 위도 및 경도 정보로, 지도 시각화 또는 거리 계산 분석에 활용될 수 있으나, 본 프로젝트의 배송 지연 및 고객 만족도 분석 범위에는 포함되지 않아 제거하였습니다.

- olist_order_reviews_dataset  
  - review_comment_title  
  - review_comment_message  

  위 컬럼들은 텍스트 리뷰 내용으로, 감성 분석 등 자연어 처리 분석에 활용 가능하나, 본 프로젝트에서는 리뷰 점수(review_score)를 기준으로 고객 만족도를 정의하였기 때문에 분석 범위에서 제외하였습니다.

**컬럼 삭제는 저장 용량 제한을 고려한 조치이며, 분석에 사용된 모든 핵심 컬럼과 지표의 정의에는 영향을 미치지 않습니다.**
