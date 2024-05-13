{{ config(materialized='table') }}

with base as (
    SELECT
        internal_identifier as publication_internal_identifier,
        jsonb_array_elements(authors)->'author'->>'id' as person_internal_identifier,
        jsonb_array_elements(authors)->'author'->>'orcid' as orcid,
        jsonb_array_elements(authors)->'author'->>'display_name' as author_display_name,
        jsonb_array_elements(authors)->'countries' as countries,
        _airbyte_extracted_at
    FROM 
         {{ ref('raw_publication_openalex') }}
),

final as (
    select * from base
)

select * from final
