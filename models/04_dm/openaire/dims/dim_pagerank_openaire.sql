{{ config(materialized='table') }}

WITH base as (
    SELECT 
        researchproduct_hk,
        SUM(measure_score) as pagerank
    FROM {{ref('dim_measure_openaire')}} 
    WHERE measure_id = 'influence'
    GROUP BY researchproduct_hk
)

SELECT * FROM base
