{{ config(materialized='table') }}

WITH base as (
    SELECT
        {# sal.work_hk, #}
        dim_pid.work_id as work_url,
        sat.title,
        sat.publication_date as publication_date,
        sat.countries_distinct_count,
        sat.institutions_distinct_count,
        sat.fwci,
        sat.has_fulltext,
        sat.fulltext_origin,
        sat.cited_by_count,
        sat.is_retracted,
        sat.is_paratext,
        sat.locations_count,
        sat.referenced_works_count,
        sat.updated_date,
        sat.created_date,
        sat.any_repository_has_fulltext,
        sat.is_oa,
        sat.oa_status,
        sat.oa_url,
        sat.cited_by_percentile_year_max,
        sat.cited_by_percentile_year_min,
        sat.citation_normalized_percentile_is_in_top_10_percent,
        sat.citation_normalized_percentile_is_in_top_1_percent,
        sat.citation_normalized_percentile_value,
        sat.apc_list_currency,
        sat.apc_list_provenance,
        sat.apc_list_value,
        sat.apc_list_value_usd,
        sat.apc_paid_currency,
        sat.apc_paid_provenance,
        sat.apc_paid_value,
        sat.apc_paid_value_usd,
        sat.indexed_in_arxiv,
        sat.indexed_in_doaj,
        sat.indexed_in_crossref,
        sat.indexed_in_pubmed,
        dim_pid.doi,
        dim_pid.mag,
        dim_pid.pmcid,
        dim_pid.pmid,
        dim_resourcetype_openalex.worktype_display_name as worktype_label
    FROM {{ref('sal_work_openalex')}} sal
    INNER JOIN {{ref('sat_work_openalex')}} sat ON sal.work_hk = sat.work_hk
    INNER JOIN {{ref('dim_pid_openalex')}} dim_pid ON dim_pid.work_hk = sal.work_hk
    INNER JOIN {{ref('link_work2worktype_openalex')}} ON link_work2worktype_openalex.work_hk = sal.work_hk
    INNER JOIN {{ref('dim_resourcetype_openalex')}} ON dim_resourcetype_openalex.worktype_hk = link_work2worktype_openalex.worktype_hk
)

SELECT * FROM base
