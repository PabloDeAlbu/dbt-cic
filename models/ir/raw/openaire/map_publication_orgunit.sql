{{ config(materialized='table') }}

with base as (
    SELECT item_id, g.orgunit_name, g.authority, 'grantor' as role, NULL as handle 
    FROM {{ ref('raw_item_grantor_ir') }} g
    
    UNION 
    
    SELECT item_id, o.orgunit_name, o.authority, 'origin' as role, NULL as handle 
    FROM {{ ref('raw_item_origin_ir') }} o
    
    {# 
    -- UNION 
    -- SELECT item_id, map.orgunit_name, NULL as authority, 'source' as role, map.community_handle as handle
    -- FROM {{ ref('item_unidadacademica') }} map  
    #}
),

final as (
    SELECT 
        base.item_id as internal_identifier,
        base.orgunit_name,
        base.handle,
        base.authority,
        base.role,
        p.available_date,
        p.publication_date
    FROM base
    inner join {{ref('stg_publication_ir')}} p on p.internal_identifier = base.item_id
    WHERE p.handle is not null and (base.handle is not null or base.authority is not null)
    order by orgunit_name

)

select * from final