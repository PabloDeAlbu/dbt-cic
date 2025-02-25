with base as (
  select 
    researchproduct_id,
    original_id,
    load_datetime
  from {{ ref('norm_openaire_researchproduct_originalid')}}
)

select * from base
