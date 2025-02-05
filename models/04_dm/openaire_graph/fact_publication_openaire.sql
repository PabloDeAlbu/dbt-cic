{{ config(
    materialized='materialized_view',
    indexes=[
      {'columns': ['doi'], 'type': 'hash'},
    ]
) }}

WITH base as (
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
        dim_accessright.best_access_right
    FROM {{ref('hub_openaire_graph_researchproduct')}} hub
    INNER JOIN {{ref('sat_openaire_graph_researchproduct')}} sat_graph ON sat_graph.researchproduct_hk = hub.researchproduct_hk
    INNER JOIN {{ref('dim_pid_openaire_graph')}} dim_pid ON dim_pid.researchproduct_hk = hub.researchproduct_hk
    INNER JOIN {{ref('link_openaire_graph_researchproduct2type')}} link ON link.researchproduct_hk = hub.researchproduct_hk
    INNER JOIN {{ref('dim_resourcetype_openaire')}} dim_type ON dim_type.type_hk = link.type_hk
    INNER JOIN {{ref('link_openaire_graph_researchproduct2accessright')}} link_accessright ON link_accessright.researchproduct_hk = hub.researchproduct_hk
    INNER JOIN {{ref('dim_accessright_openaire')}} dim_accessright ON dim_accessright.accessright_hk = link_accessright.accessright_hk
)

SELECT * FROM base
