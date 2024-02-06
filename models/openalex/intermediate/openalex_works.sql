with base as (
    SELECT 
    result_element->>'id' as id,
    result_element->>'ids' as ids,
    result_element->>'abstract_inverted_index' as abstract_inverted_index,
    result_element->>'authorships' as authorships,
    result_element->>'apc_list' as apc_list,
    result_element->>'apc_paid' as apc_paid,
    result_element->>'best_oa_location' as best_oa_location,
    result_element->>'biblio' as biblio,
    result_element->>'cited_by_api_url' as cited_by_api_url,
    result_element->>'cited_by_count' as cited_by_count,
    result_element->>'concepts' as concepts,
    result_element->>'corresponding_author_ids' as corresponding_author_ids,
    result_element->>'corresponding_institution_ids' as corresponding_institution_ids,
    result_element->>'countries_distinct_count' as countries_distinct_count,
    result_element->>'counts_by_year' as counts_by_year,
    result_element->>'created_date' as created_date,
    result_element->>'display_name' as display_name,
    result_element->>'doi' as doi,
    result_element->>'fulltext_origin' as fulltext_origin,
    result_element->>'grants' as grants,
    result_element->>'has_fulltext' as has_fulltext,
    result_element->>'indexed_in' as indexed_in,
    result_element->>'institutions_distinct_count' as institutions_distinct_count,
    result_element->>'is_paratext' as is_paratext,
    result_element->>'is_retracted' as is_retracted,
    result_element->>'keywords' as keywords,
    result_element->>'language' as language,
    result_element->>'license' as license,
    result_element->>'locations' as locations,
    result_element->>'locations_count' as locations_count,
    result_element->>'mesh' as mesh,
    result_element->>'ngrams_url' as ngrams_url,
    result_element->>'open_access' as open_access,
    result_element->>'primary_location' as primary_location,
    result_element->>'publication_date' as publication_date,
    result_element->>'publication_year' as publication_year,
    result_element->>'referenced_works' as referenced_works,
    result_element->>'related_works' as related_works,
    result_element->>'sustainable_development_goals' as sustainable_development_goals,
    result_element->>'title' as title,
    result_element->>'type' as type,
    result_element->>'type_crossref' as type_crossref,
    result_element->>'updated_date' as updated_date       
    FROM 
        {{ source('openalex', '_airbyte_raw_works_2023') }} works,
        LATERAL jsonb_array_elements(_airbyte_data->'results') AS result_element
),

final as (
    select * from base
)

select * from final
