{{ config(materialized='table') }}

WITH base as (
    SELECT
        sal_work.work_hk,
        hub_work.work_id,
        hub_doi.doi,
        hub_mag.mag,
        hub_pmcid.pmcid,
        hub_pmid.pmid
    FROM {{ref('sal_work_openalex')}} sal_work
    INNER JOIN {{ref('hub_work_openalex')}} hub_work ON hub_work.work_hk = sal_work.work_hk
    INNER JOIN {{ref('hub_doi_openalex')}} hub_doi ON hub_doi.doi_hk = sal_work.doi_hk
    INNER JOIN {{ref('hub_mag_openalex')}} hub_mag ON hub_mag.mag_hk = sal_work.mag_hk
    INNER JOIN {{ref('hub_pmcid_openalex')}} hub_pmcid ON hub_pmcid.pmcid_hk = sal_work.pmcid_hk
    INNER JOIN {{ref('hub_pmid_openalex')}} hub_pmid ON hub_pmid.pmid_hk = sal_work.pmid_hk
)

SELECT * FROM base
