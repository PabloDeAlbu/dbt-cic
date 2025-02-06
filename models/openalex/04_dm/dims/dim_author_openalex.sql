WITH base as (
    SELECT 
        sat.author_hk,
        sat.author_id,
        sat.orcid,
        sat.display_name,
        sat.works_count,
        sat.cited_by_count
    FROM {{ref('hub_author_openalex')}} hub
    INNER JOIN {{ref('sat_author_openalex')}} sat ON hub.author_hk = sat.author_hk
)

SELECT * FROM base