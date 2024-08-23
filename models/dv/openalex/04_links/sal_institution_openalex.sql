with base as (
    SELECT
        hub_institution_openalex.institution_hk,
        hub_institution_openalex.institution_id,
        hub_ror_openalex.institution_ror
    FROM {{ref('hub_institution_openalex')}}
    LEFT JOIN {{ref('link_institution_ror_openalex')}} ON hub_institution_openalex.institution_hk = link_institution_ror_openalex.institution_hk
    LEFT JOIN {{ref('hub_ror_openalex')}} ON hub_ror_openalex.ror_hk = link_institution_ror_openalex.ror_hk
)

SELECT * FROM base