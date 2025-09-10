

SELECT
    assigned_group,
    COUNT(ticket_id) AS total_tickets,
    SUM(is_closed) AS closed_tickets,
    ROUND( (SUM(is_closed)::decimal / COUNT(ticket_id)) * 100, 2) AS closure_rate_percent
FROM "itsm_db"."public"."tickets_analysis"
GROUP BY assigned_group
ORDER BY closure_rate_percent DESC;