{{ config(materialized = "table") }}

WITH item AS (
    SELECT 
        item_id, 
        last_modified,
        item._airbyte_extracted_at
    FROM {{ source('ir', 'item') }}
    WHERE withdrawn = false and in_archive = true and discoverable = true
),

final AS (
    SELECT 
        item.item_id as internal_identifier,
        type.type as type,
        subtype.subtype as subtype,
        language.language as language,
        title.title as title,
        subtitle.subtitle as subtitle,
        handle.handle as handle,
        doi.doi as doi,
        available_date.available_date as available_date,
        created_date.created_date as created_date,
        exposure_date.exposure_date as exposure_date,
        publication_date.publication_date as publication_date,
        license_uri.license_uri as license_uri,
        partof.partof as partof,
        volume.volume as volume,
        item.last_modified,
        item._airbyte_extracted_at
    FROM item
    LEFT JOIN {{ref('raw_item_title')}} AS title ON item.item_id  = title.item_id
    LEFT JOIN {{ref('raw_item_subtitle')}} AS subtitle ON item.item_id = subtitle.item_id
    LEFT JOIN {{ref('raw_item_type')}} AS type ON item.item_id = type.item_id
    LEFT JOIN {{ref('raw_item_subtype')}} AS subtype ON item.item_id = subtype.item_id
    LEFT JOIN {{ref('raw_item_doi')}} AS doi ON item.item_id = doi.item_id
    LEFT JOIN {{ref('raw_item_handle')}} AS handle ON item.item_id = handle.item_id
    LEFT JOIN {{ref('raw_item_publication_date')}} AS publication_date ON item.item_id = publication_date.item_id
    LEFT JOIN {{ref('raw_item_created_date')}} AS created_date ON item.item_id = created_date.item_id
    LEFT JOIN {{ref('raw_item_exposure_date')}} AS exposure_date ON item.item_id = exposure_date.item_id
    LEFT JOIN {{ref('raw_item_available_date')}} AS available_date ON item.item_id = available_date.item_id
    LEFT JOIN {{ref('raw_item_language')}} AS language ON item.item_id = language.item_id
    LEFT JOIN {{ref('raw_item_license_uri')}} AS license_uri ON item.item_id = license_uri.item_id
    LEFT JOIN {{ref('raw_item_partof')}} AS partof ON item.item_id = partof.item_id
    LEFT JOIN {{ref('raw_item_volume')}} AS volume ON item.item_id = volume.item_id
)

SELECT * FROM final