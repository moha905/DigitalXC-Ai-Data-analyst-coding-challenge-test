{{ config(
    materialized='table'
) }}

WITH cleaned AS (
    SELECT DISTINCT
        inc_number AS ticket_id,
        inc_category AS category,
        inc_short_description AS sub_category,
        inc_priority AS priority,
        inc_state AS status,
        inc_assignment_group AS assigned_group,
        inc_assigned_to AS technician,
        NULL::float AS resolution_time_hrs,
        inc_sys_created_on::timestamp AS created_date,
        inc_resolved_at::timestamp AS resolved_date,
        NULL::text AS customer_impact
    FROM {{ source('public', 'tickets_raw') }}
    WHERE inc_number IS NOT NULL
)
SELECT
    *,
    EXTRACT(YEAR FROM created_date) AS created_year,
    EXTRACT(MONTH FROM created_date) AS created_month,
    EXTRACT(DAY FROM created_date) AS created_day,
    CASE WHEN status ILIKE 'closed' OR resolved_date IS NOT NULL THEN 1 ELSE 0 END AS is_closed
FROM cleaned
