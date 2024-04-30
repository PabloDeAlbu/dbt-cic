WITH base AS (
    SELECT
        metadata_field_id,
        metadata_schema_id,
        element,
        qualifier
    FROM {{ source('ir', 'metadatafieldregistry') }}
)


SELECT * FROM base