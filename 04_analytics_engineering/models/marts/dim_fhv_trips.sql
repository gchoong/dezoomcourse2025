{{
    config(
        materialized='table'
    )
}}

with 
fhv as (
    select * from {{ ref('stg_fhv_trip_data') }}
),
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    fhv.*,
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    EXTRACT(YEAR FROM fhv.pickup_datetime) as fy_year,
    EXTRACT(MONTH FROM fhv.pickup_datetime) as fy_month,
    EXTRACT(QUARTER FROM fhv.pickup_datetime) as fy_quarter
from fhv
inner join dim_zones as pickup_zone
on fhv.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv.dropoff_locationid = dropoff_zone.locationid
order by pickup_datetime desc
