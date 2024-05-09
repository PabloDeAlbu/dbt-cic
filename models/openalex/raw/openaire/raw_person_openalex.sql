with
base as (
    SELECT
        person_internal_identifier as internal_identifier,
        author_display_name as person_name,
        orcid,
        countries,
        raw_author_name,
        _airbyte_extracted_at
    FROM {{ref('map_publication_person_openalex')}}
)

SELECT * FROM base