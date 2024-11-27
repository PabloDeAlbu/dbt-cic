{{ config(materialized='table') }}

WITH base as (
    SELECT
        CONCAT('https://api.openaire.eu/search/researchProducts?resultID=', dim_pid.id) openaire_url,
        sat.dateofcollection,
        sat.dateofacceptance,
        sat.description,
        sat.publisher,
        sat.isgreen,
        sat.openaccesscolor,
        sat.isindiamondjournal,
        sat.publiclyfunded,
        dim_pid.arxiv,
        dim_pid.doi,
        dim_pid.handle,
        dim_pid.mag,
        dim_pid.pmc,
        dim_pid.pmid,
        dim_measure.attrank,
        dim_measure.cc,
        dim_measure.downloads,
        dim_measure.icc,
        dim_measure.pr,
        dim_measure.ram,
        dim_measure.views
    FROM {{ref('sal_openaire_researchproduct')}} sal
    INNER JOIN {{ref('sat_openaire_researchproduct')}} sat ON sal.researchproduct_hk = sat.researchproduct_hk
    INNER JOIN {{ref('dim_pid_openaire')}} dim_pid ON dim_pid.researchproduct_hk = sal.researchproduct_hk
    INNER JOIN {{ref('dim_measure_openaire')}} dim_measure ON dim_measure.researchproduct_hk = sal.researchproduct_hk
)

SELECT * FROM base
