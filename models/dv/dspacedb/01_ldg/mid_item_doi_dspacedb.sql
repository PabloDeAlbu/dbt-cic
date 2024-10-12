{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        item_pk,
        CONCAT('10.', split_part(text_value, '10.', 2))  as doi,
        load_datetime
    FROM {{ ref('seed_item_columns_dspacedb')}} i
    INNER JOIN {{ref('mid_item_metadatavalue_dspacedb')}} mv 
        ON i.short_id = mv.short_id 
        AND i.element = mv.element 
        AND i.qualifier = mv.qualifier 
    WHERE i.column = 'doi'
    AND text_value like '%10.%'
)

SELECT * FROM base
