{{ config(materialized='table') }}

WITH base as (
    SELECT
        dim_pid.researchproduct_id,
        dim_pid.arxiv,
        dim_pid.doi,
        dim_pid.handle,
        dim_pid.mag,
        dim_pid.pmc,
        dim_pid.pmid,
        sat.date_collection,
        sat.date_acceptance,
        sat.publisher,
        sat.isgreen,
        sat.openaccesscolor,
        sat.isindiamondjournal,
        sat.publiclyfunded
    FROM {{ref('hub_openaire_researchproduct')}} hub
    INNER JOIN {{ref('sat_openaire_researchproduct')}} sat ON sat.researchproduct_hk = hub.researchproduct_hk
    LEFT JOIN {{ref('dim_pid_openaire')}} dim_pid ON dim_pid.researchproduct_hk = hub.researchproduct_hk
)

SELECT * FROM base
