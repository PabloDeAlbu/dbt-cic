with
base as (
    SELECT
        institution_internal_identifier as internal_identifier,
        ror as rorid,
        institution_display_name as name,
        institution_type as institution_type,
        institution_lineage,
        institution_country_code,
        raw_affiliation_strings,
        _airbyte_extracted_at
    FROM {{ref('map_publication_person_openalex')}}
)

SELECT * FROM base