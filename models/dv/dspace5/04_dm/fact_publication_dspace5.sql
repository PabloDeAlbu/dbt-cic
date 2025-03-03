with base as (
    select 
        hub.item_id,
        sat.title,
        sat.title_lang,
        dim_type.type,
        dim_type.label_es as coar_label_es,
        dim_type.coar_uri as coar_resourcetype_uri,
        dim_handle.handle,
        dim_doi.doi
    from {{ref('hub_dspace5_item')}} hub
    inner join {{ref('sat_dspace5_item')}} sat on sat.item_hk = hub.item_hk
    inner join {{ref('lnk_dspace5_item2type')}} item_type ON item_type.item_hk = hub.item_hk
    inner join {{ref('dim_type_dspace5')}} dim_type on dim_type.type_hk = item_type.type_hk

    inner join {{ref('lnk_dspace5_item2doi')}} item_doi ON item_doi.item_hk = hub.item_hk
    inner join {{ref('dim_doi_dspace5')}} dim_doi on dim_doi.doi_hk = item_doi.doi_hk

    inner join {{ref('lnk_dspace5_item2handle')}} item_handle ON item_handle.item_hk = hub.item_hk
    inner join {{ref('dim_handle_dspace5')}} dim_handle on dim_handle.handle_hk = item_handle.handle_hk

)

select * from base