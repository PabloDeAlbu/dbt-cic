with base as (
  select
    researchproduct_id,
    scheme,
    value as mag,
    load_datetime,
    case
      when not (value ~* '^\d{5,}$') then 'formato mag invalido'
      else 'ok'
    end as valid_reason
  from {{ ref('map_openaire_researchproduct_pid')}}
  where scheme = 'mag_id'
)

select * from base
