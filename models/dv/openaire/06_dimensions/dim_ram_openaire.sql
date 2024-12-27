{{ config(materialized='table') }}

WITH base as (
    SELECT 
        researchproduct_hk,
        SUM(measure_score) as ram
    FROM {{ref('dim_measure_openaire')}} 
    WHERE measure_id = 'popularity_alt'
    GROUP BY researchproduct_hk
)

SELECT * FROM base
