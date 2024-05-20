{{ config(materialized='table') }}

WITH base AS (
    SELECT
        id as work_id,
        jsonb_array_elements(authorships)->'author'->>'id' as author_id,
        jsonb_array_elements(authorships)->'author'->>'orcid' as orcid,
        jsonb_array_elements(authorships)->'author'->>'display_name' as display_name,
        jsonb_array_elements(authorships)->>'author_position' as author_position,
        jsonb_array_elements(jsonb_array_elements(authorships)->'countries') as author_country,
        jsonb_array_elements(jsonb_array_elements(authorships)->'institutions')->>'id' as institution_id,
        jsonb_array_elements(jsonb_array_elements(authorships)->'institutions')->>'display_name' as institution_display_name,
        jsonb_array_elements(jsonb_array_elements(authorships)->'institutions')->>'ror' as ror,
        jsonb_array_elements(jsonb_array_elements(authorships)->'institutions')->>'country_code' as institution_country_code,
        jsonb_array_elements(jsonb_array_elements(authorships)->'institutions')->>'type' as institution_type,
        jsonb_array_elements(jsonb_array_elements(authorships)->'institutions')->>'lineage' as lineage

    FROM 
         {{ source('openalex', 'openalex_works_unlp') }} works
),

final as (
    SELECT * FROM base
)

SELECT * FROM final
