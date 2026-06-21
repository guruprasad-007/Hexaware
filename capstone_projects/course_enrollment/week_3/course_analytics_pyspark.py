from pyspark.sql import SparkSession
from pyspark.sql import functions as F

# Initialize a High-Performance Spark Session Cluster
spark = SparkSession.builder \
    .appName("OnlineCourseEnrollmentAnalytics") \
    .config("spark.sql.shuffle.partitions", "4") \
    .getOrCreate()

print("=========================================================")
print("          INGESTING DISTRIBUTED MOCK TRANSACTIONAL TABLES")
print("=========================================================")

# Simulated structural tables mirroring your dataset
students_data = [
    (101, "Guru Prasad"), (102, "Ananya Rao"), (104, "Siddharth Singh"), 
    (105, "Meghana Reddy"), (106, "Kiran Rao"), (107, "Vikram Malhotra")
]
df_students = spark.createDataFrame(students_data, ["student_id", "student_name"])

courses_data = [
    ("CS-101", "Deep Learning"),
    ("CS-102", "Azure Cloud"),
    ("CS-103", "MERN Stack")
]
df_courses = spark.createDataFrame(courses_data, ["course_id", "course_name"])

enrollments_data = [
    (1001, 101, "CS-101", "Active"),
    (1002, 102, "CS-102", "Completed"),
    (1003, 104, "CS-103", "Dropped"),
    (1004, 105, "CS-102", "Active"),
    (1005, 106, "CS-101", "Completed"),
    (1006, 107, "CS-103", "Active")
]
df_enrollments = spark.createDataFrame(enrollments_data, ["enrollment_id", "student_id", "course_id", "status"])

progress_data = [
    (1001, 45.0), (1002, 100.0), (1003, 0.0), (1004, 0.0), (1005, 100.0), (1006, 64.0)
]
df_progress = spark.createDataFrame(progress_data, ["enrollment_id", "completion_percentage"])

# Executing Big Data Pipeline Master Relational Joins
df_master_pipeline = df_enrollments \
    .join(df_students, "student_id", "inner") \
    .join(df_courses, "course_id", "inner") \
    .join(df_progress, "enrollment_id", "inner")

print("\n=========================================================")
print("          PYSPARK DISTRIBUTED PERFORMANCE REPORT         ")
print("=========================================================")

# Compute Metrics: Total Enrolled, Average Progress, Total Completions, Total Dropouts
df_course_summary = df_master_pipeline.groupby("course_id", "course_name").agg(
    F.count("student_id").alias("Total_Enrolled"),
    F.round(F.avg("completion_percentage"), 2).alias("Average_Progress"),
    F.sum(F.when(F.col("status") == "Completed", 1).otherwise(0)).alias("Total_Completions"),
    F.sum(F.when(F.col("status") == "Dropped", 1).otherwise(0)).alias("Total_Dropouts")
).orderBy("course_id")

df_course_summary.show(truncate=False)
spark.stop()