

SELECT
    category,
    priority,
    ROUND(
        AVG(
            COALESCE(
                resolution_time_hrs,
                EXTRACT(EPOCH FROM (resolved_date - created_date))/3600
            )
        )::numeric,
        2
    ) AS avg_resolution_hours
FROM "itsm_db"."public"."tickets_analysis"
GROUP BY category, priority