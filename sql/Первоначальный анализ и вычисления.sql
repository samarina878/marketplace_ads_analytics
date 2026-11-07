-- 1. Проверяю активную базу данных

SELECT current_database();


-- 2. Проверяю количество строк

SELECT
    'campaigns' AS table_name,
    COUNT(*) AS rows_count
FROM campaigns

SELECT 'ad_events', COUNT(*)
FROM ad_events_new


SELECT 'orders', COUNT(*)
FROM orders


SELECT 'experiment_users', COUNT(*)
FROM experiment_users;

-- АНАЛИЗ РЕКЛАМНЫХ СОБЫТИЙ

SELECT
    event_type,
    COUNT(*) AS events_count
FROM ad_events_new
GROUP BY event_type
ORDER BY events_count DESC;

-- Считаю общий CTR по всем рекламным кампаниям

SELECT
    COUNT(*) FILTER (
        WHERE event_type = 'impression'
    ) AS impressions,

    COUNT(*) FILTER (
        WHERE event_type = 'click'
    ) AS clicks,

    ROUND(
        100.0 *
        COUNT(*) FILTER (
            WHERE event_type = 'click'
        )
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE event_type = 'impression'
            ), 0
        ),
        2
    ) AS ctr

FROM ad_events_new;