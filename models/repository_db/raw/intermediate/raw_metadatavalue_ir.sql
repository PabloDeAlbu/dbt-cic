WITH base AS (
    SELECT
        metadata_value_id,
        resource_id,
        resource_type_id,
        metadata_field_id,
        text_value,
        authority,
        confidence
    FROM {{ source('repository_db', 'metadatavalue') }}
)


SELECT * FROM base