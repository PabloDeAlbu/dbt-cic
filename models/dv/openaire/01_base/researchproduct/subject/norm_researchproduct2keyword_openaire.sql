{{ config(materialized='table') }}

with base as (
    SELECT
        researchproduct_id,
        subject_text,
        is_inferred,
        provenanceaction,
        trust,
        inferenceprovenance,
        load_datetime
    FROM 
        {{ ref('base_researchproduct2subject_openaire') }} rp
    WHERE subject_id = 'keyword'
),

final as (
    select * from base
)

select * from final
