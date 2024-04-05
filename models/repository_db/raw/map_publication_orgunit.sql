{# with base as (
/*    SELECT item_id, g.orgunit_name, g.authority, 'grantor' as role, NULL as handle 
    FROM {{ ref('item_grantor') }} g
    
    UNION 
    
    SELECT item_id, o.orgunit_name, o.authority, 'origin' as role, NULL as handle 
    FROM {{ ref('item_origin') }} o
    
    UNION */

    SELECT item_id, map.orgunit_name, NULL as authority, 'source' as role, map.community_handle as handle
    FROM {{ ref('item_unidadacademica') }} map
),

final as (
    SELECT 
        base.item_id,
        p.handle as publication_handle,
        base.orgunit_name,
        base.handle as orgunit_handle,
        base.authority as orgunit_internal_identifier,
        base.role,
        p.available_date,
        p.publication_date
    FROM base
    inner join {{ref('publication')}} p on p.item_id = base.item_id
    WHERE p.handle is not null and (base.handle is not null or base.authority is not null)
    order by orgunit_name

)

select * from final #}