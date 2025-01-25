with source as (
        select * from {{ source('openaire_researchproduct_collectedfrom_datasource', 'researchproduct2originalId') }}
  ),
  renamed as (
      select
        COALESCE({{ adapter.quote("id") }}::varchar, 'NO DATA') as id,
        COALESCE({{ adapter.quote("originalId") }}::varchar, 'NO DATA') as original_id
      from source
  )
  select * from renamed
    