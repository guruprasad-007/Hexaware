# SkyJet Airways: End-to-End Airline Operations Analytics Platform

An enterprise-grade Data Lakehouse solution built on **Azure Databricks (Serverless Compute Engine)** leveraging the **Medallion Architecture (Bronze → Silver → Gold)** to process structured flight operations, booking records, and semi-structured passenger profiles.

---

## 🏗️ Architectural Framework

[ Bronze Layer ]        [ Silver Layer ]               [ Gold Layer ]
Raw Sources            Cleaned & Enriched           Business Reports &
(CSV / JSON)   ──>   (Joins, Derived Bands, Delta Tables) ──>  Window Performance KPIs


- **Bronze Layer (Ingestion):** Raw data capture from multiple endpoints (`flights.csv`, `bookings.csv`, and multi-line nested `passenger_preferences.json`).
- **Silver Layer (Transformation & Joins):** Schema resolution, data quality enrichment (conditional status mappings, pricing bands), and normalization across transactional domains to yield a consolidated master journey dataset.
- **Gold Layer (Analytics & Delivery):** High-level analytical calculations leveraging Spark SQL syntax and relational Windowing logic (`dense_rank`, running sums) to generate analytical executive dashboards.

## 🛠️ Key Implementation Highlights

- **Slowly Changing Dimensions (SCD Type 1):** Built idempotent data processing loops using high-performance Delta `MERGE INTO` operations to seamlessly apply operational modifications (updates and inserts).
- **Time Travel Audit Trail:** Leveraged transaction log tracking capabilities via `versionAsOf` to capture delta snapshot transformations across data processing dates.
- **Lakehouse Optimization:** Applied infrastructure compaction rules using `OPTIMIZE` commands with multi-dimensional `ZORDER` clustering columns (`flight_id`) along with proactive file vacuuming routines to minimize data read latives.
- **Production DAG Orchestration:** Modeled a continuous task dependency chain (`Airline_Analytics_Pipeline`) scheduled to fire dynamically inside serverless infrastructure envelopes.
