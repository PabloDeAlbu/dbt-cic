{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        item_id, 
        last_modified,
        submitter_id,
        owning_collection
    FROM {{ source('repository_db', 'item') }}
    WHERE withdrawn = false and in_archive = true and discoverable = true
)


SELECT * FROM base