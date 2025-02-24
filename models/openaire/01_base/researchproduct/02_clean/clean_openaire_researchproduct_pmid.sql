with source as (
  select
    researchproduct_id,
    scheme,
    value as pmid,
    load_datetime,
    case
      when not (value ~* '^\d{7,8}$') then 'formato de pmid invalido'
      else 'ok'
    end as valid_reason
  from {{ ref('norm_openaire_researchproduct_pid')}}
  where scheme = 'pmid'
)

select * from source
