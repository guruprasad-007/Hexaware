import pandas as pd
import numpy as np

# 1. Simulating messy operational inventory inputs
messy_stock_data = {
    'product_id': [1, 2, 3, 4, 5],
    'product_name': ['Ergonomic Wireless Mouse', '27-Inch 4K Monitor', 'Mechanical Keyboard', None, 'USB-C Hub Hub'],
    'reorder_threshold': [15, 8, 12, 10, 5],
    'current_quantity': [10, 15, -3, 22, None] # Notice negative quantities and missing NaN fields
}

df_raw = pd.DataFrame(messy_stock_data)
print("=========================================================")
print("             RAW STOCK MOVEMENT INGESTION LOG            ")
print("=========================================================")
print(df_raw)

# 2. Data Engineering Cleansing Pipeline
print("\nCleaning Data Anomalies...")

# Drop rows missing crucial identifying information
df_cleaned = df_raw.dropna(subset=['product_name']).copy()

# Fill missing stock levels with zero
df_cleaned['current_quantity'] = df_cleaned['current_quantity'].fillna(0)

# Apply NumPy clipping to guarantee stock counts never record negative values
df_cleaned['current_quantity'] = np.clip(df_cleaned['current_quantity'], 0, None)

# 3. Use Pandas Logic To Flag Low Stock Items Needing Reorder
df_cleaned['reorder_required'] = df_cleaned['current_quantity'] <= df_cleaned['reorder_threshold']

print("\n--- Cleaned Master Inventory Views Matrix ---")
print(df_cleaned)

# 4. Generate Export Report Target
output_report_path = "low_stock_reorder_report.csv"
df_cleaned[df_cleaned['reorder_required'] == True].to_csv(output_report_path, index=False)
print(f"\nAlert report generated successfully as: {output_report_path}")