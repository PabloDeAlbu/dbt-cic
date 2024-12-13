{{ config(materialized='table') }}

WITH base as (
    SELECT
        CONCAT('https://api.openaire.eu/search/researchProducts?resultID=', dim_pid.researchproduct_id) openaire_url,
        sat.date_collection,
        sat.date_acceptance,
        {# sat.description, #}
        sat.publisher,
        sat.isgreen,
        sat.openaccesscolor,
        sat.isindiamondjournal,
        sat.publiclyfunded,
        {# sat.downloads,
        sat.impulse,
        sat.influence_alt,
        sat.influence,
        sat.popularity_alt,
        sat.popularity, #}
        COALESCE(dim_downloads.total_downloads, 0) as total_downloads,
        COALESCE(dim_views.total_views, 0) as total_views,
        dim_pid.arxiv,
        dim_pid.doi,
        dim_pid.handle,
        dim_pid.mag,
        dim_pid.pmc,
        dim_pid.pmid
    FROM {{ref('sal_researchproduct_openaire')}} sal
    INNER JOIN {{ref('sat_researchproduct_openaire')}} sat ON sat.researchproduct_hk = sal.researchproduct_hk
    INNER JOIN {{ref('dim_pid_openaire')}} dim_pid ON dim_pid.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_views_openaire')}} dim_views ON dim_views.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_downloads_openaire')}} dim_downloads ON dim_downloads.researchproduct_hk = sal.researchproduct_hk
)

SELECT * FROM base
