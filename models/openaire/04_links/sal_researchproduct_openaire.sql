with base as (
    SELECT
        hub_rp.researchproduct_hk,
        hub_rp.id,
        hub_arxiv.arxiv,
        hub_doi.doi,
        hub_ena.ena,
        hub_pdb.pdb,
        hub_pmc.pmc,
        hub_pmid.pmid,
        hub_uniprot.uniprot,
        hub_rp.load_datetime,
        hub_rp.source
    FROM {{ref('hub_researchproduct_openaire')}} hub_rp
    LEFT JOIN {{ref('link_researchproduct_arxiv_openaire')}} link_rp_arxiv ON hub_rp.researchproduct_hk = link_rp_arxiv.researchproduct_hk
    LEFT JOIN {{ref('hub_arxiv_openaire')}} hub_arxiv ON link_rp_arxiv.arxiv_hk = hub_arxiv.arxiv_hk
    LEFT JOIN {{ref('link_researchproduct_doi_openaire')}} link_rp_doi ON hub_rp.researchproduct_hk = link_rp_doi.researchproduct_hk
    LEFT JOIN {{ref('hub_doi_openaire')}} hub_doi ON link_rp_doi.doi_hk = hub_doi.doi_hk
    LEFT JOIN {{ref('link_researchproduct_ena_openaire')}} link_rp_ena ON hub_rp.researchproduct_hk = link_rp_ena.researchproduct_hk
    LEFT JOIN {{ref('hub_ena_openaire')}} hub_ena ON link_rp_ena.ena_hk = hub_ena.ena_hk
    LEFT JOIN {{ref('link_researchproduct_pdb_openaire')}} link_rp_pdb ON hub_rp.researchproduct_hk = link_rp_pdb.researchproduct_hk
    LEFT JOIN {{ref('hub_pdb_openaire')}} hub_pdb ON link_rp_pdb.pdb_hk = hub_pdb.pdb_hk
    LEFT JOIN {{ref('link_researchproduct_pmc_openaire')}} link_rp_pmc ON hub_rp.researchproduct_hk = link_rp_pmc.researchproduct_hk
    LEFT JOIN {{ref('hub_pmc_openaire')}} hub_pmc ON link_rp_pmc.pmc_hk = hub_pmc.pmc_hk
    LEFT JOIN {{ref('link_researchproduct_pmid_openaire')}} link_rp_pmid ON hub_rp.researchproduct_hk = link_rp_pmid.researchproduct_hk
    LEFT JOIN {{ref('hub_pmid_openaire')}} hub_pmid ON link_rp_pmid.pmid_hk = hub_pmid.pmid_hk
    LEFT JOIN {{ref('link_researchproduct_uniprot_openaire')}} link_rp_uniprot ON hub_rp.researchproduct_hk = link_rp_uniprot.researchproduct_hk
    LEFT JOIN {{ref('hub_uniprot_openaire')}} hub_uniprot ON link_rp_uniprot.uniprot_hk = hub_uniprot.uniprot_hk
)

SELECT * FROM base