{{ config(materialized='view') }}

with base as (
    SELECT     
        id,
        doi,
        ids,
        mesh,
        type,
        title,
        biblio,
        grants,
        topics,
        apc_list,
        apc_paid,
        concepts,
        keywords,
        language,
        locations,
        indexed_in,
        authorships,
        is_paratext,
        open_access,
        display_name,
        has_fulltext,
        is_retracted,
        primary_topic,
        related_works,
        type_crossref,
        cited_by_count,
        locations_count,
        best_oa_location,
        primary_location,
        publication_date,
        publication_year,
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
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta
    FROM 
         {{ source('openalex', 'openalex_works_unlp') }} works
),

final as (
    select * from base
)

select * from final
