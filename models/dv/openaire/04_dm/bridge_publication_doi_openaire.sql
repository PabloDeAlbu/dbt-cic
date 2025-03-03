with base as (
    SELECT 
        link.researchproduct_hk,
        doi.doi
    FROM {{ref('link_openaire_researchproduct_doi')}} link
    INNER JOIN {{ref('hub_openaire_doi')}} doi ON link.doi_hk = doi.doi_hk
    group by 1
)

select * from base