

SELECT
    EXTRACT(YEAR FROM created_date) AS created_year,
    EXTRACT(MONTH FROM created_date) AS created_month,
    COUNT(ticket_id) AS total_tickets,
    SUM(CASE WHEN is_closed = 1 THEN 1 ELSE 0 END) AS closed_tickets
FROM "itsm_db"."public"."tickets_analysis"
GROUP BY EXTRACT(YEAR FROM created_date), EXTRACT(MONTH FROM created_date)
ORDER BY EXTRACT(YEAR FROM created_date), EXTRACT(MONTH FROM created_date)