{{ config(materialized='table') }}

WITH base as (
    SELECT 
        accessright_hk,
        best_access_right
    FROM {{ref('hub_openaire_graph_researchproduct_accessright')}} rp
)

SELECT * FROM base
