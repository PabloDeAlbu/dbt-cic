{{ config(materialized='table') }}

WITH base as (
    SELECT 
        researchproduct_hk,
        SUM(measure_score) as attrank
    FROM {{ref('dim_measure_openaire')}} 
    WHERE measure_id = 'popularity'
    GROUP BY researchproduct_hk
)

SELECT * FROM base
