{{ config(
    materialized="table"
) }}

WITH src AS (
    SELECT * FROM {{ ref('fct_trips') }}
),
aggregated AS (
    SELECT 
        fy_year,
        fy_quarter,
        service_type,
        SUM(total_amount) AS revenue
    FROM src
    GROUP BY 1, 2,3
),
final AS (
    SELECT 
        fy_year,
        fy_quarter,
        service_type,
        revenue,
        LAG(revenue) OVER (PARTITION BY fy_quarter,service_type ORDER BY fy_year) AS prev_year_revenue,
        SAFE_DIVIDE(revenue - LAG(revenue) OVER (PARTITION BY fy_quarter,service_type ORDER BY fy_year), 
                    LAG(revenue) OVER (PARTITION BY fy_quarter,service_type ORDER BY fy_year)) * 100 AS yoy_growth_percentage
    FROM aggregated
)
SELECT * FROM final
--where lower(service_type) = 'yellow'/'green'
ORDER BY fy_year, fy_quarter asc , service_type asc


