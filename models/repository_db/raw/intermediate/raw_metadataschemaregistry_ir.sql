{{ config(materialized = "table") }}

WITH base AS (
    SELECT
        metadata_schema_id,
        short_id
    FROM {{ source('repository_db', 'metadataschemaregistry') }}
)

SELECT * FROM base