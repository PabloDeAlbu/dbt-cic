-- TODO mapear keywords de OpenAlex con keywords de OpenAire
-- en vez de usar Topics. Despues seguir con raw_keyword_openalex 
with base as (
    SELECT 
    internal_identifier as publication_internal_identifier,
    jsonb_array_elements(keywords)->>'id' as keyword_internal_identifier,
    jsonb_array_elements(keywords)->>'display_name' as keywords_display_name,
    jsonb_array_elements(keywords),
    _airbyte_extracted_at
    FROM {{ref('raw_publication_openalex')}}
)

SELECT * from base