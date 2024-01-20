with items_orgunit as (
    SELECT *, 'grantor' as role FROM {{ ref('stg_items_grantor') }}
    UNION 
    SELECT *, 'origin' as role FROM {{ ref('stg_items_origin') }}
),

final as (
    SELECT 
        o.*
    FROM items_orgunit o
    INNER JOIN {{ ref('stg_publication') }} p ON p.item_id = o.item_id
)

select * from final