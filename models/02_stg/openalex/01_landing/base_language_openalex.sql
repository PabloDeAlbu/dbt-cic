with source as (
      select * from {{ source('openalex', 'language') }}
),
renamed as (
    select
        {{ adapter.quote("language_id") }},
        {{ adapter.quote("language_display_name") }},
        {{ adapter.quote("count") }},
        {{ adapter.quote("load_datetime") }}

    from source
)
select * from renamed
  