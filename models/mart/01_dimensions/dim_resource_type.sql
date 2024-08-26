WITH hub_work_type_openalex AS (
    SELECT * FROM {{ref('hub_work_type_openalex')}}
),

base AS (
    SELECT map_openalex2coar.label_es, map_openalex2coar.type
    FROM {{ref('map_openalex-types2coar-types')}} map_openalex2coar
    INNER JOIN hub_work_type_openalex ON hub_work_type_openalex.type = map_openalex2coar.type
    )

SELECT * FROM base

