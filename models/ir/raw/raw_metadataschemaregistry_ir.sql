WITH base AS (
    SELECT
        metadata_schema_id,
        short_id,
        _airbyte_extracted_at as load_datetime        
    FROM {{ source('ir', 'metadataschemaregistry') }}
)

SELECT * FROM base