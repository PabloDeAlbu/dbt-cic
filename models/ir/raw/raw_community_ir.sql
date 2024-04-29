WITH base AS (
    SELECT 
        community_id,
        admin,
        _airbyte_extracted_at as load_datetime
    FROM {{ source('ir', 'community') }}
)


SELECT * FROM base