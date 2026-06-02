// MongoDB Queries for Food Delivery Capstone Project
// Q1
db.customers.find()

// Q2
db.restaurants.find()

// Q3
db.customers.find({}, { name: 1, city: 1, membership: 1, _id: 0 })

// Q4
db.customers.find({ city: "Hyderabad" })

// Q5
db.customers.find({ membership: "Gold" })

// Q6
db.restaurants.find({ rating: { $gt: 4.5 } })

// Q7
db.orders.find({ order_amount: { $gt: 500 } })

// Q8
db.orders.find({ order_status: "Delivered" })

// Q9
db.orders.find({ order_status: "Cancelled" })

// Q10
db.customers.find({ phone: null })

// Q11
db.orders.find({ order_amount: { $gte: 400, $lte: 700 } })

// Q12
db.customers.find({ city: { $in: ["Hyderabad", "Delhi", "Mumbai"] } })

// Q13
db.restaurants.find({ cuisine: { $in: ["Indian", "Fast Food"] } })

// Q14
db.orders.find({ "payment.status": { $ne: "Success" } })

// Q15
db.orders.find({ delivery_time_minutes: null })

// Q16
db.orders.find({ order_rating: { $gte: 4 } })

// Q17
db.restaurants.find({ city: { $nin: ["Bangalore", "Chennai"] } })

// Q18
db.orders.find({ "items.item_name": "Biryani" })

// Q19
db.orders.find({ "items.item_name": "Pizza" })

// Q20
db.orders.find({ "items.quantity": { $gt: 1 } })

// Q21
db.orders.find({ "items.price": { $gt: 300 } })

// Q22
db.orders.find({}, { order_id: 1, items: 1, _id: 0 })

// Q23
db.restaurants.find().sort({ rating: -1 })

// Q24
db.restaurants.find().sort({ rating: -1 }).limit(3)

// Q25
db.orders.find().sort({ order_amount: -1 })

// Q26
db.orders.find().sort({ order_amount: -1 }).limit(2)

// Q27
db.delivery_partners.find().sort({ rating: -1 })

// Q28
db.customers.updateOne({ customer_id: 1 }, { $set: { membership: "Platinum" } })

// Q29
db.restaurants.updateOne({ restaurant_id: 104 }, { $set: { rating: 4.1 } })

// Q30
db.orders.updateOne({ order_id: 1003 }, { $set: { order_status: "Delivered" } })

// Q31
db.orders.updateOne({ order_id: 1003 }, { $set: { delivery_time_minutes: 45 } })

// Q32
db.customers.updateMany({}, { $set: { active: true } })

// Q33
db.customers.updateMany({}, { $unset: { active: "" } })

// Q34
db.orders.updateOne(
  { order_id: 1006 },
  { $push: { items: { item_name: "Curd Rice", quantity: 1, price: 120 } } }
)

// Q35
db.orders.deleteMany({ order_status: "Cancelled" })

// Q36
db.restaurants.deleteMany({ rating: { $lt: 4.0 } })

// Q37
db.customers.countDocuments()

// Q38
db.orders.countDocuments()

// Q39
db.orders.countDocuments({ order_status: "Delivered" })

// Q40
db.orders.countDocuments({ "payment.status": "Failed" })

// Q41
db.customers.distinct("city")

// Q42
db.restaurants.distinct("cuisine")

// Q43
db.orders.distinct("payment.mode")

// Q44
db.orders.aggregate([
  {
    $group: {
      _id: "$payment.mode",
      "Total Revenue": { $sum: "$order_amount" }
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
db.orders.aggregate([
  {
    $group: {
      _id: "$order_status",
      "Total Revenue": { $sum: "$order_amount" }
    }
  },
  {
    $project: {
      "Order Status": "$_id",
      "Total Revenue": 1,
      _id: 0
    }
  }
])

// Q46
db.orders.aggregate([
  { 
    $match: { 
      order_status: "Delivered", 
      delivery_time_minutes: { $ne: null } 
    } 
  },
  {
    $group: {
      _id: null,
      "Average Delivery Time": { $avg: "$delivery_time_minutes" }
    }
  },
  {
    $project: { _id: 0, "Average Delivery Time": 1 }
  }
])

// Q47
db.orders.aggregate([
  {
    $group: {
      _id: "$customer_id",
      "Total Orders": { $sum: 1 },
      "Total Amount": { $sum: "$order_amount" }
    }
  },
  {
    $project: {
      "Customer ID": "$_id",
      "Total Orders": 1,
      "Total Amount": 1,
      _id: 0
    }
  }
])

// Q48
db.orders.aggregate([
  {
    $group: {
      _id: "$restaurant_id",
      "Total Orders": { $sum: 1 },
      "Total Revenue": { $sum: "$order_amount" }
    }
  },
  {
    $project: {
      "Restaurant ID": "$_id",
      "Total Orders": 1,
      "Total Revenue": 1,
      _id: 0
    }
  }
])

// Q49
db.orders.aggregate([
  { $match: { order_rating: { $ne: null } } },
  {
    $group: {
      _id: "$restaurant_id",
      "Average Order Rating": { $avg: "$order_rating" }
    }
  },
  {
    $project: {
      "Restaurant ID": "$_id",
      "Average Order Rating": 1,
      _id: 0
    }
  }
])

// Q50
db.orders.aggregate([
  {
    $group: {
      _id: "$customer_id",
      total_spending: { $sum: "$order_amount" }
    }
  },
  { $match: { total_spending: { $gt: 700 } } },
  {
    $project: {
      "Customer ID": "$_id",
      "Total Spending": "$total_spending",
      _id: 0
    }
  }
])

// Q51
db.orders.aggregate([
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "customer_id",
      as: "customer_info"
    }
  },
  { $unwind: "$customer_info" },
  {
    $project: {
      _id: 0,
      "Order ID": "$order_id",
      "Customer Name": "$customer_info.name",
      "City": "$customer_info.city",
      "Order Amount": "$order_amount",
      "Order Status": "$order_status"
    }
  }
])

// Q52
db.orders.aggregate([
  {
    $lookup: {
      from: "restaurants",
      localField: "restaurant_id",
      foreignField: "restaurant_id",
      as: "restaurant_info"
    }
  },
  { $unwind: "$restaurant_info" },
  {
    $project: {
      _id: 0,
      "Order ID": "$order_id",
      "Restaurant Name": "$restaurant_info.name",
      "Cuisine": "$restaurant_info.cuisine",
      "Order Amount": "$order_amount"
    }
  }
])

// Q53
db.orders.aggregate([
  {
    $lookup: {
      from: "delivery_partners",
      localField: "partner_id",
      foreignField: "partner_id",
      as: "partner_info"
    }
  },
  { 
    $unwind: { 
      path: "$partner_info", 
      preserveNullAndEmptyArrays: true // Keeps orders even if partner_id is null/cancelled
    } 
  },
  {
    $project: {
      _id: 0,
      "Order ID": "$order_id",
      "Partner Name": { $ifNull: ["$partner_info.partner_name", "Not Assigned"] },
      "Delivery Time": "$delivery_time_minutes",
      "Order Status": "$order_status"
    }
  }
])

// Q54
db.orders.aggregate([
  // Join Customers
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "customer_id",
      as: "cust"
    }
  },
  { $unwind: "$cust" },
  
  // Join Restaurants
  {
    $lookup: {
      from: "restaurants",
      localField: "restaurant_id",
      foreignField: "restaurant_id",
      as: "rest"
    }
  },
  { $unwind: "$rest" },
  
  // Join Delivery Partners
  {
    $lookup: {
      from: "delivery_partners",
      localField: "partner_id",
      foreignField: "partner_id",
      as: "partner"
    }
  },
  { $unwind: { path: "$partner", preserveNullAndEmptyArrays: true } },
  
  // Map and Project Fields
  {
    $project: {
      _id: 0,
      "Order ID": "$order_id",
      "Customer Name": "$cust.name",
      "Restaurant Name": "$rest.name",
      "Cuisine": "$rest.cuisine",
      "Partner Name": { $ifNull: ["$partner.partner_name", "Not Assigned"] },
      "Order Amount": "$order_amount",
      "Payment Mode": "$payment.mode",
      "Payment Status": "$payment.status",
      "Order Status": "$order_status",
      "Delivery Time": "$delivery_time_minutes",
      "Rating": "$order_rating"
    }
  }
])