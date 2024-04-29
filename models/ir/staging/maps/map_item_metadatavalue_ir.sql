with metadatavalue as (
    select * 
    from {{ ref('stg_metadatavalue_ir')}}
),

final as (
    select metadatavalue_resource_hk as metadatavalue_item_hk, metadatavalue_hk, resource_hk as item_hk, load_datetime, source
    from  metadatavalue 
    where metadatavalue.resource_type_id = 2
)

select * from final