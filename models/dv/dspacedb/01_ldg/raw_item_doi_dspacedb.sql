{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        uuid,
        CONCAT('10.', split_part(text_value, '10.', 2))  as doi
    FROM {{ ref('raw_metadatavalue_dspacedb') }} 
    WHERE 
        short_id = 'dcterms' AND element = 'identifier' AND qualifier = 'other'
        AND text_value like '%10.%'
)

SELECT * FROM base
