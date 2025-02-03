with base as (
    SELECT 
        resourcetype_id,
        label,
        parent_label_1,
        parent_label_2,
        parent_label_3
    FROM {{ref('hub_resourcetype_coar')}} hub
    INNER JOIN {{ref('sat_resourcetype_coar')}} sat ON sat.resourcetype_hk = hub.resourcetype_hk
)

SELECT * FROM base