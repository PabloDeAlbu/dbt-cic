with base as (
    SELECT community_id, text_value, authority
    FROM {{ source('repository_db', 'repository_db_community2community') }} c
    INNER JOIN {{ source('repository_db', 'repository_db_metadatavalue') }} mv ON mv.resource_type_id = 4 and c.community_id = mv.resource_id
    
    WHERE mv.metadata_field_id = 64

),

final as (
    select * from base
)

select * from final
