{{ config(materialized = "table") }}

WITH base AS (
    SELECT
        metadata_field_id,
        metadata_schema_id,
        element,
        qualifier
    FROM {{ source('repository_db', 'metadatafieldregistry') }}
)


SELECT * FROM base