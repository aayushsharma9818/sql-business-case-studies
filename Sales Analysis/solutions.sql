-- 1. Monthly Revenue Trend
SELECT 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS order_month,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY order_month
ORDER BY order_month;

-- 2. Top 5 Products by Sales
SELECT 
    `Product Name`,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 5;

-- 3. Repeat Customers
SELECT 
    COUNT(*) AS repeat_customers
FROM (
    SELECT `Customer ID`
    FROM superstore
    GROUP BY `Customer ID`
    HAVING COUNT(DISTINCT `Order ID`) > 1
) t;

-- 4. Region-wise Sales
SELECT 
    Region,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC;

-- 5. Category-wise Sales
SELECT 
    Category,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY Category
ORDER BY total_sales DESC;
