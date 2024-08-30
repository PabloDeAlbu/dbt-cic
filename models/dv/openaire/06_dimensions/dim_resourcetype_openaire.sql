
WITH base AS (
    SELECT
        hub_resourcetype.resourcetype_hk,
        hub_resourcetype.resourcetype as openaire_resourcetype,
        map.label as coar_label,
        map.label_es as coar_label_es,
        map.coar
    FROM {{ref('hub_resourcetype_openaire')}} hub_resourcetype
    LEFT JOIN {{ ref('map-resourcetype_openalex-resourcetype_coar') }} map ON hub_resourcetype.resourcetype = map.resourcetype
)

SELECT * FROM base
