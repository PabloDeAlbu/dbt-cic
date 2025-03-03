WITH base as (
    SELECT 
        work_author_hk,
        work_hk,
        author_hk
    FROM {{ref('link_openalex_work_author')}}
)

SELECT * FROM base