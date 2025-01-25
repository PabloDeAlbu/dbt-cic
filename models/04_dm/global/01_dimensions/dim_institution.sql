WITH base AS (
    SELECT * 
    FROM {{ref('hub_institution_openalex')}}
    INNER JOIN {{ref('sat_institution_openalex')}} ON hub_institution_openalex.institution_hk = sat_institution_openalex.institution_hk
)

SELECT * FROM base