{{ config(materialized='table') }}

with source as (
      select * from {{ source('openaire', 'researchproduct') }}
),
renamed as (
    select
        {{ adapter.quote("dri:objIdentifier") }} as researchproduct_id,
        {{ adapter.quote("dri:dateOfCollection") }} as date_collection,
        {{ adapter.quote("dri:dateOfTransformation") }} as date_transformation,
        {{ adapter.quote("fulltext") }},
        {{ adapter.quote("dateofacceptance") }} as date_acceptance,
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
  