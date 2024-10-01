{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        uuid,
        text_value as handle
    FROM {{ ref('raw_metadatavalue_dspacedb') }} 
    WHERE short_id = 'dc' AND element = 'identifier' AND qualifier = 'uri'
)

SELECT * FROM base