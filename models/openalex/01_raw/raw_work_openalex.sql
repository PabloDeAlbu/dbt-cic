{{ config(materialized='table') }}

with base as (
    SELECT
        id,
        REPLACE(type::varchar, '"','') as type,
        language,
        title,
        {{str_to_date('publication_date')}} as publication_date,
        biblio->>'issue' as issue,
        biblio->>'volume' as volume,
        biblio->>'first_page' as first_page,
        biblio->>'end_page' as end_page,
        doi,
        ids->>'mag' as mag,
        ids->>'pmid' as pmid,
        ids->>'pmcid' as pmcid,
        is_paratext,
        open_access->>'is_oa' as is_oa,
        open_access->>'oa_url' as oa_url,
        open_access->>'oa_status' as oa_status,
        open_access->>'any_repository_has_fulltext' as any_repository_has_fulltext,
        display_name,
        has_fulltext,
        is_retracted,
        type_crossref,
        cited_by_count,
        locations_count,
        _ab_source_file_url,
        is_authors_truncated,
        referenced_works_count,
        cited_by_percentile_year->>'max' as cited_by_percentile_year_max,
        cited_by_percentile_year->>'max' as cited_by_percentile_year_min,
        countries_distinct_count,
        institutions_distinct_count,
        _ab_source_file_last_modified,
        corresponding_author_ids,
        corresponding_institution_ids,
        locations,
        authorships,
        topics,
        concepts,
        grants,
        apc_list,
        apc_paid,
        indexed_in,
        related_works,
        referenced_works,
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
