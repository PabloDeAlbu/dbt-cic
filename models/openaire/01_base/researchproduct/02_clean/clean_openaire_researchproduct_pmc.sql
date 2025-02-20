with source as (
  select 
    researchproduct_id,
    scheme,
    value as pmc,
    load_datetime
  from {{ ref('norm_openaire_researchproduct_pid')}}
  where scheme = 'pmc'
)

select * from source
