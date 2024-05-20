with base as (
    SELECT item_id, h.handle
    FROM {{ source('ir', 'item') }} i
    INNER JOIN {{ source('ir', 'handle') }} h ON i.item_id = h.resource_id
    WHERE h.resource_type_id = 2
),

final as (
    select * from base
)

select * from final
