from itertools import count

print("Hello World!!")

customer_name = "Guru Prasad"
age = 21
salary = 40000
is_active = True

print(customer_name)
print(age)
print(salary)
print(type(is_active))

for i in range(6):
    print(i)

count = 0
while count <= 5:
    print(count)
    count += 1

cities = ['Hyderabad', 'Chennai', 'Mumbai', 'Bangalore']
print(cities[0])
print(cities[1])
print(cities[2])

print(cities[-1])

cities[0] = 'Pune'
cities.append('Delhi')
cities.extend(['Kochi', 'Pondi'])
print(cities)

cities.pop()
print(cities)

del cities[0]
print(cities)

cities.clear()
print(cities)

print(len(cities))

Cities = ('Hyderabad', 'Chennai', 'Mumbai', 'Bangalore') #tuple
print(Cities[0])
print(Cities[1])
print(Cities[2])

print(Cities[-1])
print(Cities[-2])

print(Cities[1:4])


employees = (101, 'Guru', 75000)
print(employees[0])

emp_id, emp_name, emp_salary = employees

print(emp_id)
print(emp_name)
print(emp_salary)

cities_s = {'Hyderabad', 'Chennai', 'Mumbai', 'Bangalore'}
print(cities_s)

cities_s.add('Pune')

cities_s.update(['Mumbai', 'Goa'])
print(cities_s)

cities_s.remove('Pune')

cities_s.discard('Mumbai')