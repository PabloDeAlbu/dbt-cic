{{ config(materialized='table') }}

with base as (
    SELECT 
        sal_item_ir_oai.handle,
        sal_item_ir_oai.doi,
        sat_item_ir_oai.title,
        sat_item_ir_oai.title_alternative,
        sat_item_ir_oai.date_issued,
        sat_item_ir_oai.date_exposure,
        sat_item_ir_oai.description,
        sat_item_ir_oai.version,
        sat_item_ir_oai.access_right,
        sat_item_ir_oai.access_level,
        sat_item_ir_oai.license_condition,
        dim_resource_type_ir_oai.coar_label_es
    FROM {{ref('sal_item_ir_oai')}}
    INNER JOIN {{ref('sat_item_ir_oai')}} ON sat_item_ir_oai.handle_hk = sal_item_ir_oai.handle_hk
    INNER JOIN {{ref('link_handle_type_ir_oai')}} ON link_handle_type_ir_oai.handle_hk = sal_item_ir_oai.handle_hk
    INNER JOIN {{ref('dim_resource_type_ir_oai')}} ON dim_resource_type_ir_oai.type_snrd_hk = link_handle_type_ir_oai.type_snrd_hk
),

final as (
    SELECT
        *
    FROM base
)

select * from final