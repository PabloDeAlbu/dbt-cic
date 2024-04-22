{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        collection_id
    FROM {{ source('repository_db', 'collection') }}
)


SELECT * FROM base