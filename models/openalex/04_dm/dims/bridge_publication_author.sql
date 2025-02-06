WITH base as (
    SELECT 
        work2author_hk,
        work_hk,
        author_hk
    FROM {{ref('link_work2author_openalex')}}
)

SELECT * FROM base