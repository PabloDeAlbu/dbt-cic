{{ config(materialized='table')}}

with source as (
      select * from {{ source('openalex', 'work') }}
),

renamed as (
    select
        id as work_id,
        doi,
        title,
        display_name,
        publication_year,
        publication_date,
        language,
        type,
--        type_crossref,
        countries_distinct_count,
        institutions_distinct_count,
        fwci,
        is_authors_truncated,
        has_fulltext,
        fulltext_origin,
        cited_by_count,
        is_retracted,
        is_paratext,
        locations_count,
        referenced_works_count,
        cited_by_api_url,
        any_repository_has_fulltext,
        is_oa,
        oa_status, 
        oa_url,
        updated_date,
        created_date,
        load_datetime
    from source
),

casted as (
    select
        work_id::varchar,
        doi::varchar,
        title::varchar,
        display_name::varchar,
        language::varchar,
        type::varchar,
        cited_by_api_url::varchar,
        fulltext_origin::varchar,
        oa_status::varchar,
        oa_url::varchar,
        {{ dbt_date.convert_timezone("publication_date") }} as publication_date,
        {{ dbt_date.convert_timezone("updated_date") }} as updated_date,
        {{ dbt_date.convert_timezone("created_date") }} as created_date,
        any_repository_has_fulltext::boolean,
        has_fulltext::boolean,
        is_oa::boolean,
        is_retracted::boolean,
        is_paratext::boolean,
        publication_year::int,
        countries_distinct_count::int,
        institutions_distinct_count::int,
        fwci::float,
        cited_by_count::int,
        locations_count::int,
        referenced_works_count::int,
        {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime
    from renamed
),

fillna as (
    select
        work_id,
        COALESCE(doi, 'NO DATA') as doi,
        COALESCE(title, 'NO DATA') as title,
        COALESCE(display_name, 'NO DATA') as display_name,
        COALESCE(language, 'NO DATA') as language,
        COALESCE(type, 'NO DATA') as type,
        COALESCE(fulltext_origin, 'NO DATA') as fulltext_origin,
        COALESCE(oa_status, 'NO DATA') as oa_status,
        COALESCE(oa_url, 'NO DATA') as oa_url,
        COALESCE(cited_by_api_url, 'NO DATA') as cited_by_api_url,
        COALESCE(any_repository_has_fulltext, False) as any_repository_has_fulltext,
        COALESCE(has_fulltext, False) as has_fulltext,
        COALESCE(is_oa, False) as is_oa,
        COALESCE(is_retracted, False) as is_retracted,
        COALESCE(is_paratext, False) as is_paratext,
        COALESCE(countries_distinct_count, 0) as countries_distinct_count,
        COALESCE(institutions_distinct_count, 0) as institutions_distinct_count,
        COALESCE(fwci, 0) as fwci,
        COALESCE(cited_by_count, 0) as cited_by_count,
        COALESCE(locations_count, 0) as locations_count,
        COALESCE(referenced_works_count, 0) as referenced_works_count,
        publication_year,
        publication_date,
        updated_date,
        created_date,
        load_datetime
    from casted
)

select * from fillna