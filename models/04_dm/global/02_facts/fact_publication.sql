{{ config(materialized='table') }}

WITH dspacedb as (
    SELECT
        dspacedb.title,
        dspacedb.doi,
        dspacedb.dateissued
    FROM {{ ref('fact_publication_dspacedb') }} dspacedb
),

add_openalex as (
    SELECT
        COALESCE(dspacedb.title, openalex.title) as title,
        COALESCE(dspacedb.doi, openalex.doi) as doi,
        COALESCE(dspacedb.dateissued, openalex.publication_date) as publication_date,
        COALESCE(openalex.countries_distinct_count, 0) as openalex_countries_distinct_count,
        COALESCE(openalex.institutions_distinct_count, 0) as openalex_institutions_distinct_count,
        COALESCE(openalex.fwci, 0) as openalex_fwci,
        COALESCE(openalex.has_fulltext, false) as openalex_has_fulltext,
        COALESCE(openalex.fulltext_origin, 'NO DATA') as openalex_fulltext_origin,
        COALESCE(openalex.cited_by_count, 0) as openalex_cited_by_count,
        COALESCE(openalex.is_retracted, false) as openalex_is_retracted,
        COALESCE(openalex.is_paratext, false) as openalex_is_paratext,
        COALESCE(openalex.locations_count, 0) as openalex_locations_count,
        COALESCE(openalex.referenced_works_count, 0) as openalex_referenced_works_count,
        COALESCE(openalex.any_repository_has_fulltext, false) as openalex_any_repository_has_fulltext,
        COALESCE(openalex.is_oa, false) as openalex_is_oa,
        COALESCE(openalex.oa_status, 'NO DATA') as openalex_oa_status,
        COALESCE(openalex.oa_url, 'NO DATA') as openalex_oa_url,
        COALESCE(openalex.cited_by_percentile_year_max, 0) as openalex_cited_by_percentile_year_max,
        COALESCE(openalex.cited_by_percentile_year_min, 0) as openalex_cited_by_percentile_year_min,
        COALESCE(openalex.citation_normalized_percentile_is_in_top_10_percent, 'NO DATA') as openalex_citation_normalized_percentile_is_in_top_10_percent,
        COALESCE(openalex.citation_normalized_percentile_is_in_top_1_percent, 'NO DATA') as openalex_citation_normalized_percentile_is_in_top_1_percent,
        COALESCE(openalex.citation_normalized_percentile_value, 0) as openalex_citation_normalized_percentile_value,
        COALESCE(openalex.apc_list_currency, 'NO DATA') as openalex_apc_list_currency,
        COALESCE(openalex.apc_list_provenance, 'NO DATA') as openalex_apc_list_provenance,
        COALESCE(openalex.apc_list_value, 0) as openalex_apc_list_value,
        COALESCE(openalex.apc_list_value_usd, 0) as openalex_apc_list_value_usd,
        COALESCE(openalex.apc_paid_currency, 'NO DATA') as openalex_apc_paid_currency,
        COALESCE(openalex.apc_paid_provenance, 'NO DATA') as openalex_apc_paid_provenance,
        COALESCE(openalex.apc_paid_value, 0) as openalex_apc_paid_value,
        COALESCE(openalex.apc_paid_value_usd, 0) as openalex_apc_paid_value_usd,
        COALESCE(openalex.indexed_in_arxiv, false) as openalex_indexed_in_arxiv,
        COALESCE(openalex.indexed_in_doaj, false) as openalex_indexed_in_doaj,
        COALESCE(openalex.indexed_in_crossref, false) as openalex_indexed_in_crossref,
        COALESCE(openalex.indexed_in_pubmed, false) as openalex_indexed_in_pubmed
    FROM dspacedb
    LEFT JOIN {{ ref('fact_publication_openalex') }} openalex ON openalex.doi = dspacedb.doi
),

base as (
    SELECT
        add_openalex.title,
        add_openalex.doi,
        add_openalex.openalex_countries_distinct_count,
        add_openalex.openalex_institutions_distinct_count,
        add_openalex.openalex_fwci,
        add_openalex.openalex_has_fulltext,
        add_openalex.openalex_cited_by_count,
        add_openalex.openalex_is_retracted,
        add_openalex.openalex_is_paratext,
        add_openalex.openalex_locations_count,
        add_openalex.openalex_referenced_works_count,
        add_openalex.openalex_any_repository_has_fulltext,
        add_openalex.openalex_is_oa,
        add_openalex.openalex_cited_by_percentile_year_max,
        add_openalex.openalex_cited_by_percentile_year_min,
        add_openalex.openalex_citation_normalized_percentile_value,
        add_openalex.openalex_apc_list_value,
        add_openalex.openalex_apc_list_value_usd,
        add_openalex.openalex_apc_paid_value,
        add_openalex.openalex_apc_paid_value_usd,
        add_openalex.openalex_indexed_in_arxiv,
        add_openalex.openalex_indexed_in_doaj,
        add_openalex.openalex_indexed_in_crossref,
        add_openalex.openalex_indexed_in_pubmed,
        openaire.attrank as openaire_attrank,
        openaire.citation_count as openaire_citation_count,
        openaire.total_downloads as openaire_total_downloads,
        openaire.incubation_citation_count as openaire_incubation_citation_count,
        openaire.pagerank as openaire_pagerank,
        openaire.ram as openaire_ram,
        openaire.total_views as openaire_total_views,
        COALESCE(add_openalex.publication_date, openaire.date_issued) as publication_date
    FROM add_openalex
    LEFT JOIN {{ ref('fact_publication_openaire') }} openaire ON openaire.doi = add_openalex.doi
),

fact as (
    SELECT 
        base.*,
        dim_doi.in_dspacedb,
        dim_doi.in_openaire,
        dim_doi.in_openalex
    FROM base
    LEFT JOIN {{ ref('dim_doi') }} ON dim_doi.doi = base.doi
)

SELECT * FROM fact