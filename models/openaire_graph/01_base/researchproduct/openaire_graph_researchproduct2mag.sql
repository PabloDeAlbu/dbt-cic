with source as (
  select
    researchproduct_id,
    scheme,
    value as mag,
    load_datetime
  from {{ ref('openaire_graph_researchproduct2pid')}}
  where scheme = 'mag_id'
)

select * from source
