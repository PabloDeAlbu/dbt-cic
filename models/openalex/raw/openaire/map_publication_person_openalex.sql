{{ config(materialized='table') }}

with base as (
    SELECT
        internal_identifier as publication_internal_identifier,
        jsonb_array_elements(authors)->'author'->>'id' as person_internal_identifier,
        jsonb_array_elements(authors)->'author'->>'orcid' as orcid,
        jsonb_array_elements(authors)->'author'->>'display_name' as author_display_name,
        jsonb_array_elements(authors)->'countries' as countries,
        jsonb_array_elements(jsonb_array_elements(authors)->'institutions')->>'id' as institution_internal_identifier,
        jsonb_array_elements(jsonb_array_elements(authors)->'institutions')->>'ror' as ror,
        jsonb_array_elements(jsonb_array_elements(authors)->'institutions')->>'type' as institution_type,
        jsonb_array_elements(jsonb_array_elements(authors)->'institutions')->>'lineage' as institution_lineage,
        jsonb_array_elements(jsonb_array_elements(authors)->'institutions')->>'country_code' as institution_country_code,
        jsonb_array_elements(jsonb_array_elements(authors)->'institutions')->>'display_name' as institution_display_name,
        jsonb_array_elements(jsonb_array_elements(authors)->'raw_affiliation_strings') as raw_affiliation_strings,
        jsonb_array_elements(authors)->'raw_author_name' as raw_author_name,
        _airbyte_extracted_at
    FROM 
         {{ ref('raw_publication_openalex') }}
),

final as (
    select * from base
)

select * from final
