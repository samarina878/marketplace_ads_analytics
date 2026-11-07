

-- ПОИСК КАМПАНИЙ С ВЫСОКИМ CTR И НИЗКИМ ROAS

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
),

campaign_metrics AS (
    SELECT
        c.campaign_id,
        c.category,

        100.0 * a.clicks /
        NULLIF(a.impressions, 0) AS ctr,

        COALESCE(o.revenue, 0) /
        NULLIF(a.ad_spend, 0) AS roas,

        a.ad_spend,
        a.clicks,
        COALESCE(o.orders_count, 0) AS orders_count

    FROM campaigns c

    LEFT JOIN ad_metrics a
        ON c.campaign_id = a.campaign_id

    LEFT JOIN order_metrics o
        ON c.campaign_id = o.campaign_id
),

medians AS (
    SELECT
        PERCENTILE_CONT(0.5)
            WITHIN GROUP (ORDER BY ctr) AS median_ctr,

        PERCENTILE_CONT(0.5)
            WITHIN GROUP (ORDER BY roas) AS median_roas

    FROM campaign_metrics
)

SELECT
    cm.campaign_id,
    cm.category,

    ROUND(cm.ctr, 2) AS ctr,
    ROUND(cm.roas, 2) AS roas,

    cm.clicks,
    cm.orders_count,
    ROUND(cm.ad_spend, 2) AS ad_spend

FROM campaign_metrics cm

CROSS JOIN medians m

WHERE cm.ctr > m.median_ctr
  AND cm.roas < m.median_roas

ORDER BY cm.roas ASC;


CREATE TABLE ad_events_new (
    LIKE ad_events INCLUDING all
);



