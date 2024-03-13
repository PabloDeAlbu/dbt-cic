{{ config(materialized = "table") }}

WITH base AS (
    SELECT DISTINCT
        person_name, 
        person_internal_identifier
    FROM {{ ref('map_publication_person') }}
    ORDER BY person_name
),

final AS (
    SELECT 
        *
    FROM base
)

SELECT * FROM final