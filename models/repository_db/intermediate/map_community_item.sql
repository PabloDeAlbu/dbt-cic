with base as (
    SELECT map.orgunit_name, map.community_handle, c2i.item_id
    FROM {{ ref('map_community_ua') }} map
    INNER JOIN {{ source('repository_db','community2item') }} c2i ON c2i.community_id = map.community_id
),

final as (
    select * from base
)

select * from final
