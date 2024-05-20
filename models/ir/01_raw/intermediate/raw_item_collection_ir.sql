with base as (
    SELECT item_id, collection_id, text_value, authority
    FROM {{ source('ir', 'collection2item') }} ci
    INNER JOIN {{ source('ir', 'metadatavalue') }} mv ON mv.resource_type_id = 3 and ci.collection_id = mv.resource_id
    WHERE mv.metadata_field_id = 64

),

final as (
    select * from base
)

select * from final
