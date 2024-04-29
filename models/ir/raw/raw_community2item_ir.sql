WITH base AS (
    SELECT 
        item_id,
        community_id,
        _airbyte_extracted_at as load_datetime
    FROM {{ source('ir', 'community2item') }}
)


SELECT * FROM base