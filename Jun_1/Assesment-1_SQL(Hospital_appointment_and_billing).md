Database Design & Table Relationships

The schema utilizes a highly unified relational model centered around the orders master-transaction layout:

One-to-Many (customers → orders): A single customer can trigger multiple purchases over time.

Many-to-Many Structural Resolution: The order_items schema functions as an associative link table breaking down the complex mapping between orders and products.

One-to-One / Contextual Extensions (orders → payments / deliveries): Tracks the direct micro-state progression of a transaction.

Key Operational Insights from Reports
Revenue Concentration: Cities like Mumbai and Hyderabad act as structural focal points for total customer lifetime values (LTV), making them prime candidates for localized marketing campaigns.

Product Affinity Analysis: High-margin units in the Electronics category dominate the absolute gross value indices, while Fashion drives order frequencies via lower unit-value baskets.

Process Integrity & Quality Flaws: Running Data Quality Checks (specifically Query 49) isolated an operational anomaly: Order ID 311 reflects a Cancelled status despite a successful transactional capture of ₹3,798.00. This highlights an immediate business requirement to trigger an automated customer refund sequence.