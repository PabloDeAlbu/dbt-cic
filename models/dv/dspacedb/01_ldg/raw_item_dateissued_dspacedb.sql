{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        uuid,
        {{str_to_date("text_value")}}  as dateissued
    FROM {{ ref('raw_metadatavalue_dspacedb') }} 
    WHERE 
        short_id = 'dcterms' AND element = 'issued' AND qualifier IS NULL
)

SELECT * FROM base