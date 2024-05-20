WITH base AS (
    SELECT
    subtype_hk,
    UPPER(subtype) as subtype
    FROM {{ref('hub_subtype_ir')}}
),

map2coar AS (
    SELECT
    type,
    subtype,
    label_es,
    coar_uri
    FROM {{ref('map_sedici-types2coar-types')}}
    ORDER BY subtype
),

final AS (
    SELECT 
    subtype_hk,
    map2coar.type as sedici_type,
    base.subtype as sedici_subtype,
    map2coar.label_es as coar_label_es,
    map2coar.coar_uri as coar_uri
    FROM base
    INNER JOIN map2coar ON base.subtype = map2coar.subtype
)

SELECT * FROM final