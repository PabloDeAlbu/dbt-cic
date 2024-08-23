
WITH base AS (
    SELECT
        resulttype_hk,
        resulttype
    FROM {{ref('hub_resulttype_openaire')}} hub_resourcetype
)

SELECT * FROM base
