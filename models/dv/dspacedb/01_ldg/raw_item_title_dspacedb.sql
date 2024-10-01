{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        uuid,
        text_value as title,
        text_lang as title_lang
        FROM {{ ref('raw_metadatavalue_dspacedb') }} 
        WHERE short_id = 'dc' AND element = 'title' AND qualifier is null
)

SELECT * FROM base