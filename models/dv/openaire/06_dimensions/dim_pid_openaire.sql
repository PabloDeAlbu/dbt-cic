{{ config(materialized='table') }}

WITH base as (
    SELECT 
        sal.researchproduct_hk,
        hub_researchproduct.researchproduct_id,
        hub_arxiv.arxiv,
        hub_doi.doi,
        hub_handle.handle,
        hub_mag.mag,
        hub_pmc.pmc,
        hub_pmid.pmid
    FROM {{ref('sal_researchproduct_openaire')}} sal
    INNER JOIN {{ref('hub_researchproduct_openaire')}} hub_researchproduct ON hub_researchproduct.researchproduct_hk = sal.researchproduct_hk
    INNER JOIN {{ref('hub_arxiv_openaire')}} hub_arxiv ON hub_arxiv.arxiv_hk = sal.arxiv_hk
    INNER JOIN {{ref('hub_doi_openaire')}} hub_doi ON hub_doi.doi_hk = sal.doi_hk
    INNER JOIN {{ref('hub_handle_openaire')}} hub_handle ON hub_handle.handle_hk = sal.handle_hk
    INNER JOIN {{ref('hub_mag_openaire')}} hub_mag ON hub_mag.mag_hk = sal.mag_hk
    INNER JOIN {{ref('hub_pmc_openaire')}} hub_pmc ON hub_pmc.pmc_hk = sal.pmc_hk
    INNER JOIN {{ref('hub_pmid_openaire')}} hub_pmid ON hub_pmid.pmid_hk = sal.pmid_hk
)

SELECT * FROM base
