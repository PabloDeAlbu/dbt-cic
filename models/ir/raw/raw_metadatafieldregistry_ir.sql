WITH base AS (
    SELECT
        metadata_field_id,
        metadata_schema_id,
        element,
        qualifier,
        _airbyte_extracted_at as load_datetime        
    FROM {{ source('ir', 'metadatafieldregistry') }}
)


SELECT * FROM base