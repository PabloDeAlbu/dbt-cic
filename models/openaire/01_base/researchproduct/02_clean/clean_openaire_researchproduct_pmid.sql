with source as (
  select
    researchproduct_id,
    scheme,
    value as pmid,
    load_datetime
  from {{ ref('norm_openaire_researchproduct_pid')}}
  where scheme = 'pmid'
)

select * from source
