{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        uuid,
        text_value as type
    FROM {{ ref('raw_metadatavalue_dspacedb') }} 
    WHERE short_id = 'dc' AND element = 'type' AND qualifier is null
)

SELECT * FROM base