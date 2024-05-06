{{ config(materialized='view') }}

with base as (
    SELECT 
        internal_identifier,
        type,
        language,
        title,
        publication_date,
        volume,
        issue,
        start_page,
        end_page,
        doi,
        pmcid,
        authors,
        publishers,
        subject,
        keyword,
        mag,
        pmid,
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
         {{ ref('map_publication_work_openalex') }}
),

final as (
    select * from base
)

select * from final
