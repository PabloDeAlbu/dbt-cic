with base as (
    SELECT map.orgunit_name, p.handle as publication_handle, map.community_handle, 'source' as role
    FROM {{ ref('map_community_item') }} map
    INNER JOIN {{ ref('fact_publication') }} p ON map.item_id = p.item_id
),

final as (
    select * from base
)

select * from final
