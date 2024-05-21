WITH base AS (
    SELECT
        sat.id as openalex_id,
        sat.language,
        sat.title,
        sat.publication_date,
        sat.issue,
        sat.volume,
        sat.first_page,
        sat.end_page,
        sat.doi,
        sat.mag,
        sat.pmid,
        sat.pmcid,
        sat.is_paratext,
        sat.is_oa,
        sat.oa_url,
        sat.oa_status,
        sat.any_repository_has_fulltext,
        sat.display_name,
        sat.has_fulltext,
        sat.is_retracted,
        sat.type_crossref,
        sat.cited_by_count,
        sat.locations_count,
        sat.is_authors_truncated,
        sat.referenced_works_count,
        sat.cited_by_percentile_year_max,
        sat.cited_by_percentile_year_min,
        sat.countries_distinct_count,
        sat.institutions_distinct_count,
        dim_resource_type_openalex.openalex_type,
        dim_resource_type_openalex.coar_label_es,
        dim_resource_type_openalex.coar_uri
    FROM {{ref('sal_work_openalex')}} sal 
    INNER JOIN {{ref('sat_work_openalex')}} sat ON sal.work_hk = sat.work_hk
    INNER JOIN {{ref('link_work_type_openalex')}} ON link_work_type_openalex.work_hk = sal.work_hk
    INNER JOIN {{ref('dim_resource_type_openalex')}} ON dim_resource_type_openalex.type_hk = link_work_type_openalex.type_hk
),

final AS (
    SELECT
    *
    FROM base
)

SELECT * FROM final