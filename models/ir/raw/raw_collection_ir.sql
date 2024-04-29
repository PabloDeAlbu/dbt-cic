WITH base AS (
    SELECT 
        collection_id,
        submitter,
        admin,
        _airbyte_extracted_at as load_datetime
    FROM {{ source('ir', 'collection') }}
)


SELECT * FROM base