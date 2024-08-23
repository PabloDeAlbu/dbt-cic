WITH base AS (
    SELECT 
        item_id,
        community_id
    FROM {{ source('ir', 'community2item') }}
)

SELECT * FROM base