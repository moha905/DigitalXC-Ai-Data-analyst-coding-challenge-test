
  
    

  create  table "itsm_db"."public"."avg_resolution_by_cat_priority__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    category,
    priority,
    AVG(resolution_time_hrs) AS avg_resolution_hours,
    COUNT(ticket_id) AS total_tickets
FROM "itsm_db"."public"."tickets_analysis"
WHERE resolution_time_hrs IS NOT NULL
GROUP BY category, priority
ORDER BY category, priority;
  );
  