{{ config(materialized='table') }}

WITH base as (
    SELECT 
        link.researchproduct_hk,
        hub_attrank.attrank,
        hub_cc.cc,
        hub_downloads.downloads,
        hub_icc.icc,
        hub_pr.pr,
        hub_ram.ram,
        hub_views.views
    FROM {{ref('lnk_openaire_researchproduct2measure')}} link
    INNER JOIN {{ref('hub_openaire_attrank')}} hub_attrank ON hub_attrank.attrank_hk = link.attrank_hk
    INNER JOIN {{ref('hub_openaire_cc')}} hub_cc ON hub_cc.cc_hk = link.cc_hk
    INNER JOIN {{ref('hub_openaire_downloads')}} hub_downloads ON hub_downloads.downloads_hk = link.downloads_hk
    INNER JOIN {{ref('hub_openaire_icc')}} hub_icc ON hub_icc.icc_hk = link.icc_hk
    INNER JOIN {{ref('hub_openaire_pr')}} hub_pr ON hub_pr.pr_hk = link.pr_hk
    INNER JOIN {{ref('hub_openaire_ram')}} hub_ram ON hub_ram.ram_hk = link.ram_hk
    INNER JOIN {{ref('hub_openaire_views')}} hub_views ON hub_views.views_hk = link.views_hk

)

SELECT * FROM base
