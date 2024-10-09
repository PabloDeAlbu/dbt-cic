WITH base AS (
    SELECT 
        sal.sal_item_hk as publication_hk,
        sat.handle,
        sat.doi,
        sat.title,
        sat.type
    FROM {{ ref('sal_item_dspacedb') }} sal
    INNER JOIN {{ ref('sat_item_dspacedb') }} sat ON sal.item_hk = sat.item_hk
)

SELECT * FROM base