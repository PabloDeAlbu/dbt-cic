{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        mv.uuid,
        {{str_to_date("text_value")}}  as dateissued,
        load_datetime
    FROM {{ref('mid_item_metadatavalue_dspacedb')}} mv 
    WHERE 
        mv.short_id = 'dcterms' AND 
        mv.element = 'issued' AND 
        qualifier IS NULL
)

SELECT * FROM base