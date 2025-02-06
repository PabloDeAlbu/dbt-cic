{{ config(materialized='table') }}

with source as (
      select * from {{ source('openaire', 'researchproduct2pid') }}
),
renamed as (
    select
        {{ adapter.quote("dri:objIdentifier") }} as researchproduct_id,
        {{ adapter.quote("@classid") }} as pid_id,
        {{ adapter.quote("#text") }} as pid_text,
        {{ adapter.quote("load_datetime") }}
    from source
)
select * from renamed
