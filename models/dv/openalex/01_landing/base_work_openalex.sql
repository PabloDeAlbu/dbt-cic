{{ config(materialized='table')}}

with source as (
      select * from {{ source('openalex', 'work') }}
),
renamed as (
    select
        {{ adapter.quote("work_id") }},
        {{ adapter.quote("doi") }},
        {{ adapter.quote("title") }},
        {{ adapter.quote("display_name") }},
        {{ adapter.quote("publication_year") }},
        {{ adapter.quote("publication_date") }},
        {{ adapter.quote("language") }},
        {{ adapter.quote("type") }},
        {{ adapter.quote("type_crossref") }},
        {{ adapter.quote("countries_distinct_count") }},
        {{ adapter.quote("institutions_distinct_count") }},
        {{ adapter.quote("fwci") }},
        {{ adapter.quote("has_fulltext") }},
        {{ adapter.quote("fulltext_origin") }},
        {{ adapter.quote("cited_by_count") }},
        {{ adapter.quote("is_retracted") }},
        {{ adapter.quote("is_paratext") }},
        {{ adapter.quote("locations_count") }},
        {{ adapter.quote("referenced_works_count") }},
        {{ adapter.quote("cited_by_api_url") }},
        {{ adapter.quote("updated_date") }},
        {{ adapter.quote("created_date") }},
        {{ adapter.quote("mag") }},
        {{ adapter.quote("pmcid") }},
        {{ adapter.quote("pmid") }},
        {{ adapter.quote("biblio_first_page") }},
        {{ adapter.quote("biblio_issue") }},
        {{ adapter.quote("biblio_last_page") }},
        {{ adapter.quote("biblio_volume") }},
        {{ adapter.quote("any_repository_has_fulltext") }},
        {{ adapter.quote("is_oa") }},
        {{ adapter.quote("oa_status") }},
        {{ adapter.quote("oa_url") }},
        {{ adapter.quote("cited_by_percentile_year_max") }},
        {{ adapter.quote("cited_by_percentile_year_min") }},
        {{ adapter.quote("citation_normalized_percentile_is_in_top_10_percent") }},
        {{ adapter.quote("citation_normalized_percentile_is_in_top_1_percent") }},
        {{ adapter.quote("citation_normalized_percentile_value") }},
        {{ adapter.quote("apc_list_currency") }},
        {{ adapter.quote("apc_list_provenance") }},
        {{ adapter.quote("apc_list_value") }},
        {{ adapter.quote("apc_list_value_usd") }},
        {{ adapter.quote("apc_paid_currency") }},
        {{ adapter.quote("apc_paid_provenance") }},
        {{ adapter.quote("apc_paid_value") }},
        {{ adapter.quote("apc_paid_value_usd") }},
        {{ adapter.quote("indexed_in_arxiv") }},
        {{ adapter.quote("indexed_in_doaj") }},
        {{ adapter.quote("indexed_in_crossref") }},
        {{ adapter.quote("indexed_in_pubmed") }},
        {{ adapter.quote("load_datetime") }}

    from source
)
select * from renamed
  