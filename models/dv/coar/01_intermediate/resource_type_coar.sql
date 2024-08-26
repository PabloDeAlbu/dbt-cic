WITH base as (
    SELECT 
        *,
        CURRENT_DATE as load_datetime
    FROM {{ref('seed_resource_type_coar')}}
)

SELECT * FROM base