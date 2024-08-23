with base as (
    SELECT
        hub_author_openalex.author_hk,
        hub_author_openalex.author_id,
        hub_orcid_openalex.author_orcid
    FROM {{ref('hub_author_openalex')}}
    LEFT JOIN {{ref('link_author_orcid_openalex')}} ON hub_author_openalex.author_hk = link_author_orcid_openalex.author_hk
    LEFT JOIN {{ref('hub_orcid_openalex')}} ON hub_orcid_openalex.orcid_hk = link_author_orcid_openalex.orcid_hk
)

SELECT * FROM base