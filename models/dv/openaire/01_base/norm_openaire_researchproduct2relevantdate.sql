{{ config(materialized='table') }}

with source as (
      select * from {{ ref('base_openaire_researchproduct2relevantdate') }}
),
renamed as (
    select
        id,
        date_id,
        date_text,
        is_inferred,
        provenanceaction,
        trust,
        load_datetime
    from source
)
select * from renamed