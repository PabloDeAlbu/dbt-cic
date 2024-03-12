with item_orgunit as (
    SELECT g.orgunit_name, g.authority, 'grantor' as role, 'NOT_SET' as handle 
    FROM {{ ref('item_grantor') }} g
    
    UNION 
    
    SELECT o.orgunit_name, o.authority, 'origin' as role, 'NOT_SET' as handle 
    FROM {{ ref('item_origin') }} o
    
    UNION

    SELECT map.orgunit_name, 'NOT_SET' as authority, 'source' as role, map.community_handle as handle
    FROM {{ ref('item_unidadacademica') }} map

),

final as (
    SELECT 
        o.*
    FROM item_orgunit o
    INNER JOIN {{ ref('publication') }} p ON p.handle = o.handle
)

select * from final