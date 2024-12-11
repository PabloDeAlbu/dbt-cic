{{ config(materialized='table') }}

WITH base as (
    SELECT
        CONCAT('https://api.openaire.eu/search/researchProducts?resultID=', dim_pid.researchproduct_id) openaire_url,
        sat.date_collection,
        sat.date_acceptance,
        sat.description,
        sat.publisher,
        sat.isgreen,
        sat.openaccesscolor,
        sat.isindiamondjournal,
        sat.publiclyfunded,
        sat.downloads,
        sat.impulse,
        sat.influence_alt,
        sat.influence,
        sat.popularity_alt,
        sat.popularity,
        sat.views,
        dim_pid.arxiv,
        dim_pid.doi,
        dim_pid.handle,
        dim_pid.mag,
        dim_pid.pmc,
        dim_pid.pmid
    FROM {{ref('sal_openaire_researchproduct')}} sal
    INNER JOIN {{ref('sat_openaire_researchproduct')}} sat ON sal.researchproduct_hk = sat.researchproduct_hk
    INNER JOIN {{ref('dim_pid_openaire')}} dim_pid ON dim_pid.researchproduct_hk = sal.researchproduct_hk
)

SELECT * FROM base
