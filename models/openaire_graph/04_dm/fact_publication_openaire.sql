{{ config(
    materialized='table',
    indexes=[
      {'columns': ['doi'], 'type': 'hash'},
    ]
) }}

with base as (
    SELECT
        hub.researchproduct_id as researchproduct_id,
        {# sat.description, #}
        sat_graph.publicly_funded,
        sat_graph.main_title,
        sat_graph.publication_date,
        sat_graph.is_green,
        sat_graph.is_in_diamond_journal,
        sat_graph.language_code,
        sat_graph.language_label,
        sat_graph.citation_class,
        sat_graph.citation_count,
        sat_graph.impulse,
        sat_graph.impulse_class,
        sat_graph.influence,
        sat_graph.influence_class,
        sat_graph.popularity,
        sat_graph.popularity_class,
        sat_graph.downloads,
        sat_graph.views,
        sat_graph.publisher,
        sat_graph.embargo_end_date,
        dim_pid.arxiv,
        dim_pid.doi,
        dim_pid.handle,
        dim_pid.mag,
        dim_pid.pmc,
        dim_pid.pmid,
        dim_type.openaire_type,
        dim_type.coar_label_es,
        dim_type.coar_resourcetype_uri,
        dim_accessright.best_access_right,
        dim_accessright.is_oa--,
--        hub_url.url
    FROM {{ref('hub_openaire_graph_researchproduct')}} hub
    INNER JOIN {{ref('sat_openaire_graph_researchproduct')}} sat_graph ON sat_graph.researchproduct_hk = hub.researchproduct_hk
    INNER JOIN {{ref('dim_pid_openaire_graph')}} dim_pid ON dim_pid.researchproduct_hk = hub.researchproduct_hk
    INNER JOIN {{ref('link_openaire_graph_researchproduct2type')}} link ON link.researchproduct_hk = hub.researchproduct_hk
    INNER JOIN {{ref('dim_resourcetype_openaire')}} dim_type ON dim_type.type_hk = link.type_hk
    INNER JOIN {{ref('link_openaire_graph_researchproduct2accessright')}} link_accessright ON link_accessright.researchproduct_hk = hub.researchproduct_hk
    INNER JOIN {{ref('dim_accessright_openaire')}} dim_accessright ON dim_accessright.accessright_hk = link_accessright.accessright_hk
    -- INNER JOIN {{ref('link_openaire_graph_researchproduct2url')}} link_url ON link_url.researchproduct_hk = hub.researchproduct_hk
    --INNER JOIN {{ref('hub_openaire_graph_url')}} hub_url ON hub_url.url_hk = link_url.url_hk
)

SELECT * FROM base
--SELECT url, count(*) FROM base group by url order by count desc

-- SELECT * FROM base where url = 'https://www.ncbi.nlm.nih.gov/pubmed/26623351'

-- SELECT DISTINCT * FROM base where researchproduct_id = 'doi_dedup___::023cd687bf7daf0ecd66c520d3508c0a';