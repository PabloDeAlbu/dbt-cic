{{ config(materialized='table') }}

with source as (
      select * from {{ source('openaire', 'researchproduct2relevantdate') }}
),
renamed as (
    select
        {{ adapter.quote("dri:objIdentifier") }} as id,
        {{ adapter.quote("@classid") }} as date_id,
        {# {{ adapter.quote("@classname") }}, #}
        {# {{ adapter.quote("@schemeid") }}, #}
        {# {{ adapter.quote("@schemename") }}, #}
        {{ adapter.quote("#text") }} as date_text,
        {{ adapter.quote("@inferred") }} as is_inferred,
        {{ adapter.quote("@provenanceaction") }} as provenanceaction,
        {{ adapter.quote("@trust") }} as trust,
        {{ adapter.quote("load_datetime") }}

    from source
)
select * from renamed