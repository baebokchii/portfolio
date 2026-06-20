# Portfolio – Hyounjin Bae

[![Email](https://img.shields.io/badge/Email-alexbaehj%40gmail.com-D14836?style=flat&logo=gmail&logoColor=white)](mailto:alexbaehj@gmail.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-hjbae01-0A66C2?style=flat&logo=linkedin&logoColor=white)](https://linkedin.com/in/hjbae01/)

Data analyst with a focus on translating unstructured data into actionable business decisions.

Each project below follows the full analysis lifecycle: problem framing, metric design, data modeling, analysis, and recommendation.

---

## Tech Stack

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=postgresql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![LightGBM](https://img.shields.io/badge/LightGBM-2D71AC?style=flat)
![Kaggle](https://img.shields.io/badge/Kaggle-20BEFF?style=flat&logo=kaggle&logoColor=white)
![Google Ads](https://img.shields.io/badge/Google%20Ads-4285F4?style=flat&logo=googleads&logoColor=white)

---

## Projects

### 1. Seoul Public Bike (따릉이) Demand Forecasting

[View project](https://github.com/baebokchii/data_project)

An end-to-end machine learning pipeline that predicts city-wide hourly bike rental demand for Seoul's public bike-sharing system, following the CRISP-DM and MLOps lifecycle from business problem definition through held-out test set evaluation.

Data was collected from two public APIs — Seoul Open Data Plaza (approximately 78,000 paginated API calls, parallelized with multi-threading) and KMA ASOS weather observations — then merged and split chronologically to avoid data leakage.

Seven experiments were conducted in order of increasing complexity, incorporating lag features, weather data, and Korean public holiday indicators into a LightGBM model, reducing RMSE by 80.2% relative to the seasonal mean baseline (validation RMSE 3,008 to 596; test RMSE 1,117 on a nine-month held-out set).

### 2. Olist Customer RFM Segmentation (E-commerce)

[View project](https://github.com/baebokchii/olist-rfm-analysis)

A SQL analytics project that segments Olist's Brazilian e-commerce customers by Recency, Frequency, and Monetary value, and quantifies the business impact of each segment.

A PostgreSQL pipeline was built from raw Kaggle order data through staging, fact tables, RFM scoring, and segment profiling.

Key finding: only 3% of customers place a repeat order, yet this segment accounts for 5.6% of total revenue, while `big_spenders` (40% of customers) generate 73.3% of revenue — indicating that retention strategy should be based on spend behavior rather than product category.

### 3. Google SERP Marketing for Community Services (Hong Kong)

[View project](https://github.com/baebokchii/google_serp_marketing)

An evaluation of promotion performance for three community services using Google Search (SERP) and Google Ads campaign data in Hong Kong.

The analysis combines SEO-oriented keyword planning with ad copy A/B testing to identify high-intent traffic patterns and improvement opportunities by service type and language.

### 4. AI Agent Design and Implementation (Google)

[View project](https://github.com/baebokchii/ai_agent_course)

Based on Google's hands-on curriculum, this project demonstrates practical AI agent design patterns and execution workflows.

Using Kaggle and Google AI Studio, prompt strategies and agent logic were implemented to strengthen understanding of agent architecture and automation.

---

## Education

**Hong Kong University of Science and Technology (HKUST)**
BBA in Management and BBA in Information Systems (Double Major), Class of 2025

---

## Contact

[Email](mailto:alexbaehj@gmail.com) · [LinkedIn](https://linkedin.com/in/hjbae01/)
