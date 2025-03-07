with base as(
    select * from {{ref('map_openaire_researchproduct_author')}}
    where pid_value != 'NO DATA'
)

select * from base