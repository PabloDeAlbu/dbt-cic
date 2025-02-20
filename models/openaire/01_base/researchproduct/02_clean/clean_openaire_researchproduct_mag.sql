with source as (
  select
    researchproduct_id,
    scheme,
    value as mag,
    load_datetime
  from {{ ref('norm_openaire_researchproduct_pid')}}
  where scheme = 'mag_id'
)

select * from source
