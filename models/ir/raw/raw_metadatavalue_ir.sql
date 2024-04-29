WITH base AS (
    SELECT
        metadata_value_id,
        resource_id,
        resource_type_id,
        metadata_field_id,
        authority,
        confidence,
        text_lang,
        text_value,
        _airbyte_extracted_at as load_datetime        
    FROM {{ source('ir', 'metadatavalue') }}
)


SELECT * FROM base