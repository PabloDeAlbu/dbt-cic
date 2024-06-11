{{ config(materialized='table') }}

WITH 
hub_doi_openalex AS (
    SELECT 
        doi_hk, 
        doi, 
        TRUE AS in_openalex, 
        FALSE AS in_ir, 
        FALSE AS in_openaire
    FROM stg_openalex.hub_doi_openalex
),

hub_doi_ir AS (
    SELECT 
        doi_hk, 
        doi, 
        FALSE AS in_openalex, 
        TRUE AS in_ir, 
        FALSE AS in_openaire
    FROM stg_ir.hub_doi_ir
),

hub_doi_openaire AS (
    SELECT 
        doi_hk, 
        doi, 
        FALSE AS in_openalex, 
        FALSE AS in_ir, 
        TRUE AS in_openaire
    FROM stg_openaire.hub_doi_openaire
),

final AS (
    SELECT 
        COALESCE(oa.doi_hk, ir.doi_hk, op.doi_hk) AS doi_hk, 
        COALESCE(oa.doi, ir.doi, op.doi) AS doi, 
        COALESCE(oa.in_openalex, FALSE) AS in_openalex, 
        COALESCE(ir.in_ir, FALSE) AS in_ir,
        COALESCE(op.in_openaire, FALSE) AS in_openaire
    FROM hub_doi_openalex oa
    FULL OUTER JOIN hub_doi_ir ir ON oa.doi = ir.doi
    FULL OUTER JOIN hub_doi_openaire op ON COALESCE(oa.doi, ir.doi) = op.doi
)

SELECT * FROM final
