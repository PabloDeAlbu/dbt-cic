{{ config(
    materialized='table',
) }}

with base as (
    SELECT
        hub.researchproduct_id as researchproduct_id,
        COALESCE(hub_doi.doi, 'NO DATA') as doi,
        {# sat.description, #}
        sat.publicly_funded,
        sat.main_title,
        sat.publication_date,
        sat.is_green,
        sat.is_in_diamond_journal,
        sat.language_code,
        sat.language_label,
        sat.citation_class,
        sat.citation_count,
        sat.impulse,
        sat.impulse_class,
        sat.influence,
        sat.influence_class,
        sat.popularity,
        sat.popularity_class,
        sat.downloads,
        sat.views,
        sat.publisher,
        sat.embargo_end_date
    FROM {{ref('hub_openaire_researchproduct')}} hub
    INNER JOIN {{ref('sat_openaire_researchproduct')}} sat ON sat.researchproduct_hk = hub.researchproduct_hk
    LEFT JOIN {{ref('link_openaire_researchproduct_doi')}} link_rp_doi ON link_rp_doi.researchproduct_hk = hub.researchproduct_hk
    LEFT JOIN {{ref('hub_openaire_doi')}} hub_doi ON hub_doi.doi_hk = link_rp_doi.doi_hk
)

SELECT * FROM base
