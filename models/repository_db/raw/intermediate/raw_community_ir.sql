{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        community_id
    FROM {{ source('repository_db', 'community') }}
)


SELECT * FROM base