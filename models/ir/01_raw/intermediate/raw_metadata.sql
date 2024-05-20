{{ config(materialized = "table") }}

with base as (
    SELECT 
        *
    FROM {{ ref('seed_sedici2openaire') }}
)

SELECT * FROM base
