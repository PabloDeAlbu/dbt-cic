with source as (
        select * from {{ source('openalex', 'work') }}
),
renamed as (
  select
    {{ adapter.quote("id") }} as work_id,
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
    {{ adapter.quote("doi") }},
    {{ adapter.quote("mag") }},
    {{ adapter.quote("openalex") }},
    {{ adapter.quote("pmcid") }},
    {{ adapter.quote("pmid") }},
    {{ adapter.quote("primary_location.is_accepted") }} as primary_location_is_accepted,
    {{ adapter.quote("primary_location.is_oa") }} as primary_location_is_oa,
    {{ adapter.quote("primary_location.is_published") }} as primary_location_is_published,
    {{ adapter.quote("primary_location.landing_page_url") }} as primary_location_landing_page_url,
    {{ adapter.quote("primary_location.license") }} as primary_location_license,
    {{ adapter.quote("primary_location.license_id") }} as primary_location_license_id,
    {{ adapter.quote("primary_location.pdf_url") }} as primary_location_pdf_url,
    {{ adapter.quote("primary_location.version") }} as primary_location_version,
    {{ adapter.quote("primary_location.source") }} as primary_location_source,
    {{ adapter.quote("primary_location.source.id") }} as primary_location_source_id,
    {{ adapter.quote("primary_location.source.type") }} as primary_location_source_type,
    {{ adapter.quote("primary_location.source.display_name") }} as primary_location_source_display_name,
    {{ adapter.quote("primary_location.source.host_organization") }} as primary_location_source_host_organization,
    {{ adapter.quote("primary_location.source.host_organization_name") }} as primary_location_source_host_organization_name,
    {{ adapter.quote("primary_location.source.is_core") }} as primary_location_source_is_core,
    {{ adapter.quote("primary_location.source.is_in_doaj") }} as primary_location_source_is_in_doaj,
    {{ adapter.quote("primary_location.source.is_indexed_in_scopus") }} as primary_location_source_is_indexed_in_scopus,
    {{ adapter.quote("primary_location.source.is_oa") }} as primary_location_source_is_oa,
    {{ adapter.quote("primary_location.source.issn_l") }} as primary_location_source_issn_l,
    {{ adapter.quote("any_repository_has_fulltext") }},
    {{ adapter.quote("is_oa") }},
    {{ adapter.quote("oa_status") }},
    {{ adapter.quote("oa_url") }},
    {{ adapter.quote("apc_list.currency") }} as apc_list_currency,
    {{ adapter.quote("apc_list.provenance") }} as apc_list_provenance,
    {{ adapter.quote("apc_list.value") }} as apc_list_value,
    {{ adapter.quote("apc_list.value_usd") }} as apc_list_value_usd,
    {{ adapter.quote("apc_paid.currency") }} as apc_paid_currency,
    {{ adapter.quote("apc_paid.provenance") }} as apc_paid_provenance,
    {{ adapter.quote("apc_paid.value") }} as apc_paid_value,
    {{ adapter.quote("apc_paid.value_usd") }} as apc_paid_value_usd,
    {{ adapter.quote("citation_normalized_percentile.is_in_top_10_percent") }} as citation_normalized_percentile_is_in_top_10_percent,
    {{ adapter.quote("citation_normalized_percentile.is_in_top_1_percent") }} as citation_normalized_percentile_is_in_top_1_percent,
    {{ adapter.quote("citation_normalized_percentile.value") }} as citation_normalized_percentile_value,
    {{ adapter.quote("cited_by_percentile_year.max") }} as cited_by_percentile_year_max,
    {{ adapter.quote("cited_by_percentile_year.min") }} as cited_by_percentile_year_min,
    {{ adapter.quote("biblio.first_page") }} as biblio_first_page,
    {{ adapter.quote("biblio.issue") }} as biblio_issue,
    {{ adapter.quote("biblio.last_page") }} as biblio_last_page,
    {{ adapter.quote("biblio.volume") }} as biblio_volume,
    {{ adapter.quote("primary_topic.display_name") }} as primary_topic_display_name,
    {{ adapter.quote("primary_topic.id") }} as primary_topic_id,
    {{ adapter.quote("primary_topic.score") }} as primary_topic_score,
    {{ adapter.quote("primary_topic.domain.display_name") }} as primary_topic_domain_display_name,
    {{ adapter.quote("primary_topic.domain.id") }} as primary_topic_domain_id,
    {{ adapter.quote("primary_topic.field.display_name") }} as primary_topic_field_display_name,
    {{ adapter.quote("primary_topic.field.id") }} as primary_topic_field_id,
    {{ adapter.quote("primary_topic.subfield.display_name") }} as primary_topic_subfield_display_name,
    {{ adapter.quote("primary_topic.subfield.id") }} as primary_topic_subfield_id,
    {{ adapter.quote("best_oa_location.is_accepted") }} as best_oa_location_is_accepted,
    {{ adapter.quote("best_oa_location.is_oa") }} as best_oa_location_is_oa,
    {{ adapter.quote("best_oa_location.is_published") }} as best_oa_location_is_published,
    {{ adapter.quote("best_oa_location.landing_page_url") }} as best_oa_location_landing_page_url,
    {{ adapter.quote("best_oa_location.license") }} as best_oa_location_license,
    {{ adapter.quote("best_oa_location.license_id") }} as best_oa_location_license_id,
    {{ adapter.quote("best_oa_location.pdf_url") }} as best_oa_location_pdf_url,
    {{ adapter.quote("best_oa_location.version") }} as best_oa_location_version,
    {{ adapter.quote("best_oa_location.source") }} as best_oa_location_source,
    {{ adapter.quote("best_oa_location.source.id") }} as best_oa_location_source_id,
    {{ adapter.quote("best_oa_location.source.display_name") }} as best_oa_location_source_display_name,
    {{ adapter.quote("best_oa_location.source.host_organization") }} as best_oa_location_source_host_organization,
    {{ adapter.quote("best_oa_location.source.host_organization_name") }} as best_oa_location_source_host_organization_name,
    {{ adapter.quote("best_oa_location.source.is_core") }} as best_oa_location_source_is_core,
    {{ adapter.quote("best_oa_location.source.is_in_doaj") }} as best_oa_location_source_is_in_doaj,
    {{ adapter.quote("best_oa_location.source.is_indexed_in_scopus") }} as best_oa_location_source_is_indexed_in_scopus,
    {{ adapter.quote("best_oa_location.source.is_oa") }} as best_oa_location_source_is_oa,
    {{ adapter.quote("best_oa_location.source.issn_l") }} as best_oa_location_source_issn_l,
    {{ adapter.quote("best_oa_location.source.type") }} as best_oa_location_source_type,
    {{ adapter.quote("load_datetime") }}
  from source
),

casted as (
  select
    -- work
    ---- varchar
    work_id::varchar,
    title::varchar,
    display_name::varchar,
    language::varchar,
    type::varchar,
    type_crossref::varchar,
    fulltext_origin::varchar,
    cited_by_api_url::varchar,
    doi::varchar,
    mag::varchar,
    openalex::varchar,
    pmcid::varchar,
    pmid::varchar,
    ---- bool
    has_fulltext::boolean,
    is_retracted::boolean,
    is_paratext::boolean,
    ---- int
    institutions_distinct_count::int,
    fwci::int,
    cited_by_count::int,
    locations_count::int,
    referenced_works_count::int,
    countries_distinct_count::int,
    publication_year::int,
    ---- date
    {{ dbt_date.convert_timezone("publication_date") }} as publication_date,
    {{ dbt_date.convert_timezone("updated_date") }} as updated_date,
    {{ dbt_date.convert_timezone("created_date") }} as created_date,
    {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime,

    -- openaeccess
    ---- varchar
    oa_status::varchar,
    oa_url::varchar,
    ---- bool
    any_repository_has_fulltext::boolean,
    is_oa::boolean,
    ---- int
    ---- date

    -- apc_list
    ---- varchar
    apc_list_currency::varchar,
    apc_list_provenance::varchar,
    ---- bool
    ---- int
    apc_list_value::int,
    apc_list_value_usd::int,
    ---- date

    -- apc_paid
    ---- varchar
    apc_paid_currency::varchar,
    apc_paid_provenance::varchar,
    ---- bool
    ---- int
    apc_paid_value::int,
    apc_paid_value_usd::int,
    ---- date

    -- citation_normalized_percentile
    ---- varchar
    ---- bool
    citation_normalized_percentile_is_in_top_10_percent::boolean,
    citation_normalized_percentile_is_in_top_1_percent::boolean,
    ---- int
    citation_normalized_percentile_value::int,
    cited_by_percentile_year_max::int,
    cited_by_percentile_year_min::int,
    ---- date

    -- biblio
    ---- varchar
    biblio_first_page::varchar,
    biblio_issue::varchar,
    biblio_last_page::varchar,
    biblio_volume::varchar,
    ---- bool
    ---- int
    ---- date

    -- Location object. https://docs.openalex.org/api-entities/works/work-object/location-object

    -- primary location
    ---- varchar
    primary_location_source::varchar,
    primary_location_source_id::varchar,
    primary_location_source_type::varchar,
    primary_location_source_display_name::varchar,
    primary_location_source_host_organization::varchar,
    primary_location_source_host_organization_name::varchar,
    primary_location_landing_page_url::varchar,
    primary_location_license::varchar,
    primary_location_license_id::varchar,
    primary_location_pdf_url::varchar,
    primary_location_version::varchar,
    primary_location_source_issn_l::varchar,
    ---- bool
    primary_location_is_accepted::boolean,
    primary_location_is_oa::boolean,
    primary_location_is_published::boolean,
    primary_location_source_is_core::boolean,
    primary_location_source_is_in_doaj::boolean,
    primary_location_source_is_indexed_in_scopus::boolean,
    primary_location_source_is_oa::boolean,
    ---- int
    ---- date

    -- best_oa_location
    ---- varchar
    best_oa_location_source::varchar,
    best_oa_location_source_id::varchar,
    best_oa_location_source_display_name::varchar,
    best_oa_location_source_type::varchar,
    best_oa_location_source_host_organization::varchar,
    best_oa_location_source_host_organization_name::varchar,
    best_oa_location_landing_page_url::varchar,
    best_oa_location_license::varchar,
    best_oa_location_license_id::varchar,
    best_oa_location_pdf_url::varchar,
    best_oa_location_version::varchar,
    best_oa_location_source_issn_l::varchar,
    ---- bool
    best_oa_location_is_accepted::boolean,
    best_oa_location_is_oa::boolean,
    best_oa_location_is_published::boolean,
    best_oa_location_source_is_core::boolean,
    best_oa_location_source_is_in_doaj::boolean,
    best_oa_location_source_is_indexed_in_scopus::boolean,
    best_oa_location_source_is_oa::boolean,

    -- primary_topic
    ---- varchar
    primary_topic_display_name::varchar,
    primary_topic_id::varchar,
    primary_topic_domain_display_name::varchar,
    primary_topic_domain_id::varchar,
    primary_topic_field_display_name::varchar,
    primary_topic_field_id::varchar,
    primary_topic_subfield_display_name::varchar,
    primary_topic_subfield_id::varchar,
    ---- bool
    ---- int
    primary_topic_score::int
    ---- date


  from renamed
),

fillna as (
  select
    -- work
    ---- varchar
    COALESCE(work_id, 'NO DATA') as work_id,
    COALESCE(title, 'NO DATA') as title,
    COALESCE(display_name, 'NO DATA') as display_name,
    COALESCE(language, 'NO DATA') as language,
    COALESCE(type, 'NO DATA') as type,
    COALESCE(type_crossref, 'NO DATA') as type_crossref,
    COALESCE(fulltext_origin, 'NO DATA') as fulltext_origin,
    COALESCE(cited_by_api_url, 'NO DATA') as cited_by_api_url,
    COALESCE(doi, 'NO DATA') as doi,
    COALESCE(mag, 'NO DATA') as mag,
    COALESCE(openalex, 'NO DATA') as openalex,
    COALESCE(pmcid, 'NO DATA') as pmcid,
    COALESCE(pmid, 'NO DATA') as pmid,
    ---- bool
    COALESCE(has_fulltext, FALSE) as has_fulltext,
    COALESCE(is_retracted, FALSE) as is_retracted,
    COALESCE(is_paratext, FALSE) as is_paratext,
    ---- int
    COALESCE(institutions_distinct_count, 0) as institutions_distinct_count,
    COALESCE(fwci, 0) as fwci,
    COALESCE(cited_by_count, 0) as cited_by_count,
    COALESCE(locations_count, 0) as locations_count,
    COALESCE(referenced_works_count, 0) as referenced_works_count,
    COALESCE(countries_distinct_count, 0) as countries_distinct_count,
    COALESCE(publication_year, 0) as publication_year,
    ---- date
    publication_date,
    updated_date,
    created_date,

    -- openaeccess
    ---- varchar
    COALESCE(oa_status, 'NO DATA') as oa_status,
    COALESCE(oa_url, 'NO DATA') as oa_url,
    ---- bool
    COALESCE(any_repository_has_fulltext, FALSE) as any_repository_has_fulltext,
    COALESCE(is_oa, FALSE) as is_oa,
    ---- int
    ---- date

    -- primary location
    ---- varchar
    COALESCE(primary_location_source, 'NO DATA') as primary_location_source,
    COALESCE(primary_location_source_id, 'NO DATA') as primary_location_source_id,
    COALESCE(primary_location_source_type, 'NO DATA') as primary_location_source_type,
    COALESCE(primary_location_source_display_name, 'NO DATA') as primary_location_source_display_name,
    COALESCE(primary_location_source_host_organization, 'NO DATA') as primary_location_source_host_organization,
    COALESCE(primary_location_source_host_organization_name, 'NO DATA') as primary_location_source_host_organization_name,
    COALESCE(primary_location_landing_page_url, 'NO DATA') as primary_location_landing_page_url,
    COALESCE(primary_location_license, 'NO DATA') as primary_location_license,
    COALESCE(primary_location_license_id, 'NO DATA') as primary_location_license_id,
    COALESCE(primary_location_pdf_url, 'NO DATA') as primary_location_pdf_url,
    COALESCE(primary_location_version, 'NO DATA') as primary_location_version,
    COALESCE(primary_location_source_issn_l, 'NO DATA') as primary_location_source_issn_l,
    ---- bool
    COALESCE(primary_location_is_accepted, FALSE) as primary_location_is_accepted,
    COALESCE(primary_location_is_oa, FALSE) as primary_location_is_oa,
    COALESCE(primary_location_is_published, FALSE) as primary_location_is_published,
    COALESCE(primary_location_source_is_core, FALSE) as primary_location_source_is_core,
    COALESCE(primary_location_source_is_in_doaj, FALSE) as primary_location_source_is_in_doaj,
    COALESCE(primary_location_source_is_indexed_in_scopus, FALSE) as primary_location_source_is_indexed_in_scopus,
    COALESCE(primary_location_source_is_oa, FALSE) as primary_location_source_is_oa,
    ---- int
    ---- date

    -- apc_list
    ---- varchar
    COALESCE(apc_list_currency, 'NO DATA') as apc_list_currency,
    COALESCE(apc_list_provenance, 'NO DATA') as apc_list_provenance,
    ---- bool
    ---- int
    COALESCE(apc_list_value, 0) as apc_list_value,
    COALESCE(apc_list_value_usd, 0) as apc_list_value_usd,
    ---- date

    -- apc_paid
    ---- varchar
    COALESCE(apc_paid_currency, 'NO DATA') as apc_paid_currency,
    COALESCE(apc_paid_provenance, 'NO DATA') as apc_paid_provenance,
    ---- bool
    ---- int
    COALESCE(apc_paid_value, 0) as apc_paid_value,
    COALESCE(apc_paid_value_usd, 0) as apc_paid_value_usd,
    ---- date

    -- citation_normalized_percentile
    ---- varchar
    ---- bool
    COALESCE(citation_normalized_percentile_is_in_top_10_percent, FALSE) as citation_normalized_percentile_is_in_top_10_percent,
    COALESCE(citation_normalized_percentile_is_in_top_1_percent, FALSE) as citation_normalized_percentile_is_in_top_1_percent,
    ---- int
    COALESCE(citation_normalized_percentile_value, 0) as citation_normalized_percentile_value,
    COALESCE(cited_by_percentile_year_max, 0) as cited_by_percentile_year_max,
    COALESCE(cited_by_percentile_year_min, 0) as cited_by_percentile_year_min,
    ---- date

    -- biblio
    ---- varchar
    COALESCE(biblio_first_page, 'NO DATA') as biblio_first_page,
    COALESCE(biblio_issue, 'NO DATA') as biblio_issue,
    COALESCE(biblio_last_page, 'NO DATA') as biblio_last_page,
    COALESCE(biblio_volume, 'NO DATA') as biblio_volume,
    ---- bool
    ---- int
    ---- date

    -- primary_topic
    ---- varchar
    COALESCE(primary_topic_display_name, 'NO DATA') as primary_topic_display_name,
    COALESCE(primary_topic_id, 'NO DATA') as primary_topic_id,
    COALESCE(primary_topic_domain_display_name, 'NO DATA') as primary_topic_domain_display_name,
    COALESCE(primary_topic_domain_id, 'NO DATA') as primary_topic_domain_id,
    COALESCE(primary_topic_field_display_name, 'NO DATA') as primary_topic_field_display_name,
    COALESCE(primary_topic_field_id, 'NO DATA') as primary_topic_field_id,
    COALESCE(primary_topic_subfield_display_name, 'NO DATA') as primary_topic_subfield_display_name,
    COALESCE(primary_topic_subfield_id, 'NO DATA') as primary_topic_subfield_id,
    ---- bool
    ---- int
    COALESCE(primary_topic_score, 0) as primary_topic_score,
    ---- date

    -- best_oa_location
    ---- varchar
    COALESCE(best_oa_location_source, 'NO DATA') as best_oa_location_source,
    COALESCE(best_oa_location_source_id, 'NO DATA') as best_oa_location_source_id,
    COALESCE(best_oa_location_source_display_name, 'NO DATA') as best_oa_location_source_display_name,
    COALESCE(best_oa_location_source_type, 'NO DATA') as best_oa_location_source_type,
    COALESCE(best_oa_location_source_host_organization, 'NO DATA') as best_oa_location_source_host_organization,
    COALESCE(best_oa_location_source_host_organization_name, 'NO DATA') as best_oa_location_source_host_organization_name,
    COALESCE(best_oa_location_landing_page_url, 'NO DATA') as best_oa_location_landing_page_url,
    COALESCE(best_oa_location_license, 'NO DATA') as best_oa_location_license,
    COALESCE(best_oa_location_license_id, 'NO DATA') as best_oa_location_license_id,
    COALESCE(best_oa_location_pdf_url, 'NO DATA') as best_oa_location_pdf_url,
    COALESCE(best_oa_location_version, 'NO DATA') as best_oa_location_version,
    COALESCE(best_oa_location_source_issn_l, 'NO DATA') as best_oa_location_source_issn_l,
    ---- bool
    COALESCE(best_oa_location_is_accepted, FALSE) as best_oa_location_is_accepted,
    COALESCE(best_oa_location_is_oa, FALSE) as best_oa_location_is_oa,
    COALESCE(best_oa_location_is_published, FALSE) as best_oa_location_is_published,
    COALESCE(best_oa_location_source_is_core, FALSE) as best_oa_location_source_is_core,
    COALESCE(best_oa_location_source_is_in_doaj, FALSE) as best_oa_location_source_is_in_doaj,
    COALESCE(best_oa_location_source_is_indexed_in_scopus, FALSE) as best_oa_location_source_is_indexed_in_scopus,
    COALESCE(best_oa_location_source_is_oa, FALSE) as best_oa_location_source_is_oa,
    ---- int
    ---- date
    {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime

  from casted
),

transformed as (
  select 
  
    work_id,
    title,
    display_name,
    language,
    type,
    type_crossref,
    fulltext_origin,
    cited_by_api_url,
    split_part(doi, 'https://doi.org/', 2) as doi,
    mag,
    openalex,
    pmcid,
    pmid,
    ---- bool
    has_fulltext,
    is_retracted,
    is_paratext,
    ---- int
    institutions_distinct_count,
    fwci,
    cited_by_count,
    locations_count,
    referenced_works_count,
    countries_distinct_count,
    publication_year,
    ---- date
    publication_date,
    updated_date,
    created_date,

    -- openaeccess
    ---- varchar
    oa_status,
    oa_url,
    ---- bool
    any_repository_has_fulltext,
    is_oa,
    ---- int
    ---- date

    -- primary location
    ---- varchar
    primary_location_source,
    primary_location_source_id,
    primary_location_source_type,
    primary_location_source_display_name,
    primary_location_source_host_organization,
    primary_location_source_host_organization_name,
    primary_location_landing_page_url,
    primary_location_license,
    primary_location_license_id,
    primary_location_pdf_url,
    primary_location_version,
    primary_location_source_issn_l,
    ---- bool
    primary_location_is_accepted,
    primary_location_is_oa,
    primary_location_is_published,
    primary_location_source_is_core,
    primary_location_source_is_in_doaj,
    primary_location_source_is_indexed_in_scopus,
    primary_location_source_is_oa,
    ---- int
    ---- date

    -- apc_list
    ---- varchar
    apc_list_currency,
    apc_list_provenance,
    ---- bool
    ---- int
    apc_list_value,
    apc_list_value_usd,
    ---- date

    -- apc_paid
    ---- varchar
    apc_paid_currency,
    apc_paid_provenance,
    ---- bool
    ---- int
    apc_paid_value,
    apc_paid_value_usd,
    ---- date

    -- citation_normalized_percentile
    ---- varchar
    ---- bool
    citation_normalized_percentile_is_in_top_10_percent,
    citation_normalized_percentile_is_in_top_1_percent,
    ---- int
    citation_normalized_percentile_value,
    cited_by_percentile_year_max,
    cited_by_percentile_year_min,
    ---- date

    -- biblio
    ---- varchar
    biblio_first_page,
    biblio_issue,
    biblio_last_page,
    biblio_volume,
    ---- bool
    ---- int
    ---- date

    -- primary_topic
    ---- varchar
    primary_topic_display_name,
    primary_topic_id,
    primary_topic_domain_display_name,
    primary_topic_domain_id,
    primary_topic_field_display_name,
    primary_topic_field_id,
    primary_topic_subfield_display_name,
    primary_topic_subfield_id,
    ---- bool
    ---- int
    COALESCE(primary_topic_score, 0) as primary_topic_score,
    ---- date

    -- best_oa_location
    ---- varchar
    best_oa_location_source,
    best_oa_location_source_id,
    best_oa_location_source_display_name,
    best_oa_location_source_type,
    best_oa_location_source_host_organization,
    best_oa_location_source_host_organization_name,
    best_oa_location_landing_page_url,
    best_oa_location_license,
    best_oa_location_license_id,
    best_oa_location_pdf_url,
    best_oa_location_version,
    best_oa_location_source_issn_l,
    ---- bool
    best_oa_location_is_accepted,
    best_oa_location_is_oa,
    best_oa_location_is_published,
    best_oa_location_source_is_core,
    best_oa_location_source_is_in_doaj,
    best_oa_location_source_is_indexed_in_scopus,
    best_oa_location_source_is_oa,
    load_datetime

  from fillna
)

select * from transformed