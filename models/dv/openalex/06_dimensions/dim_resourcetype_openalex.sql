{{ config(materialized='table') }}

WITH base AS (
    SELECT 
        hub.worktype_hk,
        hub.worktype_display_name,
        hub.load_datetime,
        hub.source
    FROM {{ref('hub_worktype_openalex')}} hub
)

SELECT * FROM base