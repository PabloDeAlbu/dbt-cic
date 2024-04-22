{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        item_id,
        community_id
    FROM {{ source('repository_db', 'community2item') }}
)

SELECT * FROM base