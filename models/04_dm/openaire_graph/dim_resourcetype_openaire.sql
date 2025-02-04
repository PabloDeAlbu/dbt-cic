{{ config(materialized='table') }}

WITH base as (
    SELECT
        hub.type_hk,
        hub.type as openaire_type,
        map.coar_label_es,
        map.coar_uri
    FROM {{ref('hub_openaire_graph_researchproduct_type')}} hub
    INNER JOIN {{ref('map_openaire_resourcetype2coar_resourcetype')}} map ON map.openaire_type = hub.type
    ORDER BY 2
)

SELECT * FROM base
