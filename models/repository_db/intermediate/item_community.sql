with base as (
    SELECT item_id, community_id, text_value, authority
    FROM {{ source('repository_db', 'community2item') }} ci
    INNER JOIN {{ source('repository_db', 'metadatavalue') }} mv ON mv.resource_type_id = 4 and ci.community_id = mv.resource_id
    WHERE mv.metadata_field_id = 64

),

final as (
    select * from base
)

select * from final
