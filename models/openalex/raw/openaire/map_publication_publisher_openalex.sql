with base as (
    SELECT 
    internal_identifier as publication_internal_identifier,
    jsonb_array_elements(publishers)->>'is_oa' as is_oa,
    jsonb_array_elements(publishers)->'source' as publisher
    FROM {{ref('raw_publication_openalex')}}
)

SELECT * from base