//MongoDB Queries for Restaurants Collection

// q1
db.restaurants.find()

// q2
db.restaurants.find({}, {name:1, city:1, cuisine:1, _id:0})

// q3
db.restaurants.find({city:"Hyderabad"})

// q4
db.restaurants.find({cuisine:"Indian"})

// q5
db.restaurants.find({delivery_available:true})

// q6
db.restaurants.find({rating:{$gt:4.5}})

// q7
db.restaurants.find({avg_order_value:{$lt:400}})

// q8
db.restaurants.find({rating:{$gte:4.0,$lte:4.7}})

// q9
db.restaurants.find({avg_order_value:{$gte:600}})

// q10
db.restaurants.find({city:"Hyderabad",delivery_available:true})

// q11
db.restaurants.find({
$or:[
{city:"Chennai"},
{cuisine:"Indian"}
]
})

// q12
db.restaurants.find({delivery_available:false})

// q13
db.restaurants.find({
city:{$in:["Hyderabad","Delhi","Mumbai"]}
})

// q14
db.restaurants.find({
cuisine:{$in:["Indian","Italian","Cafe"]}
})

// q15
db.restaurants.find({
city:{$nin:["Hyderabad","Bangalore"]}
})

// q16
db.restaurants.find({name:/^P/})

// q17
db.restaurants.find({name:/Point/})

// q18
db.restaurants.find({cuisine:/Food/})

// q19
db.restaurants.find({"contact.phone":null})

// q20
db.restaurants.find({"contact.email":null})

// q21
db.restaurants.find({
$or:[
{"contact.phone":null},
{"contact.email":null}
]
})

// q22
db.restaurants.find({tags:"premium"})

// q23
db.restaurants.find({tags:"fast food"})

// q24
db.restaurants.find({
tags:{$all:["north indian","premium"]}
})

// q25
db.restaurants.find().sort({rating:-1})

// q26
db.restaurants.find().sort({rating:-1}).limit(3)

// q27
db.restaurants.find().sort({avg_order_value:1})

// q28
db.restaurants.find().sort({avg_order_value:-1}).limit(2)

// q29
db.restaurants.updateOne(
{name:"Burger Street"},
{$set:{rating:4.0}}
)

// q30
db.restaurants.updateOne(
{name:"Tea Tales"},
{$set:{delivery_available:true}}
)

// q31
db.restaurants.updateMany(
{},
{$set:{active:true}}
)

// q32
db.restaurants.updateOne(
{name:"Spice Hub"},
{$push:{tags:"popular"}}
)

// q33
db.restaurants.updateMany(
{},
{$unset:{active:""}}
)

// q34
db.restaurants.deleteOne(
{restaurant_id:6}
)

// q35
db.restaurants.deleteMany(
{rating:{$lt:4.0}}
)

// q36
db.restaurants.countDocuments()

// q37
db.restaurants.countDocuments({
delivery_available:true
})

// q38
db.restaurants.distinct("city")

// q39
db.restaurants.distinct("cuisine")

// q40
db.restaurants.aggregate([
{
$group:{
_id:"$city",
count:{$sum:1}
}
}
])

// q41
db.restaurants.aggregate([
{
$group:{
_id:"$cuisine",
count:{$sum:1}
}
}
])

// q42
db.restaurants.aggregate([
{
$group:{
_id:"$cuisine",
avgRating:{$avg:"$rating"}
}
}
])

// q43
db.restaurants.aggregate([
{
$group:{
_id:"$city",
avgOrderValue:{$avg:"$avg_order_value"}
}
}
])

// q44
db.restaurants.aggregate([
{
$group:{
_id:"$cuisine",
avgOrderValue:{$avg:"$avg_order_value"}
}
},
{
$sort:{avgOrderValue:-1}
},
{
$limit:1
}
])

// q45
db.restaurants.aggregate([
{
$group:{
_id:"$cuisine",
count:{$sum:1}
}
},
{
$match:{
count:{$gt:1}
}
}
])