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
        sat_graph.type,
        sat_graph.main_title,
        sat_graph.publication_date,
        sat_graph.is_green,
        sat_graph.is_in_diamond_journal,
        sat_graph.language_code,
        sat_graph.language_label,
        sat_graph.best_access_right,
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
        dim_pid.pmid
    FROM {{ref('hub_openaire_graph_researchproduct')}} hub
    INNER JOIN {{ref('sat_openaire_graph_researchproduct')}} sat_graph ON sat_graph.researchproduct_hk = hub.researchproduct_hk
    INNER JOIN {{ref('dim_pid_openaire_graph')}} dim_pid ON dim_pid.researchproduct_hk = hub.researchproduct_hk
)

SELECT * FROM base
