with base as(
    select * from {{ref('norm_openaire_researchproduct_author')}}
    where pid != 'NO DATA'
)

select * from base