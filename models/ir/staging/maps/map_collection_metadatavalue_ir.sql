with metadatavalue as (
    select * 
    from {{ ref('stg_metadatavalue_ir')}}
),

final as (
    select metadatavalue_resource_hk as metadatavalue_collection_hk, metadatavalue_hk, resource_hk as collection_hk, load_datetime, source
    from  metadatavalue 
    where metadatavalue.resource_type_id = 3
)

select * from final