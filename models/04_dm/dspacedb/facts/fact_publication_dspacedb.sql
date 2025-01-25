{{ config(materialized='table') }}

WITH base AS (
    SELECT 
        dim_handle.handle,
        dim_doi.doi,
        dim_type.type,
        sat.title,
        sat.title_lang,
        sat.dateissued
    FROM {{ ref('sal_item_dspacedb') }} sal
    INNER JOIN {{ ref('dim_handle_dspacedb') }} dim_handle ON dim_handle.handle_hk = sal.handle_hk
    INNER JOIN {{ ref('dim_doi_dspacedb') }} dim_doi ON dim_doi.doi_hk = sal.doi_hk
    INNER JOIN {{ ref('link_item_type_dspacedb') }} item_type ON item_type.item_hk = sal.item_hk
    INNER JOIN {{ ref('dim_type_dspacedb') }} dim_type ON dim_type.type_hk = item_type.type_hk
    INNER JOIN {{ ref('sat_item_dspacedb') }} sat ON sat.item_hk = sal.item_hk
)

SELECT * FROM base