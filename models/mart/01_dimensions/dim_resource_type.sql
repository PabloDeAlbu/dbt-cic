WITH base AS (
    SELECT
        
        hub_resource_type_coar.coar_uri_hk,
        sat_resource_type_coar.label,
        sat_resource_type_coar.parent_label_1,
        sat_resource_type_coar.parent_label_2,
        sat_resource_type_coar.parent_label_3,
        sat_resource_type_coar.label_es,
        hub_work_type_openalex.key_display_name as openalex_label
    FROM {{ref('hub_resource_type_coar')}}
    INNER JOIN {{ref('sat_resource_type_coar')}} ON hub_resource_type_coar.coar_uri_hk = sat_resource_type_coar.coar_uri_hk
    FULL OUTER JOIN {{ref('work_type_openalex2resource_type_coar')}} openalex2coar ON hub_resource_type_coar.coar_uri = openalex2coar.coar_uri
    -- TODO hacer join por hashkey
    FULL OUTER JOIN {{ref('hub_work_type_openalex')}} ON hub_work_type_openalex.key_display_name = openalex2coar.type
),

final AS (
    SELECT 
        *
    FROM base
    WHERE openalex_label is not null
)

SELECT * FROM final