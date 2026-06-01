CREATE DATABASE hospital_capstone_db;
USE hospital_capstone_db;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    age INT CHECK (age >= 0),
    city VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
    consultation_fee DECIMAL(10,2) CHECK (consultation_fee >= 0),
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    appointment_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
);


CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY,
    appointment_id INT,
    treatment_name VARCHAR(100) NOT NULL,
    treatment_cost DECIMAL(10,2) CHECK (treatment_cost >= 0),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE
);

CREATE TABLE bills (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    bill_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    bill_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE
);


CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    bill_id INT,
    payment_mode VARCHAR(30),
    paid_amount DECIMAL(10,2) CHECK (paid_amount >= 0),
    payment_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id) ON DELETE CASCADE
);

INSERT INTO departments VALUES 
(1, 'Cardiology'),
(2, 'Pediatrics'),
(3, 'Orthopedics'),
(4, 'Dermatology'),
(5, 'General Medicine');

INSERT INTO patients VALUES 
(101, 'Ramesh Kumar', 'Male', 45, 'Hyderabad', '9876543210'),
(102, 'Priya Sharma', 'Female', 32, 'Bangalore', '9876543211'),
(103, 'Amit Patel', 'Male', 55, 'Mumbai', '9876543212'),
(104, 'Sneha Reddy', 'Female', 28, 'Hyderabad', '9876543213'),
(105, 'Vikram Malhotra', 'Male', 38, 'Delhi', '9876543214'),
(106, 'Ananya Iyer', 'Female', 62, 'Chennai', '9876543215'),
(107, 'Karan Singh', 'Male', 12, 'Bangalore', '9876543216'),
(108, 'Kavita Joshi', 'Female', 41, 'Hyderabad', '9876543217'),
(109, 'Rajesh Gupta', 'Male', 50, 'Mumbai', '9876543218'),
(110, 'Meera Nair', 'Female', 35, 'Kochi', '9876543219'),
(111, 'Suresh Reddy', 'Male', 29, 'Hyderabad', '9876543220'),
(112, 'Sunita Rao', 'Female', 47, 'Bangalore', '9876543221'),
(113, 'Alok Verma', 'Male', 34, 'Pune', '9876543222'); 


INSERT INTO doctors VALUES 
(201, 'Dr. K. Srinivas', 'Cardiology', 1, 1000.00),
(202, 'Dr. Ritu Anand', 'Pediatrics', 2, 600.00),
(203, 'Dr. Arshad Ayub', 'Orthopedics', 3, 900.00),
(204, 'Dr. Deepa Nair', 'Dermatology', 4, 750.00),
(205, 'Dr. V. K. Sharma', 'General Medicine', 5, 500.00),
(206, 'Dr. Sunita Reddy', 'Cardiology', 1, 1200.00),
(207, 'Dr. Mahesh Babu', 'Orthopedics', 3, 850.00),
(208, 'Dr. Preeti Desai', 'Pediatrics', 2, 650.00); 

INSERT INTO appointments VALUES 
(301, 101, 201, '2026-01-10', 'Completed'),
(302, 102, 202, '2026-01-15', 'Completed'),
(303, 103, 203, '2026-01-20', 'Completed'),
(304, 104, 204, '2026-02-02', 'Completed'),
(305, 105, 205, '2026-02-10', 'Completed'),
(306, 106, 206, '2026-02-14', 'Completed'),
(307, 107, 202, '2026-02-18', 'Cancelled'), 
(308, 108, 207, '2026-02-22', 'Completed'),
(309, 109, 201, '2026-03-01', 'Completed'),
(310, 110, 204, '2026-03-05', 'Completed'),
(311, 101, 206, '2026-03-12', 'Completed'), 
(312, 102, 205, '2026-03-15', 'Completed'), 
(313, 103, 207, '2026-03-18', 'Completed'), 
(314, 104, 201, '2026-03-22', 'Completed'),
(315, 108, 203, '2026-03-25', 'Completed'), 
(316, 111, 205, '2026-03-28', 'Scheduled'),
(317, 112, 206, '2026-03-29', 'Completed'),
(318, 101, 203, '2026-04-02', 'Completed'), 
(319, 102, 201, '2026-04-05', 'Scheduled'), 
(320, 105, 207, '2026-02-20', 'Cancelled'); 


INSERT INTO treatments VALUES 
(401, 301, 'Angioplasty Consultation', 1500.00),
(402, 302, 'General Pediatric Checkup', 0.00),
(403, 303, 'Knee Arthroscopy', 25000.00),
(404, 304, 'Laser Skin Therapy', 6000.00),
(405, 305, 'Diabetes Management Session', 800.00),
(406, 306, 'Echocardiogram', 3500.00),
(407, 308, 'Physiotherapy Session', 1200.00),
(408, 309, 'ECG Monitoring', 700.00),
(409, 310, 'Acne Treatment', 2200.00),
(410, 311, 'Advanced Cardiac Checkup', 5000.00),
(411, 312, 'Hypertension Control Strategy', 500.00),
(412, 313, 'Fracture Casting', 4500.00),
(413, 314, 'Heart Rate Holter Test', 2800.00),
(414, 315, 'Spine Alignment Therapy', 3500.00),
(415, 318, 'Joint Injections', 6000.00);

-- 6. Populate Bills (16 records)
INSERT INTO bills VALUES 
(501, 101, 301, '2026-01-10', 2500.00, 'Paid'),
(502, 102, 302, '2026-01-15', 600.00, 'Paid'),
(503, 103, 303, '2026-01-20', 25900.00, 'Paid'),
(504, 104, 304, '2026-02-02', 6750.00, 'Paid'),
(505, 105, 305, '2026-02-10', 1300.00, 'Unpaid'),
(506, 106, 306, '2026-02-14', 4700.00, 'Paid'),
(507, 108, 308, '2026-02-22', 2050.00, 'Paid'),
(508, 109, 309, '2026-03-01', 1700.00, 'Paid'),
(509, 110, 310, '2026-03-05', 2950.00, 'Paid'),
(510, 101, 311, '2026-03-12', 6200.00, 'Paid'),
(511, 102, 312, '2026-03-15', 1100.00, 'Paid'),
(512, 103, 313, '2026-03-18', 5350.00, 'UnPaid'), 
(513, 104, 314, '2026-03-22', 3800.00, 'Paid'),
(514, 108, 315, '2026-03-25', 4350.00, 'Paid'),
(515, 101, 318, '2026-04-02', 6900.00, 'Paid'),
(516, 105, 320, '2026-02-20', 850.00, 'Paid'); 


INSERT INTO payments VALUES 
(601, 501, 'UPI', 2500.00, 'Success'),
(602, 502, 'Cash', 600.00, 'Success'),
(603, 503, 'Credit Card', 25900.00, 'Success'),
(604, 504, 'UPI', 6750.00, 'Success'),
(605, 505, 'Net Banking', 0.00, 'Failed'), 
(606, 506, 'Debit Card', 4700.00, 'Success'),
(607, 507, 'UPI', 2050.00, 'Success'),
(608, 508, 'Cash', 1700.00, 'Success'),
(609, 509, 'UPI', 2950.00, 'Success'),
(610, 510, 'Credit Card', 6200.00, 'Success'),
(611, 511, 'UPI', 1100.00, 'Success'),
(612, 512, 'Cash', 3000.00, 'Success'), 
(613, 513, 'UPI', 3800.00, 'Success'),
(614, 514, 'Debit Card', 4350.00, 'Success'),
(615, 515, 'UPI', 6900.00, 'Success'),
(616, 516, 'UPI', 850.00, 'Success');

-- Q1
SELECT * FROM patients;

-- Q2
SELECT * FROM doctors;

-- Q3
SELECT * FROM patients WHERE city = 'Hyderabad';

-- Q4
SELECT d.* FROM doctors d 
JOIN departments dept ON d.department_id = dept.department_id 
WHERE dept.department_name = 'Cardiology';

-- Q5
SELECT * FROM appointments WHERE appointment_date > '2026-01-01';

-- Q6
SELECT * FROM appointments WHERE appointment_status = 'Cancelled';

-- Q7
SELECT * FROM bills WHERE total_amount > 5000;

-- Q8
SELECT * FROM payments WHERE payment_mode = 'UPI';

-- Q9
SELECT * FROM patients WHERE age BETWEEN 30 AND 50;

-- Q10
SELECT * FROM doctors WHERE consultation_fee > 800;

-- 11
SELECT COUNT(*) AS total_patients FROM patients;

-- 12
SELECT COUNT(*) AS total_doctors FROM doctors;

-- 13
SELECT COUNT(*) AS total_appointments FROM appointments;

-- 14
SELECT AVG(consultation_fee) AS avg_consultation_fee FROM doctors;

-- 15
SELECT MAX(treatment_cost) AS highest_treatment_cost FROM treatments;

-- 16
SELECT SUM(total_amount) AS total_billing_amount FROM bills;

-- 17
SELECT SUM(paid_amount) AS total_paid_amount FROM payments WHERE payment_status = 'Success';

-- 18
SELECT city, COUNT(*) AS patient_count FROM patients GROUP BY city;

-- 19
SELECT specialization, COUNT(*) AS doctor_count FROM doctors GROUP BY specialization;

-- 20
SELECT appointment_status, COUNT(*) AS appointment_count FROM appointments GROUP BY appointment_status;

-- Q21
SELECT p.patient_name, a.appointment_date, a.appointment_status 
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id;

-- Q22
SELECT d.doctor_name, dept.department_name 
FROM doctors d
JOIN departments dept ON d.department_id = dept.department_id;

-- Q23
SELECT p.patient_name, d.doctor_name, a.appointment_date 
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

-- Q24
SELECT appointment_id, treatment_name, treatment_cost FROM treatments;

-- Q25
SELECT b.bill_id, p.patient_name, b.total_amount 
FROM bills b
JOIN patients p ON b.patient_id = p.patient_id;

-- Q26
SELECT bill_id, payment_mode, paid_amount, payment_status FROM payments;

-- Q27
SELECT 
    p.patient_name, 
    d.doctor_name, 
    dept.department_name, 
    a.appointment_date, 
    a.appointment_status, 
    t.treatment_name, 
    t.treatment_cost, 
    b.total_amount AS bill_amount, 
    pay.payment_status
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dept ON d.department_id = dept.department_id
LEFT JOIN treatments t ON a.appointment_id = t.appointment_id
LEFT JOIN bills b ON a.appointment_id = b.appointment_id
LEFT JOIN payments pay ON b.bill_id = pay.bill_id;

-- Q28
SELECT d.doctor_name, COUNT(a.appointment_id) AS total_appointments 
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name;

-- Q29
SELECT dept.department_name, COUNT(a.appointment_id) AS total_appointments 
FROM departments dept
JOIN doctors d ON dept.department_id = d.department_id
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY dept.department_id, dept.department_name;

-- Q30
SELECT dept.department_name, SUM(pay.paid_amount) AS total_revenue 
FROM departments dept
JOIN doctors d ON dept.department_id = d.department_id
JOIN appointments a ON d.doctor_id = a.doctor_id
JOIN bills b ON a.appointment_id = b.appointment_id
JOIN payments pay ON b.bill_id = pay.bill_id
WHERE pay.payment_status = 'Success'
GROUP BY dept.department_id, dept.department_name;

-- Q31
SELECT treatment_name, SUM(treatment_cost) AS total_cost 
FROM treatments 
GROUP BY treatment_name;

-- Q32
SELECT p.city, SUM(b.total_amount) AS total_billed 
FROM patients p
JOIN bills b ON p.patient_id = b.patient_id
GROUP BY p.city;

-- Q33
SELECT d.doctor_name, COUNT(a.appointment_id) AS appointment_count 
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
HAVING COUNT(a.appointment_id) > 2;

-- Q34
SELECT dept.department_name, SUM(pay.paid_amount) AS total_revenue 
FROM departments dept
JOIN doctors d ON dept.department_id = d.department_id
JOIN appointments a ON d.doctor_id = a.doctor_id
JOIN bills b ON a.appointment_id = b.appointment_id
JOIN payments pay ON b.bill_id = pay.bill_id
WHERE pay.payment_status = 'Success'
GROUP BY dept.department_id, dept.department_name
HAVING SUM(pay.paid_amount) > 20000;

-- Q35
SELECT city, COUNT(*) AS patient_count 
FROM patients 
GROUP BY city 
HAVING COUNT(*) > 2;

-- Q36
SELECT * FROM patients 
WHERE patient_id IN (SELECT DISTINCT patient_id FROM appointments);

-- Q37
SELECT * FROM patients 
WHERE patient_id NOT IN (SELECT DISTINCT patient_id FROM appointments);

-- Q38
SELECT * FROM doctors 
WHERE doctor_id NOT IN (SELECT DISTINCT doctor_id FROM appointments);

-- Q39
SELECT * FROM bills 
WHERE total_amount > (SELECT AVG(total_amount) FROM bills);

-- Q40
SELECT * FROM patients 
WHERE patient_id = (SELECT patient_id FROM bills ORDER BY total_amount DESC LIMIT 1);

-- Q41
SELECT * FROM doctors 
WHERE consultation_fee > (SELECT AVG(consultation_fee) FROM doctors);

-- Q42
SELECT * FROM patients 
WHERE patient_id IN (
    SELECT DISTINCT a.patient_id 
    FROM appointments a
    JOIN doctors d ON a.doctor_id = d.doctor_id
    JOIN departments dept ON d.department_id = dept.department_id
    WHERE dept.department_name = 'Cardiology'
);

-- Q43
SELECT * FROM bills 
WHERE bill_id NOT IN (SELECT bill_id FROM payments WHERE payment_status = 'Success');

-- Q44
SELECT * FROM appointments 
WHERE appointment_id IN (SELECT DISTINCT appointment_id FROM treatments);

-- Q45
SELECT p.patient_id, p.patient_name, SUM(b.total_amount) AS total_billed
FROM patients p
JOIN bills b ON p.patient_id = b.patient_id
GROUP BY p.patient_id, p.patient_name
HAVING SUM(b.total_amount) > (
    SELECT AVG(customer_total) FROM (
        SELECT SUM(total_amount) AS customer_total 
        FROM bills 
        GROUP BY patient_id
    ) AS inner_billing
);

-- Q46
SELECT * FROM appointments 
WHERE appointment_id NOT IN (SELECT appointment_id FROM treatments);

-- Q47
SELECT * FROM bills 
WHERE bill_id NOT IN (SELECT bill_id FROM payments);

-- Q48
SELECT * FROM payments WHERE paid_amount IS NULL OR paid_amount = 0;

-- Q49
SELECT a.appointment_id, a.appointment_status, b.bill_id, b.total_amount 
FROM appointments a
JOIN bills b ON a.appointment_id = b.appointment_id
WHERE a.appointment_status = 'Cancelled';

-- Q50
SELECT b.bill_id, b.total_amount, SUM(p.paid_amount) AS overall_paid
FROM bills b
JOIN payments p ON b.bill_id = p.bill_id
WHERE p.payment_status = 'Success'
GROUP BY b.bill_id, b.total_amount
HAVING overall_paid < b.total_amount;

-- Q51
SELECT d.* FROM doctors d
LEFT JOIN departments dept ON d.department_id = dept.department_id
WHERE d.department_id IS NOT NULL AND dept.department_id IS NULL;

-- Q52
SELECT a.* FROM appointments a
LEFT JOIN patients p ON a.patient_id = p.patient_id
LEFT JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE p.patient_id IS NULL OR d.doctor_id IS NULL;

-- Final Report
SELECT 
    p.patient_name,
    p.city,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COALESCE(SUM(DISTINCT b.total_amount), 0.00) AS total_bill_amount,
    COALESCE(SUM(CASE WHEN pay.payment_status = 'Success' THEN pay.paid_amount ELSE 0 END), 0.00) AS total_paid_amount,
    (COALESCE(SUM(DISTINCT b.total_amount), 0.00) - COALESCE(SUM(CASE WHEN pay.payment_status = 'Success' THEN pay.paid_amount ELSE 0 END), 0.00)) AS pending_amount
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id
LEFT JOIN bills b ON a.appointment_id = b.appointment_id
LEFT JOIN payments pay ON b.bill_id = pay.bill_id
GROUP BY p.patient_id, p.patient_name, p.city;