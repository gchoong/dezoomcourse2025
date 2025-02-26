{{ config(
    materialized="table"
) }}

WITH src AS (
    SELECT * FROM {{ ref('fct_trips') }}
    where fare_amount > 0
    and
    trip_distance > 0 
    and 
    UPPER(payment_type_description) in ('CASH','CREDIT CARD')
),
percentiles AS (
    SELECT 
        *,
        PERCENTILE_CONT(fare_amount, 0.90) OVER (partition by service_type,fy_year,fy_month) AS fare_p90,
        PERCENTILE_CONT(fare_amount, 0.95) OVER (partition by service_type,fy_year,fy_month) AS fare_p95,
        PERCENTILE_CONT(fare_amount, 0.97) OVER (partition by service_type,fy_year,fy_month) AS fare_p97
    FROM src
)

SELECT distinct fy_year,fy_month,fare_p90,fare_p95,fare_p97 
FROM percentiles
where lower(service_type) = 'yellow'--/green
and fy_year in ('2020-01-01')
and fy_month = 4