{{ config(materialized='table') }}

WITH base as (
    SELECT 
        accessright_hk,
        best_access_right,
        CASE 
            WHEN rp.best_access_right = 'OPEN' THEN TRUE
            ELSE FALSE
        END AS is_oa
    FROM {{ref('hub_openaire_researchproduct_accessright')}} rp
)

SELECT * FROM base
