{{ config(materialized='table') }}

with source as (
      select * from {{ ref('base_openaire_researchproduct2subject') }}
),
renamed as (
    select
        id,
        subject_id,
        is_inferred,
        provenanceaction,
        trust,
        subject_text,
        inferenceprovenance,
        load_datetime
    from source
)
select * from renamed