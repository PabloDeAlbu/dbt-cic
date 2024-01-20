{{ config(materialized = "table") }}

WITH item AS (
    SELECT 
        item_id, 
        last_modified 
    FROM {{ source('repository_db', 'repository_db_item') }}
    WHERE withdrawn = false and in_archive = true and discoverable = true
),

final AS (
    SELECT 
        item.*, 
        {{ dbt_utils.star(from=ref('stg_items_title'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_type'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_subtype'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_handle'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_doi'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_available_date'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_created_date'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_exposure_date'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_language'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_license_uri'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_partof'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_publication_date'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_subtitle'), except=['item_id']) }},
        {{ dbt_utils.star(from=ref('stg_items_volume'), except=['item_id']) }}
    FROM item
    LEFT JOIN {{ref('stg_items_title')}} AS title ON item.item_id  = title.item_id
    LEFT JOIN {{ref('stg_items_subtitle')}} AS subtitle ON item.item_id = subtitle.item_id
    LEFT JOIN {{ref('stg_items_type')}} AS type ON item.item_id = type.item_id
    LEFT JOIN {{ref('stg_items_subtype')}} AS subtype ON item.item_id = subtype.item_id
    LEFT JOIN {{ref('stg_items_doi')}} AS doi ON item.item_id = doi.item_id
    LEFT JOIN {{ref('stg_items_handle')}} AS handle ON item.item_id = handle.item_id
    LEFT JOIN {{ref('stg_items_available_date')}} AS available_date ON item.item_id = available_date.item_id
    LEFT JOIN {{ref('stg_items_created_date')}} AS created_date ON item.item_id = created_date.item_id
    LEFT JOIN {{ref('stg_items_exposure_date')}} AS exposure_date ON item.item_id = exposure_date.item_id
    LEFT JOIN {{ref('stg_items_language')}} AS language ON item.item_id = language.item_id
    LEFT JOIN {{ref('stg_items_license_uri')}} AS license_uri ON item.item_id = license_uri.item_id
    LEFT JOIN {{ref('stg_items_partof')}} AS partof ON item.item_id = partof.item_id
    LEFT JOIN {{ref('stg_items_publication_date')}} AS publication_date ON item.item_id = publication_date.item_id
    LEFT JOIN {{ref('stg_items_volume')}} AS volume ON item.item_id = volume.item_id
)

SELECT * FROM final