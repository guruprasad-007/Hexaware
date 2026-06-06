import csv
import numpy as np
import pandas as pd


# ==========================================
# PART 8: Exception Handling Wrapper Functions
# ==========================================
def read_csv_safely(filepath):
    """Task 27: Handle missing CSV file gracefully."""
    try:
        orders = []
        with open(filepath, mode="r", newline="", encoding="utf-8") as file:
            reader = csv.DictReader(file)
            for row in reader:
                # Task 28 & 29: Handle invalid/corrupt quantity and price values
                try:
                    row["quantity"] = int(row["quantity"])
                except ValueError:
                    print(
                        f"Warning: Invalid quantity data found for Order {row.get('order_id')}. Setting to 0."
                    )
                    row["quantity"] = 0

                try:
                    row["price"] = float(row["price"])
                except ValueError:
                    print(
                        f"Warning: Invalid price data found for Order {row.get('order_id')}. Setting to 0.0."
                    )
                    row["price"] = 0.0

                orders.append(row)
        return orders
    except FileNotFoundError:
        print(
            f"Error: The data file '{filepath}' was not found. Please ensure it exists."
        )
        return []


# Load the data globally for vanilla python functions
DATA_FILE = "orders.csv"
orders_data = read_csv_safely(DATA_FILE)


# ==========================================
# PART 1 - 6: Vanilla Python Core Implementations
# ==========================================


def display_all_records():
    """Task 2: Display all records formatting raw data."""
    if not orders_data:
        print("No records available.")
        return
    print(
        f"{'ID':<6} | {'Customer Name':<15} | {'City':<10} | {'Product':<8} | {'Category':<12} | {'Qty':<4} | {'Price':<8}"
    )
    print("-" * 75)
    for row in orders_data:
        print(
            f"{row['order_id']:<6} | {row['customer_name']:<15} | {row['city']:<10} | {row['product']:<8} | {row['category']:<12} | {row['quantity']:<4} | {row['price']:<8.2f}"
        )


def count_total_orders():
    """Task 3: Count total orders."""
    return len(orders_data)


# ==========================================
# PART 7: Custom Functional Solutions
# ==========================================


def calculate_total_revenue():
    """Task 4 & 23: Pure Python function for total revenue."""
    return sum(row["quantity"] * row["price"] for row in orders_data)


def find_average_order_value():
    """Task 7 & 26: Pure Python function for average order value."""
    total_orders = count_total_orders()
    return calculate_total_revenue() / total_orders if total_orders > 0 else 0


def get_order_values_list():
    """Helper to return calculated total order values for vanilla loops."""
    return [row["quantity"] * row["price"] for row in orders_data]


def find_highest_order_value():
    """Task 5: Find highest order value."""
    values = get_order_values_list()
    return max(values) if values else 0


def find_lowest_order_value():
    """Task 6: Find lowest order value."""
    values = get_order_values_list()
    return min(values) if values else 0


def get_unique_customers():
    """Task 8: Get list of unique customers."""
    return list(set(row["customer_name"] for row in orders_data))


def count_unique_customers():
    """Task 9: Count unique customers."""
    return len(get_unique_customers())


def find_highest_spending_customer():
    """Task 10: Find customer with highest purchase amount."""
    customer_spend = {}
    for row in orders_data:
        customer_spend[row["customer_name"]] = customer_spend.get(
            row["customer_name"], 0
        ) + (row["quantity"] * row["price"])
    if not customer_spend:
        return None, 0
    top_customer = max(customer_spend, key=customer_spend.get)
    return top_customer, customer_spend[top_customer]


def count_orders_by_product():
    """Task 11: Count orders by product."""
    prod_counts = {}
    for row in orders_data:
        prod_counts[row["product"]] = prod_counts.get(row["product"], 0) + 1
    return prod_counts


def calculate_revenue_by_product():
    """Task 12: Calculate revenue by product."""
    prod_rev = {}
    for row in orders_data:
        prod_rev[row["product"]] = prod_rev.get(row["product"], 0) + (
            row["quantity"] * row["price"]
        )
    return prod_rev


def find_top_product():
    """Task 13 & 24: Find most sold product based on quantity."""
    product_qty = create_product_quantity_dict()
    if not product_qty:
        return None, 0
    top_prod = max(product_qty, key=product_qty.get)
    return top_prod, product_qty[top_prod]


def find_least_sold_product():
    """Task 14: Find least sold product based on quantity."""
    product_qty = create_product_quantity_dict()
    if not product_qty:
        return None, 0
    least_prod = min(product_qty, key=product_qty.get)
    return least_prod, product_qty[least_prod]


def calculate_revenue_by_category():
    """Task 15: Calculate revenue by category."""
    cat_rev = {}
    for row in orders_data:
        cat_rev[row["category"]] = cat_rev.get(row["category"], 0) + (
            row["quantity"] * row["price"]
        )
    return cat_rev


def count_orders_by_city():
    """Task 16: Count orders by city."""
    city_counts = {}
    for row in orders_data:
        city_counts[row["city"]] = city_counts.get(row["city"], 0) + 1
    return city_counts


def find_top_city():
    """Task 18 & 25: Find city generating highest revenue."""
    city_rev = create_city_revenue_dict()
    if not city_rev:
        return None, 0
    top_city = max(city_rev, key=city_rev.get)
    return top_city, city_rev[top_city]


# ==========================================
# PART 6: Lists, Sets and Dictionaries Elements
# ==========================================


def get_sorted_products():
    """Task 19: Store all product names in a list and sort alphabetically."""
    products = [row["product"] for row in orders_data]
    return sorted(list(set(products)))


def get_unique_cities_set():
    """Task 20: Store unique cities in a set."""
    return set(row["city"] for row in orders_data)


def create_city_revenue_dict():
    """Task 21: Create dictionary { city : revenue }."""
    city_rev = {}
    for row in orders_data:
        city_rev[row["city"]] = city_rev.get(row["city"], 0) + (
            row["quantity"] * row["price"]
        )
    return city_rev


def create_product_quantity_dict():
    """Task 22: Create dictionary { product : quantity_sold }."""
    prod_qty = {}
    for row in orders_data:
        prod_qty[row["product"]] = (
            prod_qty.get(row["product"], 0) + row["quantity"]
        )
    return prod_qty


# ==========================================
# PART 9: NumPy Array Analysis
# ==========================================


def run_numpy_analysis():
    """Task 30: NumPy computation module."""
    order_values = get_order_values_list()
    if not order_values:
        return None

    np_array = np.array(order_values)
    analysis = {
        "Total Revenue": np.sum(np_array),
        "Average Revenue": np.mean(np_array),
        "Maximum Revenue": np.max(np_array),
        "Minimum Revenue": np.min(np_array),
        "Standard Deviation": np.std(np_array),
    }
    return analysis


# ==========================================
# PART 10: Pandas Data Analysis Engine
# ==========================================


def run_pandas_pipeline():
    """Tasks 31 to 37: Complete Pandas Pipeline Engine."""
    try:
        # Task 31: Read CSV using Pandas
        df = pd.read_csv(DATA_FILE)

        # Task 32: Create Revenue Column
        df["revenue"] = df["quantity"] * df["price"]

        # Task 33: Top 5 highest value orders
        top_5_orders = df.sort_values(by="revenue", ascending=False).head(5)

        # Task 34: Group by city and calculate revenue
        city_revenue_df = (
            df.groupby("city")["revenue"].sum().reset_index()
        )

        # Task 35: Group by product and calculate revenue
        product_revenue_df = (
            df.groupby("product")["revenue"].sum().reset_index()
        )

        # Task 36: Top selling products (by volume)
        top_selling_products = (
            df.groupby("product")["quantity"]
            .sum()
            .sort_values(ascending=False)
            .reset_index()
        )

        # Task 37: City-wise order count
        city_order_count = (
            df.groupby("city")["order_id"].count().reset_index()
        )

        return {
            "df": df,
            "top_5": top_5_orders,
            "city_rev": city_revenue_df,
            "prod_rev": product_revenue_df,
            "top_sell_prod": top_selling_products,
            "city_count": city_order_count,
        }
    except Exception as e:
        print(f"Error executing Pandas Processing Pipeline: {e}")
        return None


# ==========================================
# REPORT GENERATION & BONUS FILES
# ==========================================


def generate_reports_and_bonus_files():
    """Generates sales_summary_report.txt and bonus filtered csv metrics."""
    pandas_data = run_pandas_pipeline()
    if pandas_data is None:
        print("Failed to generate reports due to data processing error.")
        return False

    df = pandas_data["df"]

    # 1. Generate text report file
    with open("sales_summary_report.txt", "w", encoding="utf-8") as f:
        f.write("==================================================\n")
        f.write("          SALES SUMMARY PERFORMANCE REPORT         \n")
        f.write("==================================================\n\n")

        f.write(f"Total Orders            : {count_total_orders()}\n")
        f.write(f"Total Revenue           : ₹{calculate_total_revenue():,.2f}\n")
        f.write(
            f"Average Order Value     : ₹{find_average_order_value():,.2f}\n"
        )
        f.write(
            f"Highest Order Value     : ₹{find_highest_order_value():,.2f}\n"
        )
        f.write(
            f"Lowest Order Value      : ₹{find_lowest_order_value():,.2f}\n\n"
        )

        f.write("--- Revenue By City ---\n")
        for city, rev in create_city_revenue_dict().items():
            f.write(f" {city:<12}: ₹{rev:,.2f}\n")

        f.write("\n--- Revenue By Category ---\n")
        for cat, rev in calculate_revenue_by_category().items():
            f.write(f" {cat:<12}: ₹{rev:,.2f}\n")

        top_p, _ = find_top_product()
        top_c, _ = find_top_city()
        f.write(f"\nTop Selling Product     : {top_p}\n")
        f.write(f"Top Revenue City        : {top_c}\n")
        f.write("\n==================================================\n")

    # Task 38: Generate high_value_orders.csv (Orders above 50,000)
    high_value_df = df[df["revenue"] > 50000]
    high_value_df.to_csv("high_value_orders.csv", index=False)

    # Task 39: Generate electronics_orders.csv (Only Electronics)
    electronics_df = df[df["category"].str.lower() == "electronics"]
    electronics_df.to_csv("electronics_orders.csv", index=False)

    return True