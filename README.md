# Financial Fraud Detection & Geospatial Analysis (SecureGuard)

## Business Problem
SecureGuard Financial Solutions required an analysis of 389,000+ credit card transactions to identify anomaly patterns, geographical risk nodes, and demographic vulnerabilities. The objective was to isolate fraudulent behaviors to inform targeted card-freezing protocols and reduce financial liability.

## Tech Stack Used
* **Database:** MySQL (Bulk ingestion bypassing strict server protocols, ETL date formatting, relational JOINs, aggregations).
* **Exploratory Data Analysis:** Python (Pandas, Seaborn, Matplotlib) via Jupyter Notebooks.
* **Data Visualization:** Tableau Public (Geospatial mapping, Inflation-Adjusted Calculated Fields, Tiled Dashboarding).
* **Spreadsheet Analysis:** Microsoft Excel (Statistical baseline dispersion, PivotTables).

## Interactive Dashboard
🔗 **[View the Tableau Dashboard Here](https://public.tableau.com/app/profile/abdul.a7400/viz/SecureGuard_Final/FraudAnalytics)**

## Key Business Insights
1. **The Time-Series Anomaly:** Legitimate transaction volume peaks during daytime hours, but fraudulent transactions experience a massive, isolated spike between 22:00 and 03:00. 
2. **The Outlier Indicator:** The transaction amount (`amt`) is heavily right-skewed. Using the IQR method, 20,377 outliers were detected. The median transaction amount for fraud is significantly higher than legitimate purchases, making it the primary predictive feature.
3. **Geospatial & Demographic Disconnect:** City population (`city_pop`) showed near-zero correlation (`0.007`) with fraud probability. Fraud is driven by transaction category (`grocery_pos`, `shopping_net`) and amount, not the density of the geographic location.

## Repository Architecture
* `Fraud_Analysis_Queries.sql`: Contains the DDL/DML scripts for bulk data ingestion, string-to-date transformations, and risk metric aggregations.
* `SecureGuard_Fraud_Detection_EDA.ipynb`: The Python environment executing outlier detection (IQR), data structural integrity checks, and time-series plotting.
