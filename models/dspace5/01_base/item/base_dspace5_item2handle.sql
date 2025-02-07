{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        i.item_id,
        text_value as handle
    FROM {{ref('base_dspace5_item2metadatavalue')}} i 
    WHERE 
        i.short_id = 'dc' AND 
        i.element = 'identifier' AND 
        i.qualifier = 'uri' AND
        i.text_value like '%handle%'
)

SELECT * FROM base