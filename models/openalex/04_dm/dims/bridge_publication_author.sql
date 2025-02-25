WITH base as (
    SELECT 
        work2author_hk,
        work_hk,
        author_hk
    FROM {{ref('link_openalex_work2author')}}
)

SELECT * FROM base