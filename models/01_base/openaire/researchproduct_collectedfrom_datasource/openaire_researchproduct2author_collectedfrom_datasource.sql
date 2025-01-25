with source as (
        select * from {{ source('openaire_researchproduct_collectedfrom_datasource', 'researchproduct2author') }}
  ),
  renamed as (
      select
        COALESCE({{ adapter.quote("id") }}::varchar, 'NO DATA') as id,
        COALESCE({{ adapter.quote("fullName") }}::varchar, 'NO DATA') as full_name,
        COALESCE({{ adapter.quote("name") }}::varchar, 'NO DATA') as name,
        COALESCE({{ adapter.quote("pid") }}::varchar, 'NO DATA') as pid,
        COALESCE({{ adapter.quote("rank") }}::int, 0) as rank,
        COALESCE({{ adapter.quote("surname") }}::varchar, 'NO DATA') as surname

      from source
  )
  select * from renamed
    