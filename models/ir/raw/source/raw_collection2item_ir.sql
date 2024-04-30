WITH base AS (
    SELECT 
        id,
        item_id,
        collection_id
    FROM {{ source('ir', 'collection2item') }}
)

SELECT * FROM base