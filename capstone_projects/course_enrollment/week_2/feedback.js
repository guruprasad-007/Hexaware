// Connect to unstructured system space
db = db.getSiblingDB('campus_feedback_db');

// Drop collection if resetting system files
db.course_reviews.drop();

// Insert mock feedback objects array matching student records
db.course_reviews.insertMany([
  {
    "course_id": 1,
    "student_name": "Guru Prasad",
    "rating": 5,
    "review_text": "Excellent Deep Learning notebook layouts. The PySpark examples were top-tier.",
    "tags": ["Deep Learning", "PySpark"],
    "verified_completion": true
  },
  {
    "course_id": 2,
    "student_name": "Meghana Reddy",
    "rating": 4,
    "review_text": "Azure architectures are covered clearly, though I would like more content on serverless orchestration setups.",
    "tags": ["Azure", "Cloud"],
    "verified_completion": false
  },
  {
    "course_id": 3,
    "student_name": "Siddharth Singh",
    "rating": 2,
    "review_text": "Dropped early because the course pace accelerated too quickly for complete beginners.",
    "tags": ["MERN", "Web Dev"],
    "verified_completion": false
  }
]);

// Performance Optimization: Build compound tracking indexes to accelerate searching
db.course_reviews.createIndex({ "course_id": 1, "rating": -1 });
db.course_reviews.createIndex({ "tags": 1 });

// Output verification script
print("MongoDB Course Feedback Store Populated Cleanly.");