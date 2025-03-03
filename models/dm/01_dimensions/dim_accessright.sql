with base as (
    SELECT 
        openalex.oa_status,
        openaire.best_access_right,
        openalex.is_oa
    FROM {{ref('dim_accessright_openalex')}} openalex
    INNER JOIN {{ref('dim_accessright_openaire')}} openaire ON openaire.is_oa = openalex.is_oa
)

SELECT * FROM base