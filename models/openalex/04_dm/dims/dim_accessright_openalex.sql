{{ config(materialized='table') }}

WITH base AS (
    SELECT DISTINCT
        sat.oa_status,
        CASE 
            WHEN sat.oa_status = 'closed' THEN FALSE
            ELSE TRUE
        END AS is_oa
    FROM {{ ref('sat_work_openalex') }} sat
)

SELECT * FROM base
