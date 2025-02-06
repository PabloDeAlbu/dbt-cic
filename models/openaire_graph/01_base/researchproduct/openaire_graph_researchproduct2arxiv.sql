with source as (
  select 
    researchproduct_id,
    'arxiv' as scheme,
    value as arxiv,
    load_datetime
  from {{ ref('openaire_graph_researchproduct2pid')}}
  where scheme = 'arXiv'
)

select * from source
