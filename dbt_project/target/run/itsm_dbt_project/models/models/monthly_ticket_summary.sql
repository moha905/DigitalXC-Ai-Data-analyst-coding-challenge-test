
  
    

  create  table "itsm_db"."public"."monthly_ticket_summary__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    created_year,
    created_month,
    COUNT(ticket_id) AS tickets_created,
    SUM(is_closed) AS tickets_closed
FROM "itsm_db"."public"."tickets_analysis"
GROUP BY created_year, created_month
ORDER BY created_year, created_month;
  );
  