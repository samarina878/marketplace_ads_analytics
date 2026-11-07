-- Проверяем рекламные расходы
SELECT
    COUNT(*) FILTER (
        WHERE event_type = 'click'
    ) AS clicks,
    SUM(ad_cost) AS total_spend
FROM ad_events;

-- Проверяем завершённые заказы
SELECT
    COUNT(*) AS completed_orders,
    SUM(revenue) AS total_revenue
FROM orders
WHERE status = 'completed';

SELECT
    ROUND(SUM(ad_cost), 2) AS total_spend
FROM ad_events;

SELECT
    event_type,
    COUNT(*) AS event_count,
    ROUND(SUM(ad_cost), 2) AS total_spend
FROM ad_events
GROUP BY event_type
ORDER BY event_type;

SELECT
    event_id,
    campaign_id,
    user_id,
    ad_cost
FROM ad_events
WHERE event_type = 'click'
ORDER BY event_id
LIMIT 10;

SELECT
    COUNT(*) AS total_rows
FROM ad_events_new;


SELECT
    COUNT(*) AS total_events,
    COUNT(*) FILTER (
        WHERE event_type = 'click'
    ) AS clicks,
    ROUND(SUM(ad_cost), 2) AS total_spend,
    MAX(ad_cost) AS max_cost
FROM ad_events_new;

