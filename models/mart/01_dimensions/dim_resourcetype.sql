WITH base AS (
    SELECT 
        sal_resourcetype_coar.resourcetype_hk,
        sat_resourcetype_coar.label_es as label,
        hub_worktype_openalex.worktype_display_name as worktype_openalex,
        sat_resourcetype_coar.label as coar_label,
        sat_resourcetype_coar.parent_label_1,
        sat_resourcetype_coar.parent_label_2,
        sat_resourcetype_coar.parent_label_3
    FROM {{ref('sal_resourcetype_coar')}}
    INNER JOIN {{ref('sat_resourcetype_coar')}} ON sat_resourcetype_coar.resourcetype_hk = sal_resourcetype_coar.resourcetype_hk
    INNER JOIN {{ref('hub_worktype_openalex')}} ON hub_worktype_openalex.worktype_hk = sal_resourcetype_coar.worktype_hk
),
final AS (
    SELECT 
        *
    FROM base
)

SELECT * FROM final