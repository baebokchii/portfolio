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
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=jupyter&logoColor=white)

---

## Projects

### 1. 서울 카페 2호점 입지 분석

[프로젝트 보기](https://github.com/baebokchii/seoul-cafe-location-analysis), [최종 보고 덱](https://github.com/baebokchii/seoul-cafe-location-analysis/blob/main/reports/%EC%B9%B4%ED%8E%982%ED%98%B8%EC%A0%90_%EC%9E%85%EC%A7%80%EB%B6%84%EC%84%9D.pdf)

서울에서 직장인 대상 테이크아웃 카페 1곳을 운영하는 소규모 브랜드가 2호점을 어디에 내면 좋을지 공개 데이터로 분석했습니다. 핵심 지표는 새 매장이 평균적으로 가져갈 몫인 점포당 매출로 정했습니다. 수요, 경쟁, 비용, 지속성 네 축으로 가설 6개를 세우고 판정 기준은 데이터를 보기 전에 정했습니다.

원자료 7종을 PostgreSQL에 넣고 SQL로 정제와 결합을 했습니다. 데이터를 다루며 발견한 문제 13건은 원인을 확인한 뒤 처리 방법을 정했습니다. 모든 가설은 처리 방법을 바꿔 다시 돌려서 결론이 유지되는지 확인했습니다. 그 결과 직장인구, 지하철역, 발달상권이 점포당 매출과 관계가 있었고 카페가 많은 상권일수록 오히려 점포당 매출이 높았습니다.

검증 결과를 근거로 1,058개 상권을 6단계 기준으로 좁혀 을지로3가역, 강남구청역, 서초역 3곳을 후보로 제안했습니다. 대형 프랜차이즈와의 정면 경쟁을 피하도록 프랜차이즈 비중이 낮은 상권을 골랐습니다. 매장별 매출이 없는 한계는 현장 조사로 보완하자고 했습니다.

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
