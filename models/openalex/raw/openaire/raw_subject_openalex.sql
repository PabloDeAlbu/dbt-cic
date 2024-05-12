with base as (
    SELECT
    subject_internal_identifier as internal_identifier,
    subject_display_name as display_name,
    domain,
    subfield
    FROM {{ref('map_publication_subject_openalex')}}
)

SELECT * FROM base