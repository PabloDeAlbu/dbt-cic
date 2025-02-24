with source as (
  select 
    researchproduct_id,
    scheme,
    value as pmc,
    load_datetime,
    case
      when not (value ~* '^PMC\d+$') then 'formato de pmc invalido'
      else 'ok'
    end as valid_reason
  from {{ ref('norm_openaire_researchproduct_pid')}}
  where scheme = 'pmc'
)

select * from source
