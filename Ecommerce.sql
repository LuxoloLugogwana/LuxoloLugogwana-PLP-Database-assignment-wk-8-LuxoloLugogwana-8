-- Creating database
CREATE DATABASE Ecommerce_store;
USE Ecommerce_store;

-- Create tables with relationships

-- 1. Create USERS TABLE
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT chk_email_format CHECK (email LIKE '%@%.%')
);

-- 2. Create CATEGORIES TABLE
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

-- 3. Create PRODUCTS TABLE
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE RESTRICT,
    CONSTRAINT chk_price_positive CHECK (price > 0),
    CONSTRAINT chk_stock_nonnegative CHECK (stock_quantity >= 0)
);

-- 4. Create ORDERS TABLE
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE RESTRICT,
    CONSTRAINT chk_total_positive CHECK (total_amount > 0)
);

-- 5. Create ORDER_ITEMS TABLE
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT,
    CONSTRAINT chk_quantity_positive CHECK (quantity > 0),
    CONSTRAINT chk_unit_price_positive CHECK (unit_price > 0),
    UNIQUE KEY unique_order_product (order_id, product_id)
);

-- DATA INSERTION

-- INSERT into users table
INSERT INTO users (username, email, first_name, last_name, phone, city) VALUES
('lethu_Bejula', 'lethu@email.com', 'Lethu', 'Bejula', '555-0101', 'Cape Town'),
('john_smith', 'john@email.com', 'John', 'Smith', '555-0102', 'Mossel Bay'),
('bob_wilson', 'bob@email.com', 'Bob', 'Wilson', '555-0103', 'Grahamstown'),
('alice_brown', 'alice@email.com', 'Alice', 'Brown', '555-0104', 'Port Elizabeth'),
('themba_bavuma', 'themba@email.com', 'Themba', 'Bavuma', '555-0105', 'King Williams Town');

-- INSERT into categories table
INSERT INTO categories (category_name, description, parent_category_id) VALUES
('Electronics', 'Electronic devices and gadgets', NULL),
('Computers', 'Desktop and laptop computers', 1),
('Smartphones', 'Mobile phones and accessories', 1),
('Laptops', 'Portable computers', 2),
('Gaming', 'Gaming accessories and peripherals', 2);

-- INSERT into products table
INSERT INTO products (product_name, category_id, sku, price, stock_quantity) VALUES
('MacBook Pro 16"', 4, 'LAPTOP-MBP16-001', 2499.99, 10),
('iPhone 14 Pro', 3, 'PHONE-IP14P-001', 1099.99, 25),
('Gaming Mouse', 5, 'GAME-MOUSE-001', 79.99, 50),
('Wireless Keyboard', 5, 'GAME-KEYB-001', 149.99, 30),
('iPad Pro', 1, 'TABLET-IPAD-001', 899.99, 15);

-- INSERT into orders table
INSERT INTO orders (user_id, order_status, total_amount) VALUES
(1, 'delivered', 2579.98),
(2, 'shipped', 229.98),
(3, 'processing', 1099.99),
(4, 'pending', 949.98),
(5, 'delivered', 149.99);

-- INSERT into order_items table
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
(1, 1, 1, 2499.99, 2499.99),
(1, 3, 1, 79.99, 79.99),
(2, 4, 1, 149.99, 149.99),
(2, 3, 1, 79.99, 79.99),
(3, 2, 1, 1099.99, 1099.99);

-- VERIFICATION QUERIES

-- Display all data to verify relationships
SELECT 'USERS TABLE' as Table_Name;
SELECT * FROM users;

-- categories table query
SELECT 'CATEGORIES TABLE (Self-Referencing)' as Table_Name;
SELECT
    c1.category_id,
    c1.category_name,
    c1.description,
    c2.category_name as parent_category
FROM categories c1
LEFT JOIN categories c2 ON c1.parent_category_id = c2.category_id;

-- products table query
SELECT 'PRODUCTS TABLE (One-to-Many with Categories)' as Table_Name;
SELECT
    p.product_id,
    p.product_name,
    p.sku,
    p.price,
    p.stock_quantity,
    c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- orders table query
SELECT 'ORDERS TABLE (One-to-Many with Users)' as Table_Name;
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount,
    CONCAT(u.first_name, ' ', u.last_name) as customer_name
FROM orders o
JOIN users u ON o.user_id = u.user_id;

-- order_items table query
SELECT 'ORDER_ITEMS TABLE (Many-to-Many Junction)' as Table_Name;
SELECT
    oi.order_item_id,
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.total_price,
    CONCAT(u.first_name, ' ', u.last_name) as customer_name
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN users u ON o.user_id = u.user_id;

-- RELATIONSHIP DEMONSTRATION QUERIES

-- Show category hierarchy (Self-Referencing)
SELECT 'CATEGORY HIERARCHY' as Query_Type;
SELECT
    CASE
        WHEN parent_category_id IS NULL THEN category_name
        ELSE CONCAT('  └── ', category_name)
    END as hierarchy
FROM categories
ORDER BY
    COALESCE(parent_category_id, category_id),
    category_id;


-- 2. Products per category (One-to-Many)
SELECT 'PRODUCTS PER CATEGORY' as Query_Type;
SELECT
    c.category_name,
    COUNT(p.product_id) as product_count,
    GROUP_CONCAT(p.product_name SEPARATOR ', ') as products
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

-- 3. Orders per user (One-to-Many)
SELECT 'ORDERS PER USER' as Query_Type;
SELECT
    CONCAT(u.first_name, ' ', u.last_name) as customer_name,
    COUNT(o.order_id) as order_count,
    SUM(o.total_amount) as total_spent
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.first_name, u.last_name;

-- 4. Product popularity (Many-to-Many via order_items)
SELECT 'PRODUCT POPULARITY' as Query_Type;
SELECT
    p.product_name,
    COUNT(oi.order_item_id) as times_ordered,
    SUM(oi.quantity) as total_quantity_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY times_ordered DESC;