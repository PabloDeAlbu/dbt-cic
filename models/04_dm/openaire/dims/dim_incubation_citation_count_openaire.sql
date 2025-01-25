{{ config(materialized='table') }}

WITH base as (
    SELECT 
        researchproduct_hk,
        SUM(measure_score) as incubation_citation_count
    FROM {{ref('dim_measure_openaire')}} 
    WHERE measure_id = 'impulse'
    GROUP BY researchproduct_hk
)

SELECT * FROM base
