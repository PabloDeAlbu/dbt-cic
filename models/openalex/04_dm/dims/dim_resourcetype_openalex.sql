{{ config(materialized='table') }}

WITH base as (
    SELECT
        hub.type_hk,
        hub.type as openalex_type,
        map.coar_label_es,
        map.coar_uri as coar_resourcetype_uri
    FROM {{ref('hub_openalex_worktype')}} hub
    INNER JOIN {{ref('map_openalex_worktype2coar_types')}} map ON map.openalex_type = hub.type
)

SELECT * FROM base
