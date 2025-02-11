{{ config(materialized='table') }}

WITH base as (
    SELECT
        hub.researchproduct_hk,
        COALESCE(hub.researchproduct_id, 'NO DATA') as researchproduct_id,
        COALESCE(hub_arxiv.arxiv, 'NO DATA') as arxiv,
        COALESCE(hub_doi.doi, 'NO DATA') as doi,
        COALESCE(hub_handle.handle, 'NO DATA') as handle,
        COALESCE(hub_mag.mag, 'NO DATA') as mag,
        COALESCE(hub_pmc.pmc, 'NO DATA') as pmc,
        COALESCE(hub_pmid.pmid, 'NO DATA') as pmid
    FROM {{ref('hub_openaire_graph_researchproduct')}} hub
    LEFT JOIN {{ref('link_openaire_graph_researchproduct2doi')}} lnk_rp2doi ON lnk_rp2doi.researchproduct_hk = hub.researchproduct_hk
    LEFT JOIN {{ref('hub_openaire_graph_doi')}} hub_doi ON hub_doi.doi_hk = lnk_rp2doi.doi_hk
    LEFT JOIN {{ref('link_openaire_graph_researchproduct2arxiv')}} lnk_rp2arxiv ON lnk_rp2arxiv.researchproduct_hk = hub.researchproduct_hk
    LEFT JOIN {{ref('hub_openaire_graph_arxiv')}} hub_arxiv ON hub_arxiv.arxiv_hk = lnk_rp2arxiv.arxiv_hk
    LEFT JOIN {{ref('link_openaire_graph_researchproduct2handle')}} lnk_rp2handle ON lnk_rp2handle.researchproduct_hk = hub.researchproduct_hk
    LEFT JOIN {{ref('hub_openaire_graph_handle')}} hub_handle ON hub_handle.handle_hk = lnk_rp2handle.handle_hk
    LEFT JOIN {{ref('link_openaire_graph_researchproduct2mag')}} lnk_rp2mag ON lnk_rp2mag.researchproduct_hk = hub.researchproduct_hk
    LEFT JOIN {{ref('hub_openaire_graph_mag')}} hub_mag ON hub_mag.mag_hk = lnk_rp2mag.mag_hk 
    LEFT JOIN {{ref('link_openaire_graph_researchproduct2pmc')}} lnk_rp2pmc ON lnk_rp2pmc.researchproduct_hk = hub.researchproduct_hk
    LEFT JOIN {{ref('hub_openaire_graph_pmc')}} hub_pmc ON hub_pmc.pmc_hk = lnk_rp2pmc.pmc_hk
    LEFT JOIN {{ref('link_openaire_graph_researchproduct2pmid')}} lnk_rp2pmid ON lnk_rp2pmid.researchproduct_hk = hub.researchproduct_hk
    LEFT JOIN {{ref('hub_openaire_graph_pmid')}} hub_pmid ON hub_pmid.pmid_hk = lnk_rp2pmid.pmid_hk
),

unique_id as (
    SELECT researchproduct_id
    FROM stg_openaire_graph.dim_pid_openaire_graph
    GROUP BY 1
    HAVING COUNT(*) = 1
),

final as (
    SELECT * 
    FROM base
    WHERE researchproduct_id IN (SELECT researchproduct_id FROM unique_id)
)

SELECT * FROM final