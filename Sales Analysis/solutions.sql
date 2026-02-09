-- 1. Monthly Revenue Trend
SELECT 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS order_month,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY order_month
ORDER BY order_month;


-- 2. Month-over-Month (MoM) Growth
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(`Order Date`, '%Y-%m') AS order_month,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY order_month
)
SELECT 
    order_month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY order_month) AS previous_month_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY order_month))
        / LAG(total_sales) OVER (ORDER BY order_month) * 100, 2
    ) AS mom_growth_percentage
FROM monthly_sales;


-- 3. Top 5 Products by Sales
SELECT 
    `Product Name`,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 5;


-- 4. Contribution of Top Products to Total Sales
WITH product_sales AS (
    SELECT 
        `Product Name`,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY `Product Name`
),
overall_sales AS (
    SELECT SUM(total_sales) AS total FROM product_sales
)
SELECT 
    p.`Product Name`,
    p.total_sales,
    ROUND(p.total_sales / o.total * 100, 2) AS contribution_percentage
FROM product_sales p
CROSS JOIN overall_sales o
ORDER BY p.total_sales DESC
LIMIT 5;


-- 5. Region-wise Sales
SELECT 
    Region,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC;


-- 6. Category-wise Sales
SELECT 
    Category,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY Category
ORDER BY total_sales DESC;


-- 7. Sub-Category Performance
SELECT 
    `Sub-Category`,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Sub-Category`
ORDER BY total_sales DESC;


-- 8. Repeat Customers
SELECT 
    COUNT(*) AS repeat_customer_count
FROM (
    SELECT `Customer ID`
    FROM superstore
    GROUP BY `Customer ID`
    HAVING COUNT(DISTINCT `Order ID`) > 1
) t;


-- 9. Customer Segmentation by Sales Value
SELECT 
    `Customer ID`,
    SUM(Sales) AS total_sales,
    CASE 
        WHEN SUM(Sales) > 5000 THEN 'High Value'
        WHEN SUM(Sales) BETWEEN 2000 AND 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM superstore
GROUP BY `Customer ID`;


-- 10. State-wise Sales Contribution
SELECT 
    State,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY State
ORDER BY total_sales DESC;
