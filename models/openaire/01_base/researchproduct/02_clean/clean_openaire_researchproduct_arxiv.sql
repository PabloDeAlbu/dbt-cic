with source as (
  select 
    researchproduct_id,
    'arxiv' as scheme,
    value as arxiv,
    load_datetime
  from {{ ref('norm_openaire_researchproduct_pid')}}
  where scheme = 'arXiv'
)

select * from source
