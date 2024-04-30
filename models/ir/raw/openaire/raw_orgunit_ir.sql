{{ config(materialized = "table") }}

WITH base AS (
    SELECT DISTINCT orgunit_name, orgunit_internal_identifier, available_date, publication_date
    FROM {{ ref('map_publication_orgunit') }}
    ORDER BY orgunit_name
),

final AS (
    SELECT 
        *
    FROM base
)

SELECT * FROM final