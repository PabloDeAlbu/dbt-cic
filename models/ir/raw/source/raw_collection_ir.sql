WITH base AS (
    SELECT 
        collection_id
    FROM {{ source('ir', 'collection') }}
)


SELECT * FROM base