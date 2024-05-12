with base as (
    SELECT 
    internal_identifier as publication_internal_identifier,
    jsonb_array_elements(subjects)->>'id' as subject_internal_identifier,
    jsonb_array_elements(subjects)->>'display_name' as subject_display_name,
    jsonb_array_elements(subjects)->>'score' as score,
    jsonb_array_elements(subjects)->>'domain' as domain,
    jsonb_array_elements(subjects)->>'subfield' as subfield
    FROM {{ref('raw_publication_openalex')}}
)

SELECT * from base