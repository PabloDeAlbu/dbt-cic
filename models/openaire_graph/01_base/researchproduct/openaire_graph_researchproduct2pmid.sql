with source as (
  select
    researchproduct_id,
    scheme,
    value as pmid,
    load_datetime
  from {{ ref('openaire_graph_researchproduct2pid')}}
  where scheme = 'pmid'
)

select * from source
