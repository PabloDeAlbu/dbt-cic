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

hub_doi_openaire AS (
    SELECT
        doi_hk,
        doi,
        FALSE AS in_dspacedb,
        FALSE AS in_openalex,
        TRUE AS in_openaire
    FROM {{ref('hub_doi_openaire')}}
),

base AS (
    SELECT
        dspacedb.doi_hk,
        dspacedb.doi,
        dspacedb.in_dspacedb
    FROM hub_doi_dspacedb dspacedb
),

add_openalex AS (
    SELECT
        COALESCE(base.doi_hk, openalex.doi_hk) as doi_hk,
        COALESCE(base.doi, openalex.doi) as doi,
        COALESCE(base.in_dspacedb, False) as in_dspacedb,
        openalex.in_openalex
    FROM base base
    FULL OUTER JOIN hub_doi_openalex openalex ON openalex.doi_hk = base.doi_hk
),

add_openaire AS (
    SELECT
        COALESCE(add_openalex.doi_hk, openaire.doi_hk) as doi_hk,
        COALESCE(add_openalex.doi, openaire.doi) as doi,
        COALESCE(add_openalex.in_dspacedb, False) as in_dspacedb,
        COALESCE(add_openalex.in_openalex, False) as in_openalex,
        COALESCE(openaire.in_openaire, False) as in_openaire
    FROM add_openalex
    FULL OUTER JOIN hub_doi_openaire openaire ON openaire.doi_hk = add_openalex.doi_hk
),

final AS (
    SELECT
    doi,
    CONCAT('https://doi.org/', doi) as doi_url,
    in_dspacedb,
    in_openaire,
    in_openalex
    FROM add_openaire
)

SELECT * FROM final