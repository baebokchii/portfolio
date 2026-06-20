# 📁 Portfolio – Hyounjin Bae

I am a data analyst enthusiast focused on turning messy data into structured business decisions.

Across real-world projects, I cover the full analysis lifecycle: problem framing, metric design, data modeling, analysis, and actionable recommendations.

## 🚀 Projects

### 1. Seoul Public Bike (따릉이) Demand Forecasting

[View project](https://github.com/baebokchii/data_project)

This project builds an end-to-end machine learning pipeline to predict city-wide hourly bike rental demand for Seoul's public bike-sharing system, following the CRISP-DM + MLOps lifecycle from business problem definition through held-out test set evaluation.

Data was collected from two public APIs — Seoul Open Data Plaza (~78,000 paginated API calls, parallelized with multi-threading) and KMA ASOS weather observations — then merged and split chronologically to avoid data leakage.

Seven experiments were run in order of increasing complexity, adding lag features, weather, and Korean public holiday indicators to a LightGBM model, ultimately reducing RMSE by 80.2% over the seasonal mean baseline (Val RMSE 3,008 → 596, Test RMSE 1,117 on a 9-month held-out set).

### 2. Delivery Delay Impact on Customer Satisfaction (E-commerce)

[View project](https://github.com/baebokchii/delivery_delay_impact)

This project analyzes how delivery delays and delay duration affect customer satisfaction using e-commerce order data.

I designed SQL-based analytical data models and built BI-ready outputs to visualize the relationship between logistics performance and customer experience.

The final output highlights region- and category-level operational priorities that can reduce low ratings and improve service quality.

### 3. Google SERP Marketing for Community Services (Hong Kong)

[View project](https://github.com/baebokchii/google_serp_marketing)

This project evaluates the promotion performance of three community services using Google Search (SERP) and Google Ads campaign data in Hong Kong.

It combines SEO-oriented keyword planning with ad copy A/B testing to identify high-intent traffic patterns and improvement opportunities by service type and language.

### 4. AI Agent Design and Implementation (Google)

[View project](https://github.com/baebokchii/ai_agent_course)

Based on Google's hands-on curriculum, this project demonstrates practical AI agent design patterns and execution workflows.

Using Kaggle and Google AI Studio, I implemented prompt strategies and agent logic to strengthen my understanding of agent architecture and automation.

## 📬 Contact

<a href="mailto:alexbaehj@gmail.com">Email</a>

[LinkedIn](https://linkedin.com/in/hjbae01/)
