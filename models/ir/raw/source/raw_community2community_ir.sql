WITH base AS (
    SELECT 
        id,
        child_comm_id,
        parent_comm_id
    FROM {{ source('ir', 'community2community') }}
)

SELECT * FROM base