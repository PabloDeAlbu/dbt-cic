WITH base AS (
    SELECT *
    FROM {{ref('hub_doi')}}
),

final AS (
    SELECT
    doi_hk,
    doi,
    CONCAT('https://doi.org/', doi) as doi_url,
    in_ir,
    in_openaire,
    in_openalex
    FROM base
)

SELECT * FROM final