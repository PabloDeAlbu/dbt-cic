{{ config(materialized='table') }}

with source as (
      select * from {{ source('openaire', 'researchproduct2subject') }}
),
renamed as (
    select
        {{ adapter.quote("dri:objIdentifier") }} as researchproduct_id,
        {{ adapter.quote("@classid") }} as subject_id,
        {# {{ adapter.quote("@classname") }}, #}
        {# {{ adapter.quote("@schemeid") }}, #}
        {# {{ adapter.quote("@schemename") }}, #}
        {{ adapter.quote("@inferred") }} as is_inferred,
        {{ adapter.quote("@provenanceaction") }} as provenanceaction,
        {{ adapter.quote("@trust") }} as trust,
        {{ adapter.quote("#text") }} as subject_text,
        {{ adapter.quote("@inferenceprovenance") }} as inferenceprovenance,
        {{ adapter.quote("load_datetime") }}

    from source
)
select * from renamed