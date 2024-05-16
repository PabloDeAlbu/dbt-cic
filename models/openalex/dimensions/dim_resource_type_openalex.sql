WITH base as (
    SELECT * 
    FROM {{ ref('hub_type_openalex') }}
)

SELECT * FROM base