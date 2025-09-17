Fashion Trends Analysis (2018–2022)
📊 Project Overview

This project explores fashion sales data (2018–2022) using SQL and Tableau.
The aim is to analyze customer preferences, category performance, discount effects, and profitability to highlight trends and actionable insights.

Deliverables:

SQL queries (Q1–Q6a/b)

Tableau Story (step-by-step walkthrough)

Interactive Dashboard with filters for Category, Season, and Year

Python (Pandas/Jupyter): validation and extra analysis.


🛠️ Tools & Technologies

Database: PostgreSQL

Querying: SQL (joins, CTEs, aggregations, window functions)

Visualization: Tableau Public

Files: Raw dataset (fashion_master.csv) + query outputs (CSV exports)

Scripting: Python (Pandas, Jupyter Notebook)


❓ Questions & Findings
Q1. Seasonal Fashion Trends

Question: Which categories dominate in each season?

Findings:

Spring: Blouses lead, Jeans close behind.

Summer: Skirts slightly lead; Shorts and Blouses close behind.

Autumn: Blouses and Jackets dominate.

Winter: Jeans and Dresses dominate.

Takeaway: Clear seasonal shifts → inventory and marketing should adjust by season.


Q2. Product Category Performance Analysis

Question: Which categories have the highest total sales and best average ratings?

Findings:

Skirts had the highest sales (~26K).

Jackets the lowest (~19K).

Blouses & Shirts scored highest on ratings; Jeans balanced both sales & ratings.

Takeaway: High sales don’t always equal highest customer satisfaction. Skirts sold most, but Blouses won on ratings.

Q3. Do Discounts Actually Boost Sales?

Question: Is there a correlation between discounts and higher sales?

Findings:

High Discount: ~274 avg sales (highest).

Low Discount: ~255 avg sales.

No Discount: ~249 avg sales.

Takeaway: Discounts boosted sales — high discounts drove the most volume.

Q4. Optimal Product Mix

Question: Which products balance both high sales and strong customer ratings?

Findings:

Beach Shirts and Blouses dominate the mix — top ratings and top sales.

Chino Shorts & Summer Dresses hold steady with good ratings, moderate sales.

Biker Jackets, while well-rated, lag behind in sales.

Takeaway: Beach Shirts & Blouses delivered the best mix of popularity and customer satisfaction.

Q5. Year-over-Year Trend Analysis

Question: How have total sales changed over the years, and which categories grew the most?

Findings:

Jeans surged in 2022 (category peak).

Skirts peaked in 2021, then dipped.

Dresses rebounded in 2022 after a 2019 jump.

Jackets were inconsistent (spike in 2021, drop in 2022).

Takeaway: Jeans ended strongest; Skirts/Dresses show durable growth.

Q6a. Total Profit by Category

Question: Which categories generate the most profit?

Findings:

Skirts: ~$1.95M (highest).

Shorts: ~$1.78M; Shoes ~$1.73M.

Blouses: ~$1.48M (lowest).

Takeaway: Skirts are the profit engine; Blouses underperform.

Q6b. Profit Margin % by Category

Question: What is the profit margin % across categories?

Findings:

Margins are stable (~32–34%).

Shirts have the highest (~34%), Blouses the lowest (~31%).

Takeaway: Profit margins across categories stayed close, but Shirts maintained the best efficiency.me.

📈 Tableau Story & Dashboard

The Tableau Story includes:

Q1: Seasonal Fashion Trends

Q2: Category Performance

Q3: Discounts vs Sales

Q4: Optimal Product Mix

Q5: YOY Trends

Q6a: Total Profit by Category

Q6b: Profit Margin % by Category

Interactive Dashboard with filters (Category, Season, Year)

👉 https://public.tableau.com/shared/2HFHWMSG7?:display_count=n&:origin=viz_share_link

🔑 Key Insights (Summary)

Seasonality is strong: Summer = Skirts/Shorts; Winter = Jeans/Dresses.

Skirts lead sales & profit, while Blouses underperform.

Jeans & Dresses show the most consistent YOY growth.

Discounts work (high > low > none), but require margin awareness.

Margins are steady across categories, ~32–34%.

Best Product Mix: Skirts + Jeans + Dresses + Shoes.
