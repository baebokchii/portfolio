# 배현진의 포트폴리오

[![Email](https://img.shields.io/badge/Email-alexbaehj%40gmail.com-D14836?style=flat&logo=gmail&logoColor=white)](mailto:alexbaehj@gmail.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-hjbae01-0A66C2?style=flat&logo=linkedin&logoColor=white)](https://linkedin.com/in/hjbae01/)

각 프로젝트는 문제 정의부터 데이터 수집, 분석, 실행까지 전 과정을 직접 진행했습니다.

---

## Tech Stack

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![Google Ads](https://img.shields.io/badge/Google%20Ads-4285F4?style=flat&logo=googleads&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=flat&logo=tableau&logoColor=white)
![Google Apps Script](https://img.shields.io/badge/Google%20Apps%20Script-4285F4?style=flat&logo=google&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?logo=postgresql&logoColor=white)
![scikit-learn](https://img.shields.io/badge/scikit--learn-F7931E?style=flat&logo=scikitlearn&logoColor=white)

---

## Projects

### 1. 서울 카페 2호점 입지 분석

[프로젝트 보기](https://github.com/baebokchii/seoul-cafe-location-analysis), [최종 보고 덱](https://drive.google.com/file/d/1n-jlz8ytddXTOGtbEzjg0yTgr7pecASk/view?usp=sharing)

서울시 상권분석서비스 공공데이터(2021년 1분기 ~ 2026년 2분기)로 "카페 2호점을 서울 어느 상권에 내야 하는가"에 답한 프로젝트입니다. 손님이 2년 동안 꾸준히 늘었는지, 카페 한 곳이 받는 손님이 많은지, 임대료를 감당할 수 있는지를 기준으로 상권 3곳을 추천하고, 그 3곳의 다음 1년 매출과 손님을 예측했습니다.

데이터를 PostgreSQL에 적재한 뒤 CTE와 윈도 함수(`LAG`, `PERCENT_RANK`)로 992개 상권의 추천 지표를 계산했습니다. 상권 하나에는 22개 분기 데이터밖에 없어서 916개 상권을 함께 학습하는 예측 모델을 만들고, 시점을 고정한 백테스트로 계절 단순 예측과 비교해 검증했습니다.

**핵심 결과**
- 추천 3곳은 공릉역(노원구), 대치역(강남구), 방이역(송파구)입니다. 2년 사이 카페 손님은 25 ~ 50% 늘고 카페 수는 그대로이거나 줄어, 카페 한 곳이 받는 손님이 53 ~ 90% 늘었습니다.
- 다음 1년 손님은 세 곳 모두 지금 수준을 유지할 것으로 예측했습니다. 매출은 대치역과 방이역이 지금 수준을 유지하고, 공릉역은 객단가가 되돌아갈 위험이 있습니다(−24%).
- 예측 모델은 916개 상권 전체에서 계절 단순 예측보다 오차(WAPE)가 1 ~ 2%p 낮았습니다. 다만 상권 하나의 1년 뒤 예측은 범위가 넓어서, 숫자보다 방향을 보는 자료로 제시했습니다.

### 2. Google SERP 커뮤니티 서비스 마케팅 분석 (홍콩)

[프로젝트 보기](https://github.com/baebokchii/google_serp_marketing)

홍콩 사이쿵구 커뮤니티센터(SKDCC)가 운영하는 세 가지 서비스(노인 서비스, 비중국어권 학생 지원 서비스, 특수 교육)의 구글 검색 노출을 개선하기 위해 진행한 프로젝트입니다.

광고 집행에서 끝내지 않고 검색 의도 기반 키워드 설계, 광고 카피 A/B 테스트, 캠페인 성과 분석을 하나의 루프로 연결해서 진행했습니다. 분석에는 Google Ads 캠페인 데이터(노출수, 클릭수, CTR, 비용, 키워드/광고그룹별 지표)와 검색 노출 결과를 사용했습니다.

**핵심 결과**
- 서비스 유형별로 CTR 차이가 뚜렷하게 나타났습니다.
- SEN 관련 키워드와 광고 카피가 상대적으로 높은 참여율을 보였습니다.
- ADHD처럼 문제를 이미 인지한 상태에서 검색하는 키워드는 짧은 테스트 기간에도 강한 CTR을 기록했습니다.
- 중국어와 영어 광고 간 반응 패턴이 서로 다르게 나타났습니다.

자세한 분석 내용은 [insights.md](https://github.com/baebokchii/google_serp_marketing/blob/main/insights.md)에서 확인할 수 있습니다.

### 3. 러닝 기록 자동화 대시보드

[프로젝트 보기](https://github.com/baebokchii/RunningLog), [대시보드 보기](https://public.tableau.com/views/RunningLogDashboard/RunningLog)

애플워치에 쌓인 개인 러닝 기록을 구글 시트와 Tableau 대시보드로 자동 업데이트하는 개인 데이터 파이프라인을 구축했습니다.

아이폰 건강 앱에서 내보낸 기록을 launchd가 감지하면 Python 스크립트가 데이터를 정리하고, 구글 시트에 없는 기록만 골라서 업로드합니다. Tableau Public이 구글 시트를 하루 한 번 동기화하는 구조로, 수집부터 시각화까지 전 과정을 직접 설계하고 자동화했습니다.

---

## Education

**Hong Kong University of Science and Technology (홍콩과학기술대학교)**
BBA in Management, BBA in Information Systems (Double Major), Class of 2025

경영학 학사, 정보시스템 학사 (복수 전공), 2025년 1월 졸업

---

## Contact

[Email](mailto:alexbaehj@gmail.com), [LinkedIn](https://linkedin.com/in/hjbae01/)
