WITH base as (
    SELECT 
        worktype,
        label,
        resourcetype_id,
        label_es,
        {{ dbt_date.today() }} as load_datetime
    FROM {{ref('seed_resourcetype_coar2worktype_openalex')}}
)

SELECT * FROM base