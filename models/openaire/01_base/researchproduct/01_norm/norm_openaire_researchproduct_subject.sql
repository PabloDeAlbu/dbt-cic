with source as (
        select * from {{ source('openaire', 'map_researchproduct_subject') }}
  ),
  renamed as (
      select
        COALESCE({{ adapter.quote("id") }}::varchar, 'NO DATA') as id,
        COALESCE({{ adapter.quote("provenance") }}::varchar, 'NO DATA' ) as provenance,
        COALESCE({{ adapter.quote("subject.scheme") }}::varchar, 'NO DATA') as subject_scheme,
        COALESCE({{ adapter.quote("subject.value") }}::varchar, 'NO DATA') as subject_value

      from source
  )
  select * from renamed
    