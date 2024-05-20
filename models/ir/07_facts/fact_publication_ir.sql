with base as (
    SELECT 
        sal_item_ir.item_id,
        sal_item_ir.doi,
        sal_item_ir.handle,
        sat_item_ir.title,
        sat_item_ir.subtitle,
        sat_item_ir.available_date,
        sat_item_ir.created_date,
        sat_item_ir.exposure_date,
        sat_item_ir.publication_date,
        sat_item_ir.partof,
        sat_item_ir.volume,
        sat_item_ir.last_modified
    FROM {{ref('sal_item_ir')}} sal_item_ir
    INNER JOIN {{ref('sat_item_ir')}} sat_item_ir ON sat_item_ir.item_hk = sal_item_ir.item_hk
),

final as (
    SELECT
        *
    FROM base
)

select * from final