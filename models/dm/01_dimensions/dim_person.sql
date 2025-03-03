WITH openalex AS (
    SELECT 
        hub.author_hk,
        hub.author_id,
        sat.orcid,
        sat.display_name,
        sat.works_count,
        sat.cited_by_count
    FROM {{ref('hub_openalex_author')}} hub
    INNER JOIN {{ref('sat_openalex_author')}} sat ON hub.author_hk = sat.author_hk
)

SELECT * FROM openalex