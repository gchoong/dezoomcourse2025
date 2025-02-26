{{
    config(
        materialized='table'
    )
}}

with src as 
(
    select * from {{ref("dim_fhv_trips")}}
),
main as 
(
    select
    dispatching_base_num,
    pickup_datetime,
    dropoff_datetime,
    pickup_locationid,
    dropoff_locationid,
    sr_flag,
    affiliated_base_number,
    pickup_borough,
    pickup_zone,
    dropoff_borough,
    dropoff_zone,
    fy_year,
    fy_month,
    fy_quarter,
    {{ datediff("pickup_datetime", "dropoff_datetime", "second") }} as trip_duration
    from 
    src   
),
calculation as (
select 
    pickup_zone,
    dropoff_zone,
    fy_year,
    fy_month,
    PERCENTILE_CONT(trip_duration, 0.90) OVER (partition by fy_year, fy_month, pickup_locationid,dropoff_locationid) AS duration_p90,
from main
where pickup_zone in 
(
--'Newark Airport'
'SoHo'
--'Yorkville East'
)
and fy_year = 2019
and fy_month = 11
order by fy_month desc
)
select distinct * from calculation
order by duration_p90 asc