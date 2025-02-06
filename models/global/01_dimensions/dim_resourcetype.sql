with base as (
    SELECT 
        coar.resourcetype_id,
        coar.label_es as coar_label_es,
        coar.label,
        coar.parent_label_1,
        coar.parent_label_2,
        coar.parent_label_3,
        openalex.openalex_type,
        openaire.openaire_type
    FROM {{ref('dim_resourcetype_coar')}} coar
    FULL OUTER JOIN {{ref('dim_resourcetype_openalex')}} openalex ON openalex.coar_uri = coar.resourcetype_id
    FULL OUTER JOIN {{ref('dim_resourcetype_openaire')}} openaire ON openaire.coar_uri = coar.resourcetype_id
)

SELECT * FROM base