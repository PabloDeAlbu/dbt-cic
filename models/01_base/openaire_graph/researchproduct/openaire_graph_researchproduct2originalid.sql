with source as (
        select * from {{ source('openaire_graph_researchproduct', 'researchproduct2originalId') }}
  ),
  renamed as (
      select
        COALESCE({{ adapter.quote("id") }}::varchar, 'NO DATA') as researchproduct_id,
        COALESCE({{ adapter.quote("originalId") }}::varchar, 'NO DATA') as original_id,
        load_datetime
      from source
  )
  select * from renamed
