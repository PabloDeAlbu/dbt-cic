{{ config(
    materialized='table',
    indexes=[
      {'columns': ['doi'], 'type': 'hash'},
    ]
) }}

WITH base as (
    SELECT
        {# sal.work_hk, #}
        dim_pid.work_id,
        dim_pid.doi,
        dim_pid.mag,
        dim_pid.pmcid,
        dim_pid.pmid,
        dim_type.openalex_type,
        dim_type.coar_label_es,
        dim_type.coar_resourcetype_uri,
        sat.title,
        sat.display_name,
        sat.language,
        sat.fulltext_origin,
        {# sat.oa_status,
        sat.oa_url, #}
        sat.cited_by_api_url,
        sat.any_repository_has_fulltext,
        sat.has_fulltext,
        sat.is_retracted,
        sat.is_paratext,
        sat.countries_distinct_count,
        sat.institutions_distinct_count,
        sat.fwci,
        sat.cited_by_count,
        sat.locations_count,
        sat.referenced_works_count,
        sat.publication_year,
        sat.publication_date,
        sat.updated_date,
        sat.created_date,
        dim_accessright.is_oa
    FROM {{ref('sal_work_openalex')}} sal
    INNER JOIN {{ref('sat_work_openalex')}} sat ON sal.work_hk = sat.work_hk
    INNER JOIN {{ref('dim_pid_openalex')}} dim_pid ON dim_pid.work_hk = sal.work_hk
    INNER JOIN {{ref('link_work2type_openalex')}} link_work_type ON link_work_type.work_hk = sal.work_hk
    INNER JOIN {{ref('dim_resourcetype_openalex')}} dim_type ON dim_type.type_hk = link_work_type.type_hk
    INNER JOIN {{ref('dim_accessright_openalex')}} dim_accessright ON dim_accessright.oa_status = sat.oa_status
)

SELECT * FROM base
