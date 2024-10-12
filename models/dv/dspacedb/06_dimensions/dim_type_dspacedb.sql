{{ config(materialized='table') }}

WITH base AS (
    SELECT 
        hub.type_hk,
        hub.type,
        hub.load_datetime,
        hub.source
    FROM {{ref('hub_type_dspacedb')}} hub
)

SELECT * FROM base