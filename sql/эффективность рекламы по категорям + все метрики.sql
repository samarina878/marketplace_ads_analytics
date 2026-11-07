-- ЭФФЕКТИВНОСТЬ РЕКЛАМЫ ПО КАТЕГОРИЯМ
-- ========================================

WITH ad_metrics AS (
    SELECT
        campaign_id,
        COUNT(*) FILTER (
            WHERE event_type = 'impression'
        ) AS impressions,
        COUNT(*) FILTER (
            WHERE event_type = 'click'
        ) AS clicks,
        SUM(ad_cost) AS ad_spend
    FROM ad_events_new
    GROUP BY campaign_id
),

order_metrics AS (
    SELECT
        campaign_id,
        COUNT(*) AS orders_count,
        SUM(revenue) AS revenue
    FROM orders
    WHERE status = 'completed'
    GROUP BY campaign_id
)

SELECT
    c.category,

    SUM(COALESCE(a.impressions, 0)) AS impressions,
    SUM(COALESCE(a.clicks, 0)) AS clicks,
    SUM(COALESCE(o.orders_count, 0)) AS orders_count,

    ROUND(
        100.0 * SUM(COALESCE(a.clicks, 0)) /
        NULLIF(SUM(COALESCE(a.impressions, 0)), 0),
        2
    ) AS ctr,

    ROUND(
        SUM(COALESCE(a.ad_spend, 0)) /
        NULLIF(SUM(COALESCE(a.clicks, 0)), 0),
        2
    ) AS cpc,

    ROUND(
        100.0 * SUM(COALESCE(o.orders_count, 0)) /
        NULLIF(SUM(COALESCE(a.clicks, 0)), 0),
        2
    ) AS cvr,

    ROUND(
        SUM(COALESCE(o.revenue, 0)) /
        NULLIF(SUM(COALESCE(a.ad_spend, 0)), 0),
        2
    ) AS roas

FROM campaigns c

LEFT JOIN ad_metrics a
    ON c.campaign_id = a.campaign_id

LEFT JOIN order_metrics o
    ON c.campaign_id = o.campaign_id

GROUP BY c.category

ORDER BY roas DESC;