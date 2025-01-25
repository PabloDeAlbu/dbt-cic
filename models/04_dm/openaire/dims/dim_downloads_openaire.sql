{{ config(materialized='table') }}

WITH base as (
    SELECT 
        researchproduct_hk,
        SUM(measure_score) as total_downloads
    FROM {{ref('dim_measure_openaire')}} 
    WHERE measure_id = 'downloads'
    GROUP BY researchproduct_hk
)

SELECT * FROM base
