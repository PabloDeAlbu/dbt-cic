{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        i.item_pk,
        COALESCE(doi.doi, 'NOT_SET') as doi,
        COALESCE(handle.handle, 'NOT_SET') as handle,
        dateissued.dateissued,
        COALESCE(type.type, 'NOT_SET') as type,
        COALESCE(title.title, 'NOT_SET') as title,
        COALESCE(title_lang, 'NOT_SET') as title_lang,
        i.discoverable,
        i.in_archive,
        i.last_modified,
        i.load_datetime,
        owning_collection,
        submitter_id,
        withdrawn
    FROM {{ source('dspacedb', 'item') }} i
    INNER JOIN {{ ref('mid_item_title_dspacedb') }} title ON i.item_pk = title.item_pk
    INNER JOIN {{ ref('mid_item_dateissued_dspacedb') }} dateissued ON i.item_pk = dateissued.item_pk 
    INNER JOIN {{ ref('mid_item_type_dspacedb') }} type ON i.item_pk = type.item_pk 
    LEFT JOIN {{ ref('mid_item_doi_dspacedb') }} doi ON i.item_pk = doi.item_pk 
    INNER JOIN {{ ref('mid_item_handle_dspacedb') }} handle ON i.item_pk = handle.item_pk 
)

SELECT * FROM base