with 

source as (

    select * from {{ source('staging', 'fhv_trip_data') }}

),

renamed as (

    select
        cast(dispatching_base_num as string) as dispatching_base_num,
        PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', pickup_datetime) as pickup_datetime,
        PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', drop_off_datetime) as dropoff_datetime,
        {{ dbt.safe_cast("p_ulocation_id", api.Column.translate_type("numeric")) }} as pickup_locationid,
        {{ dbt.safe_cast("d_olocation_id", api.Column.translate_type("numeric")) }} as dropoff_locationid,
        {{ dbt.safe_cast("sr_flag", api.Column.translate_type("integer")) }} as sr_flag,
        affiliated_base_number

    from source

)

select * from renamed
where dispatching_base_num is not null
order by pickup_datetime desc