{{ config(materialized='table') }}

with base as (
    SELECT
        researchproduct_id,
        date_text,
        is_inferred,
        provenanceaction,
        trust,
        load_datetime
    FROM 
        {{ ref('base_researchproduct2relevantdate_openaire') }} rp
    WHERE date_id = 'issued'
),

final as (
    select * from base
)

select * from final
