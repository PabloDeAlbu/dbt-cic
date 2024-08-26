WITH 
hub_doi_openalex AS (
    SELECT 
        doi_hk, 
        doi, 
        TRUE AS in_openalex,
        FALSE AS in_openaire,
        FALSE AS in_oai
    FROM {{ref('hub_doi_openalex')}}
),

hub_doi_oai AS (
    SELECT
        doi_hk,
        doi,
        TRUE AS in_oai,
        FALSE AS in_openalex,
        FALSE AS in_openaire
    FROM {{ref('hub_doi_oai')}}
),

base AS (
    SELECT
        COALESCE(openalex.doi_hk, oai.doi_hk) as doi_hk,
        COALESCE(openalex.doi, oai.doi) as doi,
        COALESCE(openalex.in_oai, oai.in_oai) as in_oai,
        COALESCE(openalex.in_openalex, oai.in_openalex) as in_openalex,
        COALESCE(openalex.in_openaire, oai.in_openaire) as in_openaire
    FROM hub_doi_openalex openalex
    FULL OUTER JOIN hub_doi_oai oai ON openalex.doi_hk = oai.doi_hk
    {# FULL OUTER JOIN hub_doi_oai oai ON COALESCE(openalex.doi, oai.doi) = oai.doi #}
),

final AS (
    SELECT
    doi_hk,
    doi,
    CONCAT('https://doi.org/', doi) as doi_url,
    in_oai,
    in_openaire,
    in_openalex
    FROM base
)

SELECT * FROM final