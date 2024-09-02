WITH base as (
    SELECT
        sal_work.work_hk,
        sat_work_openalex.title,
        (sat_work_openalex.publication_year) as publication_year,
        {{ dbt_date.convert_timezone("sat_work_openalex.publication_date") }} as publication_date,
        sat_work_openalex.countries_distinct_count,
        sat_work_openalex.institutions_distinct_count,
        sat_work_openalex.fwci,
        sat_work_openalex.has_fulltext,
        sat_work_openalex.fulltext_origin,
        sat_work_openalex.cited_by_count,
        sat_work_openalex.is_retracted,
        sat_work_openalex.is_paratext,
        sat_work_openalex.locations_count,
        sat_work_openalex.referenced_works_count,
        sat_work_openalex.updated_date,
        sat_work_openalex.created_date,
        sat_work_openalex.any_repository_has_fulltext,
        sat_work_openalex.is_oa,
        sat_work_openalex.oa_status,
        sat_work_openalex.oa_url,
        sat_work_openalex.cited_by_percentile_year_max,
        sat_work_openalex.cited_by_percentile_year_min,
        sat_work_openalex.citation_normalized_percentile_is_in_top_10_percent,
        sat_work_openalex.citation_normalized_percentile_is_in_top_1_percent,
        sat_work_openalex.citation_normalized_percentile_value,
        sat_work_openalex.apc_list_currency,
        sat_work_openalex.apc_list_provenance,
        sat_work_openalex.apc_list_value,
        sat_work_openalex.apc_list_value_usd,
        sat_work_openalex.apc_paid_currency,
        sat_work_openalex.apc_paid_provenance,
        sat_work_openalex.apc_paid_value,
        sat_work_openalex.apc_paid_value_usd,
        sat_work_openalex.indexed_in_arxiv,
        sat_work_openalex.indexed_in_doaj,
        sat_work_openalex.indexed_in_crossref,
        sat_work_openalex.indexed_in_pubmed,
        hub_doi.doi,
        hub_mag.mag,
        hub_pmcid.pmcid,
        hub_pmid.pmid,
        sat_resourcetype_coar.label_es as worktype_label
    FROM {{ref('sal_work_openalex')}} sal_work
    INNER JOIN {{ref('sat_work_openalex')}} sat_work_openalex ON sal_work.work_hk = sat_work_openalex.work_hk
    INNER JOIN {{ref('hub_doi_openalex')}} hub_doi ON hub_doi.doi_hk = sal_work.doi_hk
    INNER JOIN {{ref('hub_mag_openalex')}} hub_mag ON hub_mag.mag_hk = sal_work.mag_hk
    INNER JOIN {{ref('hub_pmcid_openalex')}} hub_pmcid ON hub_pmcid.pmcid_hk = sal_work.pmcid_hk
    INNER JOIN {{ref('hub_pmid_openalex')}} hub_pmid ON hub_pmid.pmid_hk = sal_work.pmid_hk
    INNER JOIN {{ref('link_work2worktype_openalex')}} ON link_work2worktype_openalex.work_hk = sal_work.work_hk
    INNER JOIN {{ref('sal_resourcetype_coar')}} ON sal_resourcetype_coar.worktype_hk = link_work2worktype_openalex.worktype_hk
    INNER JOIN {{ref('sat_resourcetype_coar')}} ON sat_resourcetype_coar.resourcetype_hk = sal_resourcetype_coar.resourcetype_hk
)

SELECT * FROM base
