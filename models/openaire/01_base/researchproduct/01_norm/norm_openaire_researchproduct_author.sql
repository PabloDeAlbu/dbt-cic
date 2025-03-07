with source as (
        select * from {{ source('openaire', 'map_researchproduct_author') }}
  ),
  renamed as (
      select
        COALESCE({{ adapter.quote("id") }}::varchar, 'NO DATA') as researchproduct_id,
        COALESCE({{ adapter.quote("fullName") }}::varchar, 'NO DATA') as full_name,
        COALESCE({{ adapter.quote("name") }}::varchar, 'NO DATA') as name,
        COALESCE({{ adapter.quote("pid") }}::varchar, 'NO DATA') as pid,
        COALESCE({{ adapter.quote("rank") }}::int, 0) as rank,
        COALESCE({{ adapter.quote("surname") }}::varchar, 'NO DATA') as surname,
        {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime
      from source
  )
  select * from renamed
