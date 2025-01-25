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
    FROM {{ref('sal_openaire_researchproduct')}} sal
    INNER JOIN {{ref('hub_openaire_researchproduct')}} hub_researchproduct ON hub_researchproduct.researchproduct_hk = sal.researchproduct_hk
    INNER JOIN {{ref('hub_openaire_arxiv')}} hub_arxiv ON hub_arxiv.arxiv_hk = sal.arxiv_hk
    INNER JOIN {{ref('hub_openaire_doi')}} hub_doi ON hub_doi.doi_hk = sal.doi_hk
    INNER JOIN {{ref('hub_openaire_handle')}} hub_handle ON hub_handle.handle_hk = sal.handle_hk
    INNER JOIN {{ref('hub_openaire_mag')}} hub_mag ON hub_mag.mag_hk = sal.mag_hk
    INNER JOIN {{ref('hub_openaire_pmc')}} hub_pmc ON hub_pmc.pmc_hk = sal.pmc_hk
    INNER JOIN {{ref('hub_openaire_pmid')}} hub_pmid ON hub_pmid.pmid_hk = sal.pmid_hk
)

SELECT * FROM base
