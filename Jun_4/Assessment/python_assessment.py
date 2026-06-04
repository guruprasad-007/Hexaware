salaries = [45000, 55000, 65000, 75000, 85000]

# Exercise 1: Display all salaries
print("Salaries:", salaries)

# Exercise 2: Find Maximum and Minimum Salary
print("Max Salary:", max(salaries))
print("Min Salary:", min(salaries))

# Exercise 3: Find total salary payout
print("Total Payout:", sum(salaries))

# Exercise 4: Find average salary
avg_salary = sum(salaries) / len(salaries)
print("Average Salary:", avg_salary)

# Exercise 5: Add 95000 and 105000 to the list
salaries.extend([95000, 105000])
print("After adding:", salaries)

# Exercise 6: Remove 55000 from the list
salaries.remove(55000)
print("After removing 55000:", salaries)

# Exercise 7: Sort salaries ascending
salaries.sort()
print("Sorted Ascending:", salaries)

# Exercise 8: Sort salaries descending
salaries.sort(reverse=True)
print("Sorted Descending:", salaries)

# Exercise 9: Find second highest salary

unique_salaries = list(set(salaries))
unique_salaries.sort(reverse=True)
print("Second Highest Salary:", unique_salaries[1])

# Exercise 10: Display salaries greater than ₹70,000
high_salaries = [s for s in salaries if s > 70000]
print("Salaries > 70000:", high_salaries)

employee = (101, "Rahul Sharma", "Data Engineering", 75000)

# Exercise 11: Display all tuple values
print("Tuple values:", employee)

# Exercise 12: Display employee name
print("Employee Name:", employee[1])

# Exercise 13: Display department
print("Department:", employee[2])

# Exercise 14: Unpack tuple into variables and print all variables
emp_id, name, dept, salary = employee
print(f"ID: {emp_id}, Name: {name}, Dept: {dept}, Salary: {salary}")

# Exercise 15: Display Length, First Element, Last Element
print("Length:", len(employee))
print("First Element:", employee[0])
print("Last Element:", employee[-1])

batch_a = {"Rahul", "Priya", "Amit", "Sneha", "Farhan"}
batch_b = {"Priya", "Sneha", "Neha", "Arjun", "Farhan"}

# Exercise 16: Find common students (Intersection)
print("Common Students:", batch_a.intersection(batch_b))

# Exercise 17: Find students only in Batch A (Difference)
print("Only in Batch A:", batch_a.difference(batch_b))

# Exercise 18: Find students only in Batch B (Difference)
print("Only in Batch B:", batch_b.difference(batch_a))

# Exercise 19: Find all unique students (Union)
print("All Unique Students:", batch_a.union(batch_b))

# Exercise 20: Find students present in one batch but not both (Symmetric Difference)
print("In one but not both:", batch_a.symmetric_difference(batch_b))

employee_info = {
    "employee_id": 101,
    "name": "Rahul Sharma",
    "department": "Data Engineering",
    "salary": 75000,
    "city": "Hyderabad"
}

# Exercise 21: Display employee name
print("Name:", employee_info["name"])

# Exercise 22: Display department and city
print(f"Dept: {employee_info['department']}, City: {employee_info['city']}")

# Exercise 23: Add experience of 5 years
employee_info["experience"] = 5
print("After adding experience:", employee_info)

# Exercise 24: Update salary to 85000
employee_info["salary"] = 85000
print("After updating salary:", employee_info)

# Exercise 25: Remove city
employee_info.pop("city")
print("After removing city:", employee_info)

# Exercise 26: Display all keys
print("Keys:", list(employee_info.keys()))

# Exercise 27: Display all values
print("Values:", list(employee_info.values()))

# Exercise 28: Display all key-value pairs
print("Key-Value pairs:", list(employee_info.items()))

employees = [
    {"id": 101, "name": "Rahul", "department": "IT", "salary": 50000},
    {"id": 102, "name": "Priya", "department": "HR", "salary": 70000},
    {"id": 103, "name": "Amit", "department": "IT", "salary": 60000},
    {"id": 104, "name": "Sneha", "department": "Finance", "salary": 80000},
    {"id": 105, "name": "Farhan", "department": "IT", "salary": 90000}
]

# Exercise 29: Display all employee names
names = [emp["name"] for emp in employees]
print("All Names:", names)

# Exercise 30: Display employees belonging to IT department
it_employees = [emp for emp in employees if emp["department"] == "IT"]
print("IT Employees:", it_employees)

# Exercise 31: Find highest salary employee
highest_sal_emp = max(employees, key=lambda x: x["salary"])
print("Highest Salary Employee:", highest_sal_emp)

# Exercise 32: Find lowest salary employee
lowest_sal_emp = min(employees, key=lambda x: x["salary"])
print("Lowest Salary Employee:", lowest_sal_emp)

# Exercise 33: Find average salary
all_salaries = [emp["salary"] for emp in employees]
avg_sal = sum(all_salaries) / len(all_salaries)
print("Average Salary:", avg_sal)

# Exercise 34: Find total salary payout
print("Total Payout:", sum(all_salaries))

# Exercise 35: Display employees earning more than ₹70,000
high_earners = [emp for emp in employees if emp["salary"] > 70000]
print("Earning > 70000:", high_earners)

# Exercise 36: Count employees in IT department
it_count = sum(1 for emp in employees if emp["department"] == "IT")
print("Count of IT Employees:", it_count)

# Exercise 37: Display employee names sorted by salary descending
sorted_by_sal = sorted(employees, key=lambda x: x["salary"], reverse=True)
sorted_names = [emp["name"] for emp in sorted_by_sal]
print("Names sorted by salary (Desc):", sorted_names)

# Exercise 38: Find second highest salary employee

sorted_employees = sorted(employees, key=lambda x: x["salary"], reverse=True)
print("Second Highest Salary Employee:", sorted_employees[1])

# Exercise 39: Display all departments without duplicates
unique_depts = list(set(emp["department"] for emp in employees))
print("Unique Departments:", unique_depts)