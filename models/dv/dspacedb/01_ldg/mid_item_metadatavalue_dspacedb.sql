{{ config(materialized = "table") }}

WITH base AS (
    SELECT
        i.item_pk,
        mv.metadata_value_id,
        mv.metadata_field_id,
        msr.short_id,
        mfr.element,
        mfr.qualifier,
        mv.text_value,
        mv.text_lang,
        mv.place,
        mv.authority,
        mv.confidence,
        mv.load_datetime
    FROM {{ source('dspacedb', 'metadatavalue') }} mv
    INNER JOIN {{ source('dspacedb', 'metadatafieldregistry') }} mfr ON mfr.metadata_field_id = mv.metadata_field_id
    INNER JOIN {{ source('dspacedb', 'metadataschemaregistry') }} msr ON msr.metadata_schema_id = mfr.metadata_schema_id
    INNER JOIN {{ source('dspacedb', 'item') }} i ON i.item_id = mv.resource_id and mv.resource_type_id = 2

)

SELECT * FROM base