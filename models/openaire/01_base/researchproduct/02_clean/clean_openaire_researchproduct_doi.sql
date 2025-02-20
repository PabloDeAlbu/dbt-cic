with base as (
  select
    researchproduct_id,
    scheme,
    value as doi,
    load_datetime
  from {{ ref('norm_openaire_researchproduct_pid')}}
  where scheme = 'doi'
  AND value ~* '^10\.\d{4,9}/[-._;()/:a-zA-Z0-9]+$'  -- Solo mantiene DOIs válidos
),

unique_rp as (
  select researchproduct_id, count(*)
  from base 
  group by researchproduct_id 
  having count(*) = 1
),

final as (
  select *
  from base where researchproduct_id in (select researchproduct_id from unique_rp)
)

select * from final