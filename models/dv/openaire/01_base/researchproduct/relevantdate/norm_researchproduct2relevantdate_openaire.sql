{{ config(materialized='table') }}

with base as (
    SELECT
        researchproduct_id,
        {{ dbt_date.convert_timezone("date_text") }} as date_text,
        date_id,
        is_inferred,
        provenanceaction,
        trust,
        load_datetime
    FROM {{ ref('base_researchproduct2relevantdate_openaire') }}
),

final as (
    select * from base
)

select * from final
