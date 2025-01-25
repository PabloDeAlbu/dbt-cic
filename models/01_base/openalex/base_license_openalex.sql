with source as (
      select * from {{ source('openalex', 'license') }}
),
renamed as (
    select
        {{ adapter.quote("license_id") }},
        {{ adapter.quote("license_display_name") }},
        {{ adapter.quote("count") }},
        {{ adapter.quote("load_datetime") }}

    from source
)
select * from renamed
  