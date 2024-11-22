{{ config(materialized='table') }}

WITH base as (
    SELECT
        sal_researchproduct.researchproduct_hk,
        hub_arxiv.arxiv,
        hub_doi.doi,
        hub_handle.handle,
        hub_mag.mag,
        hub_pmc.pmc,
        hub_pmid.pmid
    FROM {{ref('sal_openaire_researchproduct')}} sal_researchproduct
--    INNER JOIN {{ref('sat_openaire_researchproduct')}} sat_openaire_researchproduct ON sal_researchproduct.researchproduct_hk = sat_openaire_researchproduct.researchproduct_hk
    INNER JOIN {{ref('hub_openaire_arxiv')}} hub_arxiv ON hub_arxiv.arxiv_hk = sal_researchproduct.arxiv_hk
    INNER JOIN {{ref('hub_openaire_doi')}} hub_doi ON hub_doi.doi_hk = sal_researchproduct.doi_hk
    INNER JOIN {{ref('hub_openaire_handle')}} hub_handle ON hub_handle.handle_hk = sal_researchproduct.handle_hk
    INNER JOIN {{ref('hub_openaire_mag')}} hub_mag ON hub_mag.mag_hk = sal_researchproduct.mag_hk
    INNER JOIN {{ref('hub_openaire_pmc')}} hub_pmc ON hub_pmc.pmc_hk = sal_researchproduct.pmc_hk
    INNER JOIN {{ref('hub_openaire_pmid')}} hub_pmid ON hub_pmid.pmid_hk = sal_researchproduct.pmid_hk
)

SELECT * FROM base
