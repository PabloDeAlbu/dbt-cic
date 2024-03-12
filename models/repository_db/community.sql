with base as (
    SELECT c.community_id, h.handle as community_handle
    FROM {{ source('repository_db', 'community') }} c
    INNER JOIN {{ source('repository_db', 'handle') }} h ON h.resource_type_id = 4 and h.resource_id = c.community_id
),

final as (
    select * from base
)

select * from final
