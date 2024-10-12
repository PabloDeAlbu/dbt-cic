{{ config(materialized='table') }}

WITH base AS (
    SELECT 
        hub.handle_hk,
        hub.handle,
        hub.load_datetime,
        hub.source
    FROM {{ref('hub_handle_dspacedb')}} hub
)

SELECT * FROM base