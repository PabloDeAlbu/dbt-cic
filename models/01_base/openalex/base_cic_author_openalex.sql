{{ config(materialized='table')}}

with source as (
      select * from {{ source('openalex', 'author') }}
),
renamed as (
    select
        {{ adapter.quote("id") }} as author_id,
        {{ adapter.quote("orcid") }},
        {{ adapter.quote("display_name") }},
        {{ adapter.quote("works_count") }},
        {{ adapter.quote("cited_by_count") }},
        {{ adapter.quote("updated_date") }},
        {{ adapter.quote("created_date") }},
        {{ adapter.quote("load_datetime") }}
    from source
)
select * from renamed