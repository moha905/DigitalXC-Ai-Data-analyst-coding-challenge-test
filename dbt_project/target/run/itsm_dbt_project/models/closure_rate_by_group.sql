
  
    

  create  table "itsm_db"."public"."closure_rate_by_group__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    assigned_group,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN is_closed = 1 THEN 1 ELSE 0 END)::float / COUNT(*) * 100 AS closure_rate_percent
FROM "itsm_db"."public"."tickets_analysis"
GROUP BY assigned_group
ORDER BY closure_rate_percent DESC
  );
  