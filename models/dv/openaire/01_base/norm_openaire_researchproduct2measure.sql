{{ config(materialized='table') }}

with base as (
    SELECT
        id,
        measure_id,
        measure_score,
        measure_class,
        measure_datasource,
        load_datetime
    FROM 
        {{ ref('base_openaire_researchproduct2measure') }} rp
),

final as (
    select * from base
)

select * from final
