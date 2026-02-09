-- 1. Users at each funnel stage
SELECT 
    event_type,
    COUNT(DISTINCT visitorid) AS user_count
FROM ecommerce_events
GROUP BY event_type;


-- 2. View to Purchase Conversion Rate
WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'view' THEN visitorid END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'transaction' THEN visitorid END) AS purchases
    FROM ecommerce_events
)
SELECT 
    views,
    purchases,
    ROUND(purchases * 100.0 / views, 2) AS conversion_rate_pct
FROM funnel;


-- 3. Cart Abandonment
SELECT 
    COUNT(DISTINCT visitorid) AS cart_abandoners
FROM ecommerce_events
WHERE event_type = 'addtocart'
AND visitorid NOT IN (
    SELECT DISTINCT visitorid
    FROM ecommerce_events
    WHERE event_type = 'transaction'
);


-- 4. Add-to-Cart to Purchase Conversion
WITH cart_users AS (
    SELECT DISTINCT visitorid
    FROM ecommerce_events
    WHERE event_type = 'addtocart'
),
purchase_users AS (
    SELECT DISTINCT visitorid
    FROM ecommerce_events
    WHERE event_type = 'transaction'
)
SELECT 
    COUNT(DISTINCT p.visitorid) * 100.0 / COUNT(DISTINCT c.visitorid) 
    AS cart_to_purchase_conversion_pct
FROM cart_users c
LEFT JOIN purchase_users p
ON c.visitorid = p.visitorid;


-- 5. Repeat Purchasers
SELECT 
    COUNT(*) AS repeat_purchasers
FROM (
    SELECT visitorid
    FROM ecommerce_events
    WHERE event_type = 'transaction'
    GROUP BY visitorid
    HAVING COUNT(transactionid) > 1
) t;
