WITH base AS (
    SELECT
        metadata_schema_id,
        short_id
    FROM {{ source('ir', 'metadataschemaregistry') }}
)

SELECT * FROM base