WITH base as (
    SELECT
        hub_language_openalex.language_hk,
        hub_language_openalex.language
    FROM {{ ref('hub_language_openalex') }}
)

SELECT * FROM base