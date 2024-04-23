WITH base AS (
    SELECT 
        id,
        item_id,
        collection_id
    FROM {{ source('repository_db', 'collection2item') }}
)

SELECT * FROM base