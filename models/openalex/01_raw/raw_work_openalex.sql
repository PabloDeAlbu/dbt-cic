{{ config(materialized='table') }}

with base as (
    SELECT
        id,
        REPLACE(type::varchar, '"','') as type,
        language,
        title,
        {{str_to_date('publication_date')}} as publication_date,
        biblio::json->>'issue' as issue,
        biblio::json->>'volume' as volume,
        biblio::json->>'first_page' as first_page,
        biblio::json->>'end_page' as end_page,
        doi,
        ids::json->>'mag' as mag,
        ids::json->>'pmid' as pmid,
        ids::json->>'pmcid' as pmcid,
        is_paratext,
        open_access::json->>'is_oa' as is_oa,
        open_access::json->>'oa_url' as oa_url,
        open_access::json->>'oa_status' as oa_status,
        open_access::json->>'any_repository_has_fulltext' as any_repository_has_fulltext,
        display_name,
        has_fulltext,
        is_retracted,
        type_crossref,
        cited_by_count,
        locations_count,
        is_authors_truncated,
        referenced_works_count,
        cited_by_percentile_year::json->>'max' as cited_by_percentile_year_max,
        cited_by_percentile_year::json->>'max' as cited_by_percentile_year_min,
        countries_distinct_count,
        institutions_distinct_count,
        load_datetime
        --corresponding_author_ids,
        --corresponding_institution_ids,
        --locations,
        --authorships,
        --topics,
        --concepts,
        --grants,
        --apc_list,
        --apc_paid,
        --indexed_in,
        --related_works,
        --referenced_works,
        --sustainable_development_goals,
        --best_oa_location
    FROM 
         {{ source('openalex', 'work') }} works
),

final as (
    select * from base
)

select * from final
