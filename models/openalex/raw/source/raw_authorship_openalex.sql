{{ config(materialized='table') }}

with base as (
    SELECT
        work_id,
        jsonb_array_elements(authorships)->'author'->>'id' as author_id,
        jsonb_array_elements(authorships)->'author' as author,
        jsonb_array_elements(authorships)->'countries' as countries,
        jsonb_array_elements(authorships)->'institutions' as institutions,
        jsonb_array_elements(authorships)->'raw_affiliation_strings' as raw_affiliation_strings,
        jsonb_array_elements(authorships)->'raw_author_name' as raw_author_name,
        _airbyte_extracted_at
    FROM 
         {{ ref('raw_work_openalex') }}
),

final as (
    select * from base
)

select * from final
