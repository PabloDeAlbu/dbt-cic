{{ config(materialized='table') }}

WITH base as (
    SELECT 
        researchproduct_hk,
        SUM(measure_score) as total_views
    FROM {{ref('dim_measure_openaire')}} 
    WHERE measure_id = 'views'
    GROUP BY researchproduct_hk
)

SELECT * FROM base
