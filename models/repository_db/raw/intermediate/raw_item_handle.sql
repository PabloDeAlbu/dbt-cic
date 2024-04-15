with base as (
    SELECT item_id, h.handle
    FROM {{ source('repository_db', 'item') }} i
    INNER JOIN {{ source('repository_db', 'handle') }} h ON i.item_id = h.resource_id
    WHERE h.resource_type_id = 2
),

final as (
    select * from base
)

select * from final
