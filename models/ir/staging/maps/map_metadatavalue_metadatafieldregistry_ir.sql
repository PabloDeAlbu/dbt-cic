with metadatavalue as (
    select * 
    from {{ ref('stg_metadatavalue_ir')}}
),

final as (
    select *
    from  metadatavalue 
    where metadatavalue.resource_type_id = 2
)

select * from final