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



