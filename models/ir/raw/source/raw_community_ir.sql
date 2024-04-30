WITH base AS (
    SELECT 
        community_id
    FROM {{ source('ir', 'community') }}
)


SELECT * FROM base