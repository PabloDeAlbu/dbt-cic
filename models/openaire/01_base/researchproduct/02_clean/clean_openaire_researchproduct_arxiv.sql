with base as (
  select 
    researchproduct_id,
    'arxiv' as scheme,
    value as arxiv,
    load_datetime,
    case
      when not (
        value ~* '^arXiv:(\d{4}\.\d{4,5}|[a-z-]+/\d{7})$' -- arXiv estándar
        or value ~* '^https?://arxiv\.org/abs/(\d{4}\.\d{4,5}|[a-z-]+/\d{7})$' -- arXiv en URL
      )
      then 'formato arxiv inválido'
      else 'ok'
    end as valid_reason
  from {{ ref('map_openaire_researchproduct_pid')}}
  where scheme = 'arXiv'
)

select * from base
