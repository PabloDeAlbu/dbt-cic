{{ config(materialized='table') }}

with base as (
    SELECT
        id,
        type,
        language,
        title,
        locations,
        {{str_to_date('publication_date')}} as publication_date,
        biblio->>'issue' as issue,
        biblio->>'volume' as volume,
        biblio->>'first_page' as first_page,
        biblio->>'end_page' as end_page,
        doi,
        ids->>'mag' as mag,
        ids->>'pmid' as pmid,
        ids->>'pmcid' as pmcid,
        authorships,
        topics,
        concepts,
        grants,
        apc_list,
        apc_paid,
        indexed_in,
        is_paratext,
        open_access,
        display_name,
        has_fulltext,
        is_retracted,
        related_works,
        type_crossref,
        cited_by_count,
        locations_count,
        referenced_works,
        _ab_source_file_url,
        is_authors_truncated,
        referenced_works_count,
        cited_by_percentile_year,
        corresponding_author_ids,
        countries_distinct_count,
        institutions_distinct_count,
        _ab_source_file_last_modified,
        corresponding_institution_ids,
        sustainable_development_goals,
        best_oa_location,
        _airbyte_extracted_at
    FROM 
         {{ source('openalex', 'openalex_works_unlp') }} works
),

final as (
    select * from base
)

select * from final
