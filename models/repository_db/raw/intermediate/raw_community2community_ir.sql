{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        id,
        child_comm_id,
        parent_comm_id
    FROM {{ source('repository_db', 'community2community') }}
)

SELECT * FROM base