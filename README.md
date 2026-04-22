Delivery Delay & Logistics Analysis

📌 Project Overview

This project presents a comprehensive analysis of delivery delays and logistics performance for an e-commerce platform. By leveraging transactional order data, the analysis identifies root causes of late deliveries and unreliable delivery estimates, addressing the "Trust Gap" between actual and estimated delivery times.

The platform's estimated delivery dates were found to be frequently over-conservative (often twice the actual time), leading to potential purchase abandonment. Conversely, genuine carrier delays damage customer trust.

🎯 Business Problem

•
Actual vs. Estimated Delivery: How significant is the gap?

•
Impact on Customer Trust: How do delays affect review scores?

•
Conversion Optimization: How can machine learning provide shorter, more accurate estimates to increase conversion without over-promising?

📊 Dataset Summary

The analysis utilizes six primary tables from a MySQL database:

•
orders: Lifecycle timestamps and estimated dates.

•
order_items: Line-level product, seller, price, and freight data.

•
payments: Payment types, installments, and values.

•
products: Category, dimensions, and weight.

•
sellers: Seller location data.

•
geolocation: Geographic coordinates mapped to zip codes.

🛠️ Tech Stack

•
Database: MySQL

•
Languages: Python (Pandas, SQLAlchemy), SQL

•
Visualization: Power BI

•
Libraries: os, logging, time

🚀 Key Features & Analysis

1. Data Ingestion

Automated Python scripts to load raw CSV data into a structured MySQL database with detailed logging and execution tracking.

2. Feature Engineering

Derived critical metrics to enable multi-dimensional delay analysis:

•
order_handling_days: Time from purchase to approval.

•
order_approved_days: Time from approval to carrier handoff.

•
order_delivered_customer_days: Total delivery duration.

•
order_delivered_late: Boolean flag for deliveries exceeding estimates.

•
is_late_shipping: Boolean flag for shipments exceeding seller limits.

3. Deep Dive Insights

•
Top Late Categories: Bed Table Bath and Health Beauty lead in late delivery counts.

•
Payment Bottlenecks: UPI payments take ~1.77 days for approval compared to 0.19 days for Credit Cards (a 9x difference).

•
Weight Correlation: Heavier products (>5kg) take ~15.2 days to deliver vs. 5.7 days for lightweight items.

📈 Visualizations

The project includes an interactive Power BI Dashboard that allows stakeholders to:

•
Dynamically explore delivery delay metrics.

•
Filter by category, seller ID, and payment type.

•
Monitor real-time KPIs for logistics performance.

💡 Strategic Recommendations

1.
Seller Performance: Implement performance improvement plans and SLA enforcement for chronically late sellers.

2.
Payment Optimization: Address the UPI payment approval latency by optimizing integration APIs.

3.
ML-Based Estimator: Build a weight-aware delivery estimator to provide more accurate customer expectations.

4.
Logistics Partnerships: Establish category-specific carrier partnerships for bulky items (e.g., Bed Table Bath).

👤 Author

Sanket Nagdive

•
Date: April 22, 2026

•
Project: Delivery Delay & Logistics Analysis

