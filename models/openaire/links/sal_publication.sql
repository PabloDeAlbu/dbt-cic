with ir as (
    SELECT
    internal_identifier as sedici_internal_identifier,
    --CONCAT('https://doi.org/', doi) as doi,
    doi,
    handle
    FROM {{ref('sal_publication_ir')}}
),

openalex as (
    SELECT
    internal_identifier as openalex_internal_identifier,
    doi,
    mag,
    pmid,
    pmcid
    FROM {{ref('sal_publication_openalex')}}
),

final as (
    SELECT 
    sedici_internal_identifier,
    openalex_internal_identifier,
    handle,
    openalex.doi,
    mag,
    pmid,
    pmcid
    FROM ir
    INNER JOIN openalex ON ir.doi = openalex.doi
    --where openalex_internal_identifier is not null
)

SELECT * FROM final