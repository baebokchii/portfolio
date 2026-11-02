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
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=flat&logo=postgresql&logoColor=white)

---

## Projects

### 1. 서울 카페 2호점 입지 분석

[프로젝트 보기](https://github.com/baebokchii/seoul-cafe-location-analysis), [최종 보고 덱](https://github.com/baebokchii/seoul-cafe-location-analysis/blob/main/reports/%EC%B5%9C%EC%A2%85%EB%B3%B4%EA%B3%A0_%EC%B9%B4%ED%8E%982%ED%98%B8%EC%A0%90.pdf)

서울시 상권분석서비스 공공데이터(2021년 1분기 ~ 2026년 2분기)와 한국부동산원 임대료로 "카페 2호점을 서울 어느 상권에 내야 하는가"에 답한 컨설팅 프로젝트입니다. 문제 정의 → MECE 이슈 트리 → 가설 설정 → 분석 → 피라미드 구조의 보고서 순서로 진행했습니다.

핵심 질문을 수요·경쟁·수익성(매출·임대료)·지속성으로 나누고, 갈래마다 가설을 세워 데이터로 검증했습니다. 데이터를 PostgreSQL에 적재한 뒤 CTE와 윈도 함수(`LAG`)로 992개 상권의 지표를 계산하고, 5단계 거르기와 3개 점수(성장·손님·수익), 임대료 조건으로 후보를 좁혔습니다. 다음 1년 예측은 단순한 규칙 두 개를 과거 세 시점에서 백테스트해 더 정확한 쪽을 썼습니다.

**핵심 결과**
- 추천 3곳은 대치역(강남구), 방이역(송파구), 천호역(강동구)입니다. 서울 카페 손님이 2년째 정체(−1.8%)인 동안 세 곳의 손님은 24.5 ~ 80.4% 늘었고, 카페 한 곳이 받는 손님도 53.2 ~ 77.1% 늘었습니다.
- 점수로는 앞섰던 도심 상권 2곳(북창동·북촌)은 임대료가 서울 평균의 1.8배를 넘어 제외했습니다. 추천 3곳의 임대료는 서울 평균의 0.85 ~ 1.22배입니다.
- 백테스트 6번 모두 "작년 × (1 + 성장률)"보다 "작년과 같음"이 더 정확해(오차율 중앙값 14.9 ~ 17.5%), 세 곳 모두 다음 1년은 현재 수준이 유지될 것으로 예측했습니다. 곳마다 위험(폐점 원인, 가격 경쟁, 낮은 매출)이 달라 계약 전 3개월의 확인 과제를 함께 권고했습니다.

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
