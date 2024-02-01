{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        *
    FROM {{ ref('person') }}
    -- ORDER BY orgunit_name, internal_identifier
),

final AS (
    SELECT 
        *
    FROM base
)

SELECT * FROM final