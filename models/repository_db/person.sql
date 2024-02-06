{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        person_name, 
        person_internal_identifier as internal_identifier
    FROM {{ ref('map_publication_person') }}
    ORDER BY person_name, internal_identifier
),

final AS (
    SELECT 
        *
    FROM base
)

SELECT * FROM final