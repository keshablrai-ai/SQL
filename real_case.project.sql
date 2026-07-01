-- 1. Setup Table
CREATE TABLE user_activity (
    user_id INT,
    activity_date DATE
);

-- 2. Insert Data 
INSERT INTO user_activity (user_id, activity_date) VALUES 
(1, '2024-01-01'), (2, '2024-01-01'), (1, '2024-01-02'), (3, '2024-01-02'), (2, '2024-01-02');

-- Problem 1: DAU Calculation 
SELECT activity_date, COUNT(DISTINCT user_id) AS dau
FROM user_activity
GROUP BY activity_date;

-- Problem 2: Retention (Next Day Login) 
SELECT DISTINCT a1.user_id
FROM user_activity a1
JOIN user_activity a2 ON a1.user_id = a2.user_id 
  AND a2.activity_date = a1.activity_date + INTERVAL '1 day';

  -- 1. Setup Table 
CREATE TABLE sales (
    category VARCHAR(50),
    product VARCHAR(50),
    revenue INT
);

-- 2. Insert Data 
INSERT INTO sales (category, product, revenue) VALUES 
('Electronics', 'Phone', 1000), ('Electronics', 'Laptop', 2000), 
('Electronics', 'Tablet', 1500), ('Clothing', 'Shirt', 500), ('Clothing', 'Jacket', 800);

-- Problem: Highest selling product per category 
SELECT category, product, revenue
FROM (
    SELECT category, product, revenue,
           RANK() OVER(PARTITION BY category ORDER BY revenue DESC) as rnk
    FROM sales
) ranked_sales
WHERE rnk = 1;


-- 1. Setup Table 
CREATE TABLE transactions (
    user_id INT,
    txn_date DATE,
    amount INT
);

-- 2. Insert Data 
INSERT INTO transactions (user_id, txn_date, amount) VALUES 
(1, '2024-01-01', 100), (1, '2024-02-01', 200), (2, '2024-01-05', 300);

-- Problem: Latest transaction per user 
SELECT user_id, txn_date, amount
FROM transactions
WHERE (user_id, txn_date) IN (
    SELECT user_id, MAX(txn_date)
    FROM transactions
    GROUP BY user_id
);

-- 1. Setup Table 
CREATE TABLE funnel (
    user_id INT,
    step VARCHAR(50)
);

-- 2. Insert Data 
INSERT INTO funnel (user_id, step) VALUES 
(1, 'view'), (1, 'cart'), (1, 'purchase'), (2, 'view'), (2, 'cart');

-- Problem: Count users who completed all steps
SELECT COUNT(*) as completed_funnel_count
FROM (
    SELECT user_id
    FROM funnel
    WHERE step IN ('view', 'cart', 'purchase')
    GROUP BY user_id
    HAVING COUNT(DISTINCT step) = 3
) as successful_users;
  
