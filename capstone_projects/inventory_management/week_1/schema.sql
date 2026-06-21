-- Create inventory tracking database container
CREATE DATABASE IF NOT EXISTS inventory_tracker;
USE inventory_tracker;

-- Drop existing tables to ensure clean resets
DROP TABLE IF EXISTS stock_movements;
DROP TABLE IF EXISTS warehouses;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS suppliers;

-- 1. Suppliers Table
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    reorder_level INT NOT NULL DEFAULT 10,
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE SET NULL
);

-- 3. Warehouses Table
CREATE TABLE warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- 4. Stock Movements Table (Tracks Ins and Outs)
CREATE TABLE stock_movements (
    movement_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    warehouse_id INT,
    quantity_changed INT NOT NULL, -- Positive for incoming stock, Negative for outgoing shipments
    movement_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- PERFORMANCE OPTIMIZATION INDEXES
-- ---------------------------------------------------------
CREATE INDEX idx_movement_product ON stock_movements(product_id);
CREATE INDEX idx_movement_warehouse ON stock_movements(warehouse_id);

-- ---------------------------------------------------------
-- SEED DATA MOCK ENTRIES
-- ---------------------------------------------------------
INSERT INTO suppliers (supplier_name, contact_email) VALUES
('Logitech Global', 'supply@logitech.local'),
('Dell Enterprise', 'parts@dell.local');

INSERT INTO products (product_name, reorder_level, supplier_id) VALUES
('Ergonomic Wireless Mouse', 15, 1),
('27-Inch 4K Monitor', 8, 2),
('Mechanical Keyboard', 12, 1);

INSERT INTO warehouses (warehouse_name, location) VALUES
('Main Hub Chennai', 'Chennai'),
('North Distribution Bangalore', 'Bangalore');

-- Seeding historical changes to compute running stock totals
INSERT INTO stock_movements (product_id, warehouse_id, quantity_changed, movement_date) VALUES
(1, 1, 50, '2026-06-01'),  -- Ingest 50 mice
(1, 1, -40, '2026-06-02'), -- Shipped 40 mice out (Current stock = 10, below reorder level of 15!)
(2, 2, 20, '2026-06-01'),  -- Ingest 20 monitors
(2, 2, -5, '2026-06-03'),   -- Shipped 5 monitors out (Current stock = 15)
(3, 1, 5, '2026-06-04');    -- Ingest 5 keyboards (Current stock = 5, below reorder level of 12!)

-- ---------------------------------------------------------
-- STORED PROCEDURE: Identify Products Needing Urgent Reorder
-- ---------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE GetLowStockItems()
BEGIN
    SELECT 
        p.product_id,
        p.product_name,
        p.reorder_level,
        SUM(sm.quantity_changed) AS current_stock_level
    FROM products p
    JOIN stock_movements sm ON p.product_id = sm.product_id
    GROUP BY p.product_id, p.product_name, p.reorder_level
    HAVING current_stock_level <= p.reorder_level;
END$$

DELIMITER ;