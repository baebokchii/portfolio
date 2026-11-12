# 배현진의 포트폴리오

[![Email](https://img.shields.io/badge/Email-alexbaehj%40gmail.com-D14836?style=flat&logo=gmail&logoColor=white)](mailto:alexbaehj@gmail.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-hjbae01-0A66C2?style=flat&logo=linkedin&logoColor=white)](https://linkedin.com/in/hjbae01/)

## Tech Stack

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![Google Ads](https://img.shields.io/badge/Google%20Ads-4285F4?style=flat&logo=googleads&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=flat&logo=tableau&logoColor=white)
![Google Apps Script](https://img.shields.io/badge/Google%20Apps%20Script-4285F4?style=flat&logo=google&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=flat&logo=postgresql&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=jupyter&logoColor=white)
![Google Gemini](https://img.shields.io/badge/Google%20Gemini-8E75B2?style=flat&logo=googlegemini&logoColor=white)
![Claude Code](https://img.shields.io/badge/Claude_Code-555?logo=claude)

---

## Projects

### 1. 서울 카페 2호점 입지 분석

[프로젝트 보기](https://github.com/baebokchii/seoul-cafe-location-analysis), [최종 보고 덱](https://github.com/baebokchii/seoul-cafe-location-analysis/blob/main/reports/%EC%B9%B4%ED%8E%982%ED%98%B8%EC%A0%90_%EC%9E%85%EC%A7%80%EB%B6%84%EC%84%9D.pdf)

서울에서 직장인 대상 테이크아웃 카페를 하나 운영하는 작은 브랜드가 2호점을 어디에 내면 좋을지 공개 데이터로 분석한 프로젝트입니다. 서울시 상권분석서비스 데이터 5년 반 치를 PostgreSQL에 넣고, 수요, 경쟁, 비용, 지속성 네 가지 관점에서 가설 6개를 세워 검증했습니다. 결론이 데이터 처리 방식에 따라 달라지지 않는지도 처리 방식을 바꿔 다시 확인했습니다.

직장인이 많고 지하철역이 있는 상권일수록 점포당 매출이 높았고, 예상과 달리 카페가 많은 상권도 점포당 매출이 높았습니다. 이 결과를 기준으로 1,058개 상권을 단계별로 좁혀서 대형 프랜차이즈가 적은 을지로3가역, 강남구청역, 서초역 세 곳을 후보로 제안했습니다.

### 2. 러닝 기록 자동화 대시보드

[프로젝트 보기](https://github.com/baebokchii/RunningLog), [대시보드 보기](https://public.tableau.com/views/RunningLogDashboard/RunningLog)

애플워치에 쌓이는 제 러닝 기록이 Tableau 대시보드에 자동으로 반영되게 만든 개인 프로젝트입니다. 러닝이 끝나고 피트니스 앱 화면을 캡처해서 보내면, 맥이 이미지에서 거리, 시간, 페이스, 심박을 읽어 구글 시트에 새 기록만 추가합니다. Tableau는 이 시트를 하루에 한 번 불러와 대시보드를 갱신합니다.

처음에는 건강 앱 데이터를 통째로 내보내는 방식이라 한 번 업데이트에 3분쯤 걸렸는데, 스크린샷 방식으로 바꿔서 10초로 줄였습니다. 대시보드에서는 제가 얼마나 꾸준히 뛰었는지, 페이스가 얼마나 좋아졌는지를 볼 수 있습니다.

### 3. 랜덤 여행 챌린지 AI 에이전트

[프로젝트 보기](https://github.com/baebokchii/kaggle_ai_agent_project)

여행 기간만 고르면 국내 여행지 한 곳을 랜덤으로 뽑고, AI 에이전트들이 검색으로 명소, 맛집, 교통을 조사해서 시간대별 일정과 예산까지 짜 주는 웹 서비스입니다. Kaggle AI 에이전트 과정의 캡스톤으로 만든 여행 플래너를 Google ADK와 Gemini로 다시 만들었습니다.

리서치 에이전트 세 개가 동시에 검색하고, 일정을 쓰면 검수 에이전트가 점검해서 문제가 있으면 고치는 구조입니다. 여행지 추첨이나 예산 합계처럼 틀리면 안 되는 부분은 LLM이 아니라 코드로 처리했습니다. 평가 지표를 따로 만들어 측정하면서 개선했고, 품질 점수는 떨어뜨리지 않으면서 응답 시간은 약 14%, 토큰 사용량은 약 26% 줄였습니다.

### 4. Google SERP 커뮤니티 서비스 마케팅 분석 (홍콩)

[프로젝트 보기](https://github.com/baebokchii/google_serp_marketing), [분석 내용](https://github.com/baebokchii/google_serp_marketing/blob/main/insights.md)

홍콩 사이쿵 지역 커뮤니티센터가 운영하는 노인 서비스, 비중국어권 학생 지원, 특수교육 세 가지 서비스가 구글 검색에서 더 잘 보이도록 Google Ads 캠페인을 설계하고 분석한 프로젝트입니다. 사람들이 어떤 의도로 검색하는지를 기준으로 키워드를 짜고, 광고 문구는 A/B 테스트로 비교했습니다. 그다음 키워드와 광고그룹별로 노출수, 클릭수, 클릭률, 비용을 분석해 캠페인에 다시 반영했습니다.

특수교육 관련 키워드와 광고 문구의 반응이 좋은 편이었고, 특히 ADHD처럼 이미 문제를 알고 검색하는 키워드는 짧은 기간에도 클릭률이 높았습니다. 중국어 광고와 영어 광고는 반응 패턴이 서로 달랐습니다.

---

## Education

**Hong Kong University of Science and Technology (홍콩과학기술대학교)**
BBA in Management, BBA in Information Systems (Double Major), Class of 2025

경영학 학사, 정보시스템 학사 (복수 전공), 2025년 1월 졸업

---

## Contact

[Email](mailto:alexbaehj@gmail.com), [LinkedIn](https://linkedin.com/in/hjbae01/)
