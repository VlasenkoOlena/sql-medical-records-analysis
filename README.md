Healthcare Efficiency Analysis (SQL)
Overview
Analysis of patient recovery patterns using BigQuery (SQL). The project focuses on distinguishing between chronic and acute conditions to measure healthcare delivery efficiency.

Visualizations
Acute Conditions: Average Recovery Time
![Recovery Analysis Chart](visualizations/acute_conditions_recovery.png)
Insights: Skin conditions and fractures show the longest recovery cycles among acute cases.

Data & Tech Stack
SQL (Google BigQuery): Multi-table joins and data transformation.

Data Modeling: Transformed raw Synthea data into a relational structure (Patients, Encounters, Conditions).

Data Cleaning: Handled NULL values in recovery dates and filtered out duration anomalies.

Business Logic
Segmentation: Conditions >365 days are categorized as Chronic to avoid skewing "Acute" efficiency metrics.

Metric: Used DATE_DIFF to calculate Recovery_Days as a primary KPI.