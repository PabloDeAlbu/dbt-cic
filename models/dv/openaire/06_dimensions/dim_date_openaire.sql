{{ config(materialized='table') }}

WITH base as (
    SELECT 
        lnk.researchproduct_hk,
        hub_researchproduct.researchproduct_id,
        hub_date.date_id,
        sat_date.date_text
    FROM {{ref('lnk_researchproduct2date_openaire')}} lnk
    INNER JOIN {{ref('hub_researchproduct_openaire')}} hub_researchproduct ON hub_researchproduct.researchproduct_hk = lnk.researchproduct_hk
    INNER JOIN {{ref('hub_date_openaire')}} hub_date ON hub_date.date_hk = lnk.date_hk
    INNER JOIN {{ref('sat_researchproduct2date_openaire')}} sat_date ON sat_date.researchproduct2date_hk = lnk.researchproduct2date_hk
)

SELECT * FROM base
