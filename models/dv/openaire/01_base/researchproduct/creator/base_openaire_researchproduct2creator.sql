{{ config(materialized='table') }}

with source as (
      select * from {{ source('openaire', 'researchproduct2creator') }}
),
renamed as (
    select
        {{ adapter.quote("dri:objIdentifier") }} as researchproduct_id,
        {{ adapter.quote("@rank") }} as rank,
        {{ adapter.quote("@name") }} as name,
        {{ adapter.quote("@surname") }} as surname,
        {{ adapter.quote("#text") }} as text,
        {{ adapter.quote("@orcid") }} as orcid,
        {{ adapter.quote("@orcid_pending") }} as orcid_pending,
        {{ adapter.quote("load_datetime") }}

    from source
)
select * from renamed
