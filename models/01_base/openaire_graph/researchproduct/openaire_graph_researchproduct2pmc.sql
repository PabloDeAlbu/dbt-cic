with source as (
  select 
    researchproduct_id,
    scheme,
    value as pmc,
    load_datetime
  from {{ ref('openaire_graph_researchproduct2pid')}}
  where scheme = 'pmc'
)

select * from source
