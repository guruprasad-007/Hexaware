# Hexaware PySpark Training Lab

This repository contains hands-on data engineering exercises implemented using Apache Spark (PySpark) on Azure Databricks. 

## 🚀 Project Overview
The lab focuses on processing healthcare and sales operations datasets through structured querying, data cleaning, and analytical reporting optimizations.

## 🛠️ Core Concepts Covered
- **Data Intake:** Reading multi-format structured sources (CSV, multi-line JSON) into Spark DataFrames.
- **Data Transformation:** Column operations, handling missing values (`null`), filtering, and sorting records.
- **Relational Joins:** Inner, Left, Right, Full, and Anti joins to isolate data discrepancies.
- **Advanced Analytics:** Window functions (`rank`, `dense_rank`, `lag`, `lead`) for computing performance analytics.
- **Spark SQL:** Writing declarative ANSI-SQL views for uniform pipeline execution.
- **ETL Pipelines:** Building an end-to-end Medallion Architecture (Bronze $\rightarrow$ Silver $\rightarrow$ Gold datasets) saved as optimized Parquet target layers.

## 💻 Tech Stack
- Azure Databricks (Runtime 17.3 LTS / Spark 4.0.0)
- PySpark (Python API for Apache Spark)
- Git & GitHub Integration