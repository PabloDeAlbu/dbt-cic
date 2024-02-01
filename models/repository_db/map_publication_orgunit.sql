with items_orgunit as (
    SELECT *, 'grantor' as role FROM {{ ref('item_grantor') }}
    UNION 
    SELECT *, 'origin' as role FROM {{ ref('item_origin') }}
),

final as (
    SELECT 
        o.*
    FROM items_orgunit o
    INNER JOIN {{ ref('publication') }} p ON p.item_id = o.item_id
)

select * from final