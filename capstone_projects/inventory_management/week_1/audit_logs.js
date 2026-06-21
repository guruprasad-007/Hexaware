db = db.getSiblingDB('inventory_audit_db');
db.adjustment_logs.drop();

db.adjustment_logs.insertMany([
  {
    "movement_id": 1001,
    "product_id": 1,
    "adjustment_reason": "Damaged items found during audit check",
    "manager_signoff": "Guru Prasad",
    "severity_flag": "Medium"
  },
  {
    "movement_id": 1002,
    "product_id": 3,
    "adjustment_reason": "Bulk promotional giveaway distribution",
    "tags": ["Marketing", "Promo"],
    "manager_signoff": "Ananya Rao"
  }
]);

db.adjustment_logs.createIndex({ "product_id": 1 });
print("MongoDB Unstructured Audit Logs Seeded Cleanly.");