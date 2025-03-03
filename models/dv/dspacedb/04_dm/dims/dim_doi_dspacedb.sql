{{ config(materialized='table') }}

WITH base AS (
    SELECT 
        hub.doi_hk,
        hub.doi,
        hub.load_datetime,
        hub.source
    FROM {{ref('hub_doi_dspacedb')}} hub
)

SELECT * FROM base