with source as (
      select * from {{ source('openalex', 'author2affiliation') }}
),
renamed as (
    select
        {{ adapter.quote("id") }},
        {{ adapter.quote("institution_id") }},
        {{ adapter.quote("years") }},
        {{ adapter.quote("load_datetime") }}

    from source
)
select * from renamed
  