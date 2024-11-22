{{ config(materialized='table') }}

with source as (
      select * from {{ source('openaire', 'researchproduct') }}
),
renamed as (
    select
        {{ adapter.quote("dri:objIdentifier") }} as id,
        {{ adapter.quote("dri:dateOfCollection") }} as dateofcollection,
        {{ adapter.quote("dri:dateOfTransformation") }} as dateoftransformation,
        {{ adapter.quote("fulltext") }},
        {{ adapter.quote("dateofacceptance") }},
        {{ adapter.quote("description") }},
        {{ adapter.quote("publisher") }},
        {{ adapter.quote("isgreen") }},
        {{ adapter.quote("openaccesscolor") }},
        {{ adapter.quote("isindiamondjournal") }},
        {{ adapter.quote("publiclyfunded") }},
        {{ adapter.quote("load_datetime") }}

    from source
)
select * from renamed
  