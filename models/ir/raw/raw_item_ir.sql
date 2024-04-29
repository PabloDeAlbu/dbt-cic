WITH base AS (
    SELECT 
        item_id,
        submitter_id,
        last_modified,
        owning_collection,
        _airbyte_extracted_at as load_datetime        
    FROM {{ source('ir', 'item') }}
    WHERE withdrawn = false and in_archive = true and discoverable = true
)


SELECT * FROM base