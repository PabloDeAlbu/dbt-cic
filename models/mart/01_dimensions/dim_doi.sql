{{ config(materialized='table') }}

WITH 
hub_doi_openalex AS (
    SELECT 
        doi_hk, 
        doi, 
        TRUE AS in_openalex,
        FALSE AS in_openaire,
        FALSE AS in_dspacedb
    FROM {{ref('hub_doi_openalex')}}
),

hub_doi_dspacedb AS (
    SELECT
        doi_hk,
        doi,
        TRUE AS in_dspacedb,
        FALSE AS in_openalex,
        FALSE AS in_openaire
    FROM {{ref('hub_doi_dspacedb')}}
),

base AS (
    SELECT
        COALESCE(openalex.doi, dspacedb.doi) as doi,
        COALESCE(dspacedb.in_dspacedb, openalex.in_dspacedb) as in_dspacedb,
        {# COALESCE(openalex.in_openaire, dspacedb.in_openaire) as in_openaire, #}
        COALESCE(openalex.in_openalex, dspacedb.in_openalex) as in_openalex
    FROM hub_doi_openalex openalex
    FULL OUTER JOIN hub_doi_dspacedb dspacedb ON openalex.doi_hk = dspacedb.doi_hk
    {# FULL OUTER JOIN hub_doi_dspacedb ir ON COALESCE(openalex.doi, ir.doi) = ir.doi #}
),

final AS (
    SELECT
    doi,
    CONCAT('https://doi.org/', doi) as doi_url,
    in_dspacedb,
    {# in_openaire, #}
    in_openalex
    FROM base
)

SELECT * FROM final