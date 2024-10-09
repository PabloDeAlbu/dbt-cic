{# WITH base AS (
    SELECT * 
    FROM {{ref('hub_source_openalex')}}
    INNER JOIN {{ref('sat_source_openalex')}} ON hub_source_openalex.source_hk = sat_source_openalex.source_hk
)

SELECT * FROM base #}