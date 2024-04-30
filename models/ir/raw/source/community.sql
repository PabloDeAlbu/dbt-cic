with base as (
    SELECT c.community_id, h.handle as community_handle
    FROM {{ source('ir', 'community') }} c
    INNER JOIN {{ source('ir', 'handle') }} h ON h.resource_type_id = 4 and h.resource_id = c.community_id
),

final as (
    select * from base
)

select * from final
