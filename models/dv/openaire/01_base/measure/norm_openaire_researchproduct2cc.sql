{{ config(materialized='table') }}

with base as (
    SELECT
        id,
        measure_score,
        measure_class,
        measure_datasource,
        load_datetime
    FROM 
        {{ ref('base_openaire_researchproduct2measure') }} rp
    WHERE measure_id = 'influence_alt'
),

final as (
    select * from base
)

select * from final
