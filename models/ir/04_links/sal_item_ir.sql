WITH base AS (
    SELECT 
    hub_item_ir.item_hk,
    hub_item_ir.item_id,
    hub_doi_ir.doi,
    hub_handle_ir.handle
    FROM {{ref('hub_item_ir')}} hub_item_ir
    LEFT JOIN {{ref('link_item_doi_ir')}} link_item_doi_ir ON link_item_doi_ir.item_hk = hub_item_ir.item_hk
    LEFT JOIN {{ref('hub_doi_ir')}} ON hub_doi_ir.doi_hk = link_item_doi_ir.doi_hk
    LEFT JOIN {{ref('link_item_handle_ir')}} link_item_handle_ir ON link_item_handle_ir.item_hk = hub_item_ir.item_hk
    LEFT JOIN {{ref('hub_handle_ir')}} ON hub_handle_ir.handle_hk = link_item_handle_ir.handle_hk
)

SELECT * FROM base