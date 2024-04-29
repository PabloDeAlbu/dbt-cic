WITH base AS (
    SELECT 
        id,
        child_comm_id,
        parent_comm_id,
        _airbyte_extracted_at as load_datetime
    FROM {{ source('ir', 'community2community') }}
)


SELECT * FROM base