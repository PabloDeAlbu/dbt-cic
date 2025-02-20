with source as (
  select 
    researchproduct_id,
    scheme,
    value as handle,
    load_datetime
  from {{ ref('norm_openaire_researchproduct_pid')}}
  where scheme = 'handle' 
  -- handles con prefijo 123456789, aparecen como urls completas.
  -- and value like 'http%'
)

select * from source
