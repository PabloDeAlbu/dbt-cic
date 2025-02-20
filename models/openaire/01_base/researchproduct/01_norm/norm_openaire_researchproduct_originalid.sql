with source as (
        select * from {{ source('openaire', 'map_researchproduct_originalid') }}
  ),
  renamed as (
      select
        COALESCE({{ adapter.quote("id") }}::varchar, 'NO DATA') as researchproduct_id,
        COALESCE({{ adapter.quote("originalId") }}::varchar, 'NO DATA') as original_id,
        load_datetime
      from source
  )
  select * from renamed
