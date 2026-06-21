from pyspark.sql import SparkSession
from pyspark.sql import functions as F
import sys

# Force environment to use active Python runtime version to prevent mismatch errors
sys.argv.append("--driver-class-path")

# 1. Initialize a Local Spark Session Cluster
spark = SparkSession.builder \
    .appName("WarehouseInventoryAnalytics") \
    .config("spark.sql.shuffle.partitions", "4") \
    .getOrCreate()

# Set log level to prevent verbose output
spark.sparkContext.setLogLevel("WARN")

print("=========================================================")
print("          INGESTING DISTRIBUTED WAREHOUSE LOG STREAMS   ")
print("=========================================================")

# Mocking broad product master data matching Week 1 & 2 definitions
products_data = [
    (1, "Ergonomic Wireless Mouse", 15),
    (2, "27-Inch 4K Monitor", 8),
    (3, "Mechanical Keyboard", 12),
    (5, "USB-C Hub", 5)
]
df_products = spark.createDataFrame(products_data, ["product_id", "product_name", "reorder_threshold"])

# Mocking a large set of multi-warehouse transaction logs
stock_movements_data = [
    (1001, 1, 1, 50),   # 50 Mice added to Chennai Hub
    (1002, 1, 1, -40),  # 40 Mice shipped out of Chennai Hub
    (1003, 2, 2, 20),   # 20 Monitors added to Bangalore Distribution
    (1004, 2, 2, -5),   # 5 Monitors shipped out of Bangalore Distribution
    (1005, 3, 1, 5),    # 5 Keyboards added to Chennai Hub
    (1006, 5, 2, 30),   # 30 Hubs added to Bangalore Distribution
    (1007, 5, 2, -28),  # 28 Hubs shipped out of Bangalore Distribution
    (1008, 1, 2, 100),  # 100 Mice added to Bangalore Distribution
    (1009, 1, 2, -95)   # 95 Mice shipped out of Bangalore Distribution
]
df_movements = spark.createDataFrame(stock_movements_data, ["movement_id", "product_id", "warehouse_id", "quantity_changed"])

# Mocking Warehouse Metadata
warehouses_data = [
    (1, "Main Hub Chennai"),
    (2, "North Distribution Bangalore")
]
df_warehouses = spark.createDataFrame(warehouses_data, ["warehouse_id", "warehouse_name"])

# 2. Execute Distributed Table Join Pipeline
df_joined = df_movements \
    .join(df_products, "product_id", "inner") \
    .join(df_warehouses, "warehouse_id", "inner")

# 3. Aggregate Total Stock and Assess Status per Warehouse
df_warehouse_summary = df_joined.groupBy("warehouse_name", "product_name", "reorder_threshold").agg(
    F.sum("quantity_changed").alias("Current_Stock")
)

# Apply conditional labels to identify overstocked, healthy, or low stock statuses
df_warehouse_insights = df_warehouse_summary.withColumn(
    "Stock_Status",
    F.when(F.col("Current_Stock") <= F.col("reorder_threshold"), "UNDERSTOCK / REORDER")
     .when(F.col("Current_Stock") >= 50, "OVERSTOCKED ALERT")
     .otherwise("HEALTHY")
).orderBy("warehouse_name", "Current_Stock")

print("\n=========================================================")
print("          WAREHOUSE-LEVEL INVENTORY PERFORMANCE REPORT   ")
print("=========================================================")
df_warehouse_insights.select("warehouse_name", "product_name", "Current_Stock", "Stock_Status").show(truncate=False)

# Safely close Spark engine session
spark.stop()