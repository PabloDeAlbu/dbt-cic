{{ config(materialized='table') }}

WITH base as (
    SELECT 
        lnk.researchproduct_hk,
        hub_researchproduct.researchproduct_id,
        hub_measure.measure_id,
        hub_datasource.measure_datasource,
        sat_measure.measure_score
    FROM {{ref('lnk_openaire_researchproduct2measure')}} lnk
    INNER JOIN {{ref('hub_openaire_researchproduct')}} hub_researchproduct ON hub_researchproduct.researchproduct_hk = lnk.researchproduct_hk
    INNER JOIN {{ref('hub_openaire_measure')}} hub_measure ON hub_measure.measure_hk = lnk.measure_hk
    INNER JOIN {{ref('hub_openaire_datasource')}} hub_datasource ON hub_datasource.datasource_hk = lnk.datasource_hk
    INNER JOIN {{ref('sat_openaire_researchproduct2measure')}} sat_measure ON sat_measure.researchproduct2measure_hk = lnk.researchproduct2measure_hk
)

SELECT * FROM base
