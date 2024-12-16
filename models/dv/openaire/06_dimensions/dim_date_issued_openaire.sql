{{ config(materialized='table') }}

WITH base as (
    SELECT 
        researchproduct_hk,
        date_text
    FROM {{ref('dim_date_openaire')}} 
    WHERE date_id = 'issued'
)

SELECT * FROM base
