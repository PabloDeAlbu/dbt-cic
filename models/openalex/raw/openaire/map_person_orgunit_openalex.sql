{{ config(materialized='table') }}

with base as (
    SELECT
        person_internal_identifier,
        jsonb_array_elements(person_orgunits)->>'id' as orgunit_internal_identifier,
        jsonb_array_elements(person_orgunits)->>'ror' as rorid,
        jsonb_array_elements(person_orgunits)->>'display_name' as display_name,
        jsonb_array_elements(person_orgunits)->>'country_code' as country_code,
        jsonb_array_elements(person_orgunits)->>'type' as orgunit_type,
        jsonb_array_elements(person_orgunits)->>'lineage' as lineage
    FROM 
        {{ ref('map_publication_person_openalex') }}
),

final as (
    select * from base
    where person_internal_identifier = 'https://openalex.org/A5045119833'
)

select * from final
