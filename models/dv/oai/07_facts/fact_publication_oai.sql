{{ config(materialized='table') }}

with base as (
    SELECT 
        sal_publication_oai.handle,
        sal_publication_oai.doi,
        sat_item_oai.title,
        sat_item_oai.title_alternative,
        sat_item_oai.date_issued,
        sat_item_oai.date_exposure,
        sat_item_oai.description,
        sat_item_oai.version,
        sat_item_oai.access_right,
        sat_item_oai.access_level,
        sat_item_oai.license_condition,
        dim_resource_type_oai.coar_label_es
    FROM {{ref('sal_publication_oai')}}
    INNER JOIN {{ref('sat_item_oai')}} ON sat_item_oai.handle_hk = sal_publication_oai.handle_hk
    INNER JOIN {{ref('link_handle_type_oai')}} ON link_handle_type_oai.handle_hk = sal_publication_oai.handle_hk
    INNER JOIN {{ref('dim_resource_type_oai')}} ON dim_resource_type_oai.type_snrd_hk = link_handle_type_oai.type_snrd_hk
),

final as (
    SELECT
        *
    FROM base
)

select * from final