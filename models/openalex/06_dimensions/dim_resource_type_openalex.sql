WITH base AS (
    SELECT
        hub_type_openalex.type_hk,
        hub_type_openalex.type as openalex_type,
        map.label_es as coar_label_es,
        map.coar_uri
    FROM {{ ref('hub_type_openalex') }} 
    LEFT JOIN {{ ref('map_openalex-types2coar-types') }} map ON hub_type_openalex.type = map.type
)

SELECT * FROM base