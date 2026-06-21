-- Create operational database container
CREATE DATABASE IF NOT EXISTS campus_tracker;
USE campus_tracker;

-- Drop tables if resetting system
DROP TABLE IF EXISTS progress;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;

-- 1. Create Students Master Table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    joined_date DATE NOT NULL
);

-- 2. Create Courses Table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    department VARCHAR(50) NOT NULL,
    credits INT NOT NULL
);

-- 3. Create Enrollments Core Table
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    status ENUM('Active', 'Completed', 'Dropped') DEFAULT 'Active',
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- 4. Create Progress Log Tracking Table
CREATE TABLE progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    completion_percentage DECIMAL(5,2) DEFAULT 0.00,
    last_updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- SEED MOCK TRANSACTIONAL VALUES
-- ---------------------------------------------------------
INSERT INTO students (student_name, email, joined_date) VALUES
('Guru Prasad', 'guru@hexaware.local', '2026-01-15'),
('Ananya Rao', 'ananya@hexaware.local', '2026-01-20'),
('Siddharth Singh', 'siddharth@hexaware.local', '2026-02-01'),
('Meghana Reddy', 'meghana@hexaware.local', '2026-02-10');

INSERT INTO courses (course_name, department, credits) VALUES
('Introduction to Deep Learning', 'Data Science', 4),
('Enterprise Cloud Systems Azure', 'Cloud Infrastructure', 3),
('Full-Stack MERN Engineering', 'Software Engineering', 4);

INSERT INTO enrollments (student_id, course_id, enrollment_date, status) VALUES
(1, 1, '2026-06-01', 'Active'),
(1, 2, '2026-06-02', 'Completed'),
(2, 1, '2026-06-01', 'Active'),
(3, 3, '2026-06-03', 'Dropped'),
(4, 2, '2026-06-04', 'Active');

INSERT INTO progress (enrollment_id, completion_percentage) VALUES
(1, 45.50),
(2, 100.00),
(3, 72.00),
(4, 12.00),
(5, 85.00);

-- ---------------------------------------------------------
-- PERFORMANCE SEARCH INDEXES Optimization
-- ---------------------------------------------------------
CREATE INDEX idx_enrollment_student ON enrollments(student_id);
CREATE INDEX idx_enrollment_course ON enrollments(course_id);

-- ---------------------------------------------------------
-- STORED PROCEDURE: Calculate Course Completion Metrics
-- ---------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE GetStudentCompletionMetrics(IN p_student_id INT, OUT p_avg_progress DECIMAL(5,2))
BEGIN
    SELECT AVG(p.completion_percentage) INTO p_avg_progress
    FROM progress p
    JOIN enrollments e ON p.enrollment_id = e.enrollment_id
    WHERE e.student_id = p_student_id;
END$$

DELIMITER ;
