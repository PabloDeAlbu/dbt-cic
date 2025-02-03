{{ config(
    materialized='materialized_view',
    indexes=[
      {'columns': ['doi'], 'type': 'hash'},
    ]
) }}

WITH base as (
    SELECT
        {# sal.work_hk, #}
        dim_pid.work_id,
        sat.title,
        sat.display_name,
        sat.language,
        sat.type,
        sat.type_crossref,
        sat.fulltext_origin,
        sat.cited_by_api_url,
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
        dim_pid.doi,
        dim_pid.mag,
        dim_pid.pmcid,
        dim_pid.pmid
    FROM {{ref('sal_work_openalex')}} sal
    INNER JOIN {{ref('sat_work_openalex')}} sat ON sal.work_hk = sat.work_hk
    INNER JOIN {{ref('dim_pid_openalex')}} dim_pid ON dim_pid.work_hk = sal.work_hk
)

SELECT * FROM base
