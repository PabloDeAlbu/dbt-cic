WITH base as (
    SELECT 
        *,
        {{ dbt_date.today() }} as load_datetime
    FROM {{ref('seed_resourcetype_coar2worktype_openalex')}}
)

SELECT * FROM base