with base as (
    SELECT
        hub_dauthor_openalex.dauthor_hk,
        hub_dauthor_openalex.author_id,
        hub_orcid_openalex.author_orcid
    FROM {{ref('hub_dauthor_openalex')}}
    LEFT JOIN {{ref('link_dauthor_orcid_openalex')}} ON hub_dauthor_openalex.dauthor_hk = link_dauthor_orcid_openalex.dauthor_hk
    LEFT JOIN {{ref('hub_orcid_openalex')}} ON hub_orcid_openalex.orcid_hk = link_dauthor_orcid_openalex.orcid_hk
)

SELECT * FROM base