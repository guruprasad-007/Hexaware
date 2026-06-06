import sys
import analytics_system as ast


def run_menu():
    while True:
        print("\n" + "=" * 50)
        print("     E-COMMERCE ORDER ANALYTICS SYSTEM          ")
        print("=" * 50)
        print("1. View Orders (Dataset Overview)")
        print("2. Revenue Analysis (Python & NumPy Specs)")
        print("3. Product & Category Analysis")
        print("4. City & Customer Regional Profiles")
        print("5. Export Financial Reports (Text & Filtering CSVs)")
        print("6. Exit")
        print("=" * 50)

        choice = input("Enter your structural choice (1-6): ").strip()

        if choice == "1":
            print("\n--- ALL RECORD ENTRIES ---")
            ast.display_all_records()
            print(f"\nTotal System Logged Orders: {ast.count_total_orders()}")

        elif choice == "2":
            print("\n--- REVENUE ANALYSIS PROFILE ---")
            print(f"Total Revenue (Pure Python)  : ₹{ast.calculate_total_revenue():,.2f}")
            print(f"Average Order Value          : ₹{ast.find_average_order_value():,.2f}")
            print(f"Highest Order Ticket Value   : ₹{ast.find_highest_order_value():,.2f}")
            print(f"Lowest Order Ticket Value    : ₹{ast.find_lowest_order_value():,.2f}")

            # NumPy Subroutine output verification
            np_data = ast.run_numpy_analysis()
            if np_data:
                print("\n--- NUMPY MATRIX STATISTICS ---")
                for key, val in np_data.items():
                    print(f"{key:<20}: ₹{val:,.2f}")

        elif choice == "3":
            print("\n--- PRODUCT ANALYSIS ---")
            print("Alphabetical Product Range Index:", ast.get_sorted_products())

            print("\nOrders Count by SKU Identity:")
            for p, count in ast.count_orders_by_product().items():
                print(f" - {p}: {count} orders")

            print("\nRevenue Contribution per SKU:")
            for p, rev in ast.calculate_revenue_by_product().items():
                print(f" - {p}: ₹{rev:,.2f}")

            top_p, top_qty = ast.find_top_product()
            least_p, least_qty = ast.find_least_sold_product()
            print(f"\nMost Sold Product (Volume)  : {top_p} ({top_qty} items)")
            print(f"Least Sold Product (Volume) : {least_p} ({least_qty} items)")

            print("\nRevenue breakdown by Category Layer:")
            for cat, rev in ast.calculate_revenue_by_category().items():
                print(f" - {cat}: ₹{rev:,.2f}")

        elif choice == "4":
            print("\n--- REGIONAL CITY & CUSTOMER INSIGHTS ---")
            print("Unique Active Cities:", ast.get_unique_cities_set())
            print(f"Unique Customer Count: {ast.count_unique_customers()}")

            top_cust, top_spend = ast.find_highest_spending_customer()
            print(f"Highest Spending Client: {top_cust} (Spent: ₹{top_spend:,.2f})")

            print("\nOrder Velocity Frequency Map (City):")
            for city, count in ast.count_orders_by_city().items():
                print(f" - {city}: {count} transactions")

            print("\nGross Earnings Map (City):")
            for city, rev in ast.create_city_revenue_dict().items():
                print(f" - {city}: ₹{rev:,.2f}")

            top_c, top_c_rev = ast.find_top_city()
            print(f"\nTop Performing City Generator: {top_c} (Grossing: ₹{top_c_rev:,.2f})")

        elif choice == "5":
            print("\nProcessing and building analytical file writes...")
            success = ast.generate_reports_and_bonus_files()
            if success:
                print("\n[SUCCESS] Generated files perfectly in execution directory:")
                print(" 1. 'sales_summary_report.txt' (Complete Summary Dashboard)")
                print(" 2. 'high_value_orders.csv' (Filtered subset where ticket value > ₹50,000)")
                print(" 3. 'electronics_orders.csv' (Filtered subset matching category: Electronics)")
            else:
                print("[FAILURE] Reports could not generate.")

        elif choice == "6":
            print("\nThank you for utilizing the Order Analytics Platform. Exiting system.")
            sys.exit()
        else:
            print("[INVALID ENTRY] Please supply a precise integer indexing flag 1 through 6.")


if __name__ == "__main__":
    # Safety Check: check if data array loaded correctly.
    if not ast.orders_data:
        print("System execution halted: 'orders.csv' is structurally unreadable or missing.")
    else:
        run_menu()