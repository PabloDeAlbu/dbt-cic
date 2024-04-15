with base as (
    SELECT c2i.item_id, map.orgunit_name, map.community_handle
    FROM {{ ref('community_unidadacademica') }} map
    INNER JOIN {{ source('repository_db','community2item') }} c2i ON c2i.community_id = map.community_id
),

final as (
    select * from base
)

select * from final
