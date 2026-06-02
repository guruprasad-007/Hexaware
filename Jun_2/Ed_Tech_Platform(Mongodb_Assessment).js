// use edtech_capstone_db

// Sample Data for Learners Collection
db.learners.insertMany([
{
learner_id: 1,
name: "Rahul Sharma",
city: "Hyderabad",
experience_years: 2,
goal: "Data Engineer",
phone: "9876543210"
},
{
learner_id: 2,
name: "Priya Reddy",
city: "Bangalore",
experience_years: 4,
goal: "AI Engineer",
phone: "9876543211"
},
{
learner_id: 3,
name: "Amit Kumar",
city: "Mumbai",
experience_years: 1,
goal: "Data Analyst",
phone: null
},
{
learner_id: 4,
name: "Sneha Patel",
city: "Chennai",
experience_years: 6,
goal: "ML Engineer",
phone: "9876543213"
},
{
learner_id: 5,
name: "Farhan Ali",

city: "Delhi",
experience_years: 3,
goal: "Cloud Engineer",
phone: "9876543214"
},
{
learner_id: 6,
name: "Meera Nair",
city: "Pune",
experience_years: 0,
goal: "AI Engineer",
phone: null
}
])

// Sample Data for Instructors Collection
db.instructors.insertMany([
{
instructor_id: 101,
instructor_name: "Abdullah Khan",
expertise: ["AI", "Data Engineering", "Cloud"],
rating: 4.9
},
{
instructor_id: 102,
instructor_name: "Neha Singh",
expertise: ["Power BI", "SQL", "Analytics"],
rating: 4.6
},
{
instructor_id: 103,
instructor_name: "Ravi Kumar",
expertise: ["Python", "Machine Learning"],
rating: 4.7
}
])

// Sample Data for Courses Collection
db.courses.insertMany([
{
course_id: 201,
course_name: "Data Engineering with Azure",
category: "Data Engineering",
instructor_id: 101,
price: 15000,
level: "Intermediate",
tools: ["SQL", "Python", "Azure Data Factory", "Databricks"]
},
{
course_id: 202,
course_name: "AI Engineer Roadmap",
category: "Artificial Intelligence",
instructor_id: 101,
price: 20000,
level: "Beginner",
tools: ["Python", "OpenAI", "Vector DB", "LangChain"]
},
{
course_id: 203,
course_name: "Power BI for Business",
category: "Analytics",
instructor_id: 102,
price: 8000,
level: "Beginner",
tools: ["Power BI", "Excel", "SQL"]
},
{
course_id: 204,
course_name: "Machine Learning Practical",
category: "Machine Learning",
instructor_id: 103,
price: 12000,
level: "Intermediate",
tools: ["Python", "Scikit-learn", "Pandas"]
},
{
course_id: 205,
course_name: "Cloud AI Engineer",

category: "Cloud",
instructor_id: 101,
price: 18000,
level: "Advanced",
tools: ["Azure", "AWS", "GCP", "AI Services"]
}
])

// Sample Data for Enrollments Collection
db.enrollments.insertMany([
{
enrollment_id: 1001,
learner_id: 1,
course_id: 201,
enrollment_date: ISODate("2026-01-10"),
payment: {
amount: 15000,
mode: "UPI",
status: "Success"
},
progress: {
completed_modules: 8,
total_modules: 10,
completion_percent: 80
},
quiz_scores: [75, 82, 88],
status: "Active"
},
{
enrollment_id: 1002,
learner_id: 2,
course_id: 202,
enrollment_date: ISODate("2026-01-15"),
payment: {
amount: 20000,
mode: "Card",
status: "Success"
},
progress: {
completed_modules: 10,

total_modules: 10,
completion_percent: 100
},
quiz_scores: [90, 92, 95],
status: "Completed"
},
{
enrollment_id: 1003,
learner_id: 3,
course_id: 203,
enrollment_date: ISODate("2026-02-01"),
payment: {
amount: 8000,
mode: "Cash",
status: "Pending"
},
progress: {
completed_modules: 3,
total_modules: 8,
completion_percent: 37.5
},
quiz_scores: [60, 65],
status: "Active"
},
{
enrollment_id: 1004,
learner_id: 4,
course_id: 204,
enrollment_date: ISODate("2026-02-10"),
payment: {
amount: 12000,
mode: "UPI",
status: "Success"
},
progress: {
completed_modules: 6,
total_modules: 12,
completion_percent: 50
},
quiz_scores: [78, 80, 85],
status: "Active"
},
{
enrollment_id: 1005,

learner_id: 5,
course_id: 205,
enrollment_date: ISODate("2026-03-05"),
payment: {
amount: 18000,
mode: "Card",
status: "Failed"
},
progress: {
completed_modules: 0,
total_modules: 12,
completion_percent: 0
},
quiz_scores: [],
status: "Payment Failed"
},
{
enrollment_id: 1006,
learner_id: 6,
course_id: 202,
enrollment_date: ISODate("2026-03-12"),
payment: {
amount: 20000,
mode: "UPI",
status: "Success"
},
progress: {
completed_modules: 2,
total_modules: 10,
completion_percent: 20
},
quiz_scores: [55],
status: "Active"
}
])


// Queries for EdTech Capstone Project

// Q1 
db.learners.find()

// Q2
db.courses.find()

// Q3
db.learners.find({}, { name: 1, city: 1, goal: 1, _id: 0 })

// Q4
db.learners.find({ city: "Hyderabad" })

// Q5
db.learners.find({ goal: "AI Engineer" })

// Q6
db.courses.find({ category: "Data Engineering" })

// Q7
db.courses.find({ price: { $gt: 10000 } })

// Q8
db.courses.find({ level: "Beginner" })

// Q9
db.enrollments.find({ "payment.status": "Success" })

// Q10
db.learners.find({ phone: null })

// Q11
db.learners.find({ experience_years: { $gt: 2 } })

// Q12
db.courses.find({ price: { $gte: 8000, $lte: 18000 } })

// Q13
db.courses.find({ level: { $in: ["Beginner", "Intermediate"] } })

// Q14
db.enrollments.find({ "progress.completion_percent": { $gte: 80 } })

// Q15
db.enrollments.find({ "payment.status": { $ne: "Success" } })

// Q16
db.learners.find({ city: { $in: ["Hyderabad", "Bangalore", "Pune"] } })

// Q17
db.courses.find({ category: { $ne: "Cloud" } })

// Q18
db.instructors.find({ expertise: "AI" })

// Q19
db.instructors.find({ expertise: "SQL" })

// Q20
db.courses.find({ tools: "Python" })

// Q21
db.courses.find({ tools: "Databricks" })

// Q22
db.enrollments.find({ quiz_scores: 95 })

// Q23
db.enrollments.find({ quiz_scores: { $gt: 85 } })

// Q24
db.courses.find().sort({ price: -1 })

// Q25
db.courses.find().sort({ price: -1 }).limit(3)

// Q26
db.learners.find().sort({ experience_years: -1 })

// Q27
db.learners.find().sort({ experience_years: -1 }).limit(2)

// Q28
db.instructors.find().sort({ rating: -1 })

// Q29
db.learners.updateOne({ learner_id: 1 }, { $set: { city: "Secunderabad" } })

// Q30
db.courses.updateOne({ course_id: 203 }, { $set: { price: 9000 } })

// Q31
db.enrollments.updateOne(
  { enrollment_id: 1006 },
  { $set: { "progress.completion_percent": 30 } }
)

// Q32
db.enrollments.updateOne({ enrollment_id: 1005 }, { $set: { status: "Inactive" } })

// Q33
db.learners.updateMany({}, { $set: { active: true } })

// Q34
db.learners.updateMany({}, { $unset: { active: "" } })

// Q35
db.courses.updateOne({ course_id: 201 }, { $push: { tools: "MongoDB" } })

// Q36
db.enrollments.deleteMany({ "payment.status": "Failed" })

// Q37
db.learners.deleteMany({ experience_years: 0 })

// Q38
db.learners.countDocuments()

// Q39
db.courses.countDocuments()

// Q40
db.enrollments.countDocuments({ "payment.status": "Success" })

// Q41
db.learners.distinct("city")

// Q42
db.courses.distinct("category")

// Q43
db.enrollments.distinct("payment.mode")

// Q44
db.enrollments.aggregate([
  { $match: { "payment.status": "Success" } },
  {
    $group: {
      _id: "$payment.mode",
      "Total Revenue": { $sum: "$payment.amount" }
    }
  },
  {
    $project: {
      "Payment Mode": "$_id",
      "Total Revenue": 1,
      _id: 0
    }
  }
])

// Q45
db.enrollments.aggregate([
  { $match: { "payment.status": "Success" } },
  {
    $group: {
      _id: "$course_id",
      "Total Revenue": { $sum: "$payment.amount" }
    }
  },
  {
    $project: {
      "Course ID": "$_id",
      "Total Revenue": 1,
      _id: 0
    }
  }
])

// Q46
db.learners.aggregate([
  {
    $group: {
      _id: "$goal",
      "Learner Count": { $sum: 1 }
    }
  },
  {
    $project: {
      "Goal": "$_id",
      "Learner Count": 1,
      _id: 0
    }
  }
])

// Q47
db.courses.aggregate([
  {
    $group: {
      _id: "$category",
      "Average Price": { $avg: "$price" }
    }
  },
  {
    $project: {
      "Category": "$_id",
      "Average Price": 1,
      _id: 0
    }
  }
])

// Q48
db.enrollments.aggregate([
  {
    $group: {
      _id: "$course_id",
      "Average Completion %": { $avg: "$progress.completion_percent" }
    }
  },
  {
    $project: {
      "Course ID": "$_id",
      "Average Completion %": 1,
      _id: 0
    }
  }
])

// Q49
db.enrollments.aggregate([
  {
    $group: {
      _id: "$status",
      "Enrollment Count": { $sum: 1 }
    }
  },
  {
    $project: {
      "Status": "$_id",
      "Enrollment Count": 1,
      _id: 0
    }
  }
])

// Q50
db.enrollments.aggregate([
  { $match: { "payment.status": "Success" } },
  {
    $group: {
      _id: "$course_id",
      revenue: { $sum: "$payment.amount" }
    }
  },
  { $match: { revenue: { $gt: 15000 } } },
  {
    $project: {
      "Course ID": "$_id",
      "Total Revenue": "$revenue",
      _id: 0
    }
  }
])

// Q51
db.enrollments.aggregate([
  {
    $lookup: {
      from: "learners",
      localField: "learner_id",
      foreignField: "learner_id",
      as: "learner_details"
    }
  },
  { $unwind: "$learner_details" },
  {
    $project: {
      _id: 0,
      "Enrollment ID": "$enrollment_id",
      "Learner Name": "$learner_details.name",
      "City": "$learner_details.city",
      "Course ID": "$course_id",
      "Status": "$status"
    }
  }
])

// Q52
db.enrollments.aggregate([
  {
    $lookup: {
      from: "courses",
      localField: "course_id",
      foreignField: "course_id",
      as: "course_details"
    }
  },
  { $unwind: "$course_details" },
  {
    $project: {
      _id: 0,
      "Enrollment ID": "$enrollment_id",
      "Course Name": "$course_details.course_name",
      "Category": "$course_details.category",
      "Amount": "$payment.amount",
      "Payment Status": "$payment.status"
    }
  }
])

// Q53
db.courses.aggregate([
  {
    $lookup: {
      from: "instructors",
      localField: "instructor_id",
      foreignField: "instructor_id",
      as: "instructor_details"
    }
  },
  { $unwind: "$instructor_details" },
  {
    $project: {
      _id: 0,
      "Course Name": "$course_name",
      "Category": "$category",
      "Instructor Name": "$instructor_details.instructor_name",
      "Instructor Rating": "$instructor_details.rating"
    }
  }
])

// Q54
db.enrollments.aggregate([
  // Join Learners
  {
    $lookup: {
      from: "learners",
      localField: "learner_id",
      foreignField: "learner_id",
      as: "l"
    }
  },
  { $unwind: "$l" },

  // Join Courses
  {
    $lookup: {
      from: "courses",
      localField: "course_id",
      foreignField: "course_id",
      as: "c"
    }
  },
  { $unwind: "$c" },

  // Join Instructors (Using Course's instructor_id)
  {
    $lookup: {
      from: "instructors",
      localField: "c.instructor_id",
      foreignField: "instructor_id",
      as: "i"
    }
  },
  { $unwind: "$i" },

  // Field Selection and Clean Projection
  {
    $project: {
      _id: 0,
      "Enrollment ID": "$enrollment_id",
      "Learner Name": "$l.name",
      "City": "$l.city",
      "Goal": "$l.goal",
      "Course Name": "$c.course_name",
      "Category": "$c.category",
      "Instructor Name": "$i.instructor_name",
      "Payment Amount": "$payment.amount",
      "Payment Status": "$payment.status",
      "Completion %": "$progress.completion_percent",
      "Enrollment Status": "$status"
    }
  }
])



