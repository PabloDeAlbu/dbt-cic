{{ config(materialized='table') }}

WITH base as (
    SELECT
        sal_work.work_hk,
        COALESCE(hub_work.work_id, 'NO DATA') as work_id,
        COALESCE(hub_doi.doi, 'NO DATA') as doi,
        COALESCE(hub_mag.mag, 'NO DATA') as mag,
        COALESCE(hub_pmcid.pmcid, 'NO DATA') as pmcid,
        COALESCE(hub_pmid.pmid, 'NO DATA') as pmid
    FROM {{ref('sal_openalex_work')}} sal_work
    LEFT JOIN {{ref('hub_openalex_work')}} hub_work ON hub_work.work_hk = sal_work.work_hk
    LEFT JOIN {{ref('hub_openalex_doi')}} hub_doi ON hub_doi.doi_hk = sal_work.doi_hk
    LEFT JOIN {{ref('hub_openalex_mag')}} hub_mag ON hub_mag.mag_hk = sal_work.mag_hk
    LEFT JOIN {{ref('hub_openalex_pmcid')}} hub_pmcid ON hub_pmcid.pmcid_hk = sal_work.pmcid_hk
    LEFT JOIN {{ref('hub_openalex_pmid')}} hub_pmid ON hub_pmid.pmid_hk = sal_work.pmid_hk
)

SELECT * FROM base
