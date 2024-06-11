WITH base AS (
    SELECT *
    FROM {{ref('hub_doi')}}
),

final AS (
    SELECT
    doi_hk,
    doi,
    REPLACE(doi, 'https://doi.org/', '') as doi_short,
    in_ir,
    in_openaire,
    in_openalex
    FROM base
)

SELECT * FROM final