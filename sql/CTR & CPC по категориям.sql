-- Считаю CTR ПО КАТЕГОРИЯМ

SELECT
    c.category,

    COUNT(*) FILTER (
        WHERE e.event_type = 'impression'
    ) AS impressions,

    COUNT(*) FILTER (
        WHERE e.event_type = 'click'
    ) AS clicks,

    ROUND(
        100.0 *
        COUNT(*) FILTER (
            WHERE e.event_type = 'click'
        )
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE e.event_type = 'impression'
            ), 0
        ),
        2
    ) AS ctr

FROM ad_events_new e

JOIN campaigns c
    ON e.campaign_id = c.campaign_id

GROUP BY c.category

ORDER BY ctr DESC;

-- CPC И РАСХОДЫ ПО КАТЕГОРИЯМ

SELECT
    c.category,

    ROUND(
        SUM(e.ad_cost), 2
    ) AS total_spend,

    COUNT(*) FILTER (
        WHERE e.event_type = 'click'
    ) AS clicks,

    ROUND(
        SUM(e.ad_cost)
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE e.event_type = 'click'
            ), 0
        ),
        2
    ) AS cpc

FROM ad_events_new e

JOIN campaigns c
    ON e.campaign_id = c.campaign_id

GROUP BY c.category

ORDER BY total_spend DESC;

