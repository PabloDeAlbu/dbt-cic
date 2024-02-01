with base as (
    SELECT item_id, collection_id, text_value, authority
    FROM {{ source('repository_db', 'repository_db_collection2item') }} ci
    INNER JOIN {{ source('repository_db', 'repository_db_metadatavalue') }} mv ON mv.resource_type_id = 3 and ci.collection_id = mv.resource_id
    WHERE mv.metadata_field_id = 64

),

final as (
    select * from base
)

select * from final
