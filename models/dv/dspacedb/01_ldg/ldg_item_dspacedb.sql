{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        {# item_id, #}
        in_archive,
        withdrawn,
        last_modified,
        discoverable,
        i.uuid,
        submitter_id,
        owning_collection,
        load_datetime,
        title.title,
        title.title_lang,
        dateissued.dateissued,
        type.type,
        COALESCE(doi.doi, 'NOT_SET') as doi,
        handle.handle
        FROM {{ source('dspacedb', 'item') }} i
        INNER JOIN {{ ref('raw_item_title_dspacedb') }} title ON i.uuid = title.uuid 
        INNER JOIN {{ ref('raw_item_dateissued_dspacedb') }} dateissued ON i.uuid = dateissued.uuid 
        INNER JOIN {{ ref('raw_item_type_dspacedb') }} type ON i.uuid = type.uuid 
        LEFT JOIN {{ ref('raw_item_doi_dspacedb') }} doi ON i.uuid = doi.uuid 
        INNER JOIN {{ ref('raw_item_handle_dspacedb') }} handle ON i.uuid = handle.uuid 
)

SELECT * FROM base