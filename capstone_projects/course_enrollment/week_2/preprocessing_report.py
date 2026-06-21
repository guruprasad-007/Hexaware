import pandas as pd
import numpy as np

# 1. Generate messy, imperfect raw operational dataset arrays simulating edge errors
raw_operational_data = {
    'student_id': [101, 102, 103, 104, 105, 106, 107],
    'student_name': ['Guru Prasad', 'Ananya Rao', None, 'Siddharth Singh', 'Meghana Reddy', 'Kiran Rao', 'Vikram Malhotra'],
    'course_id': ['CS-101', 'CS-102', 'CS-101', 'CS-103', 'CS-102', 'CS-101', 'CS-103'],
    'course_name': ['Deep Learning', 'Azure Cloud', 'Deep Learning', 'MERN Stack', 'Azure Cloud', 'Deep Learning', 'MERN Stack'],
    'current_progress_percentage': [45.0, 115.0, 82.5, None, -15.0, 100.0, 64.0], # Notice out-of-bounds metrics (115%, -15%) and missing null fields
    'enrollment_status': ['Active', 'Completed', 'Active', 'Dropped', 'Active', 'Completed', 'Active']
}

# Load directly into a Pandas DataFrame
df_raw = pd.DataFrame(raw_operational_data)
print("=========================================================")
print("             RAW INFRASTRUCTURE INGEST TRACK")
print("=========================================================")
print(df_raw)

# 2. Data Cleansing Pipeline Operations
print("\nExecuting Data Cleansing Workflows...")

# Clean Missing Value Exceptions: Drop rows missing crucial name attributes
df_cleaned = df_raw.dropna(subset=['student_name']).copy()

# Fix Progress Fields: Fill missing progress logs with 0.00%
df_cleaned['current_progress_percentage'] = df_cleaned['current_progress_percentage'].fillna(0.0)

# NumPy Out-of-Bounds Capping: Clip values to stay safely between 0% and 100%
df_cleaned['current_progress_percentage'] = np.clip(df_cleaned['current_progress_percentage'], 0.0, 100.0)

print("\n--- Cleaned Structural DataFrame Matrix Results ---")
print(df_cleaned)

# 3. Enterprise Aggregations & Report Generation
print("\n=========================================================")
print("           COURSE PERFORMANCE METRICS REPORT             ")
print("=========================================================")

# Use Pandas grouping blocks to compute statistics for each course sector
course_summary_report = df_cleaned.groupby(['course_id', 'course_name']).agg(
    total_enrolled_students=('student_id', 'count'),
    global_average_progress=('current_progress_percentage', 'mean'),  # Passed as string
    maximum_achieved_progress=('current_progress_percentage', 'max') # Passed as string
).reset_index()

# Format clean numeric precision values
course_summary_report['global_average_progress'] = course_summary_report['global_average_progress'].round(2)

print(course_summary_report.to_string(index=False))

# Export to CSV inside local workspace
output_path = "course_cleaned_progress_report.csv"
df_cleaned.to_csv(output_path, index=False)
print(f"\nCleaned output metrics successfully saved as: {output_path}")