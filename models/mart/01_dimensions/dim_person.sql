WITH base AS (
    SELECT 
    
    FROM {{ref('hub_author_openalex')}}
    INNER JOIN {{ref('sat_author_openalex')}} ON hub_author_openalex.author_hk = sat_author_openalex.author_hk
)

SELECT * FROM base