{{ config(materialized = "table") }}

WITH item AS (
    SELECT 
        item_id, 
        last_modified,
        submitter_id,
        owning_collection,
        _airbyte_extracted_at
    FROM {{ source('ir', 'item') }}
    WHERE withdrawn = false and in_archive = true and discoverable = true
),

final AS (
    SELECT 
        item.item_id,
        item.submitter_id,
        item.owning_collection,
        item_type.type,
        item_subtype.subtype,
        item_language.language,
        item_title.title,
        item_subtitle.subtitle,
        item_handle.handle,
        item_doi.doi,
        {{ str_to_date('item_available_date.available_date') }} as available_date,
        {{ str_to_date('item_created_date.created_date') }} as created_date,
        {{ str_to_date('item_exposure_date.exposure_date') }} as exposure_date,
        {{ str_to_date('item_publication_date.publication_date') }} as publication_date,
        item_license_uri.license_uri,
        item_partof.partof,
        item_volume.volume,
        item.last_modified,
        item._airbyte_extracted_at
    FROM item
    LEFT JOIN {{ref('raw_item_title')}} AS item_title ON item.item_id  = item_title.item_id
    LEFT JOIN {{ref('raw_item_subtitle')}} AS item_subtitle ON item.item_id = item_subtitle.item_id
    LEFT JOIN {{ref('raw_item_type')}} AS item_type ON item.item_id = item_type.item_id
    LEFT JOIN {{ref('raw_item_subtype')}} AS item_subtype ON item.item_id = item_subtype.item_id
    LEFT JOIN {{ref('raw_item_doi')}} AS item_doi ON item.item_id = item_doi.item_id
    LEFT JOIN {{ref('raw_item_handle')}} AS item_handle ON item.item_id = item_handle.item_id
    LEFT JOIN {{ref('raw_item_publication_date')}} AS item_publication_date ON item.item_id = item_publication_date.item_id
    LEFT JOIN {{ref('raw_item_created_date')}} AS item_created_date ON item.item_id = item_created_date.item_id
    LEFT JOIN {{ref('raw_item_exposure_date')}} AS item_exposure_date ON item.item_id = item_exposure_date.item_id
    LEFT JOIN {{ref('raw_item_available_date')}} AS item_available_date ON item.item_id = item_available_date.item_id
    LEFT JOIN {{ref('raw_item_language')}} AS item_language ON item.item_id = item_language.item_id
    LEFT JOIN {{ref('raw_item_license_uri')}} AS item_license_uri ON item.item_id = item_license_uri.item_id
    LEFT JOIN {{ref('raw_item_partof')}} AS item_partof ON item.item_id = item_partof.item_id
    LEFT JOIN {{ref('raw_item_volume')}} AS item_volume ON item.item_id = item_volume.item_id
)

SELECT * FROM final