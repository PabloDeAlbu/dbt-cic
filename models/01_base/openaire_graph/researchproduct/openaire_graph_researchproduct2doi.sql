with source as (
  select
    researchproduct_id,
    scheme,
    value as doi,
    load_datetime
  from {{ ref('openaire_graph_researchproduct2pid')}}
  where scheme = 'doi'
)

select * from source
