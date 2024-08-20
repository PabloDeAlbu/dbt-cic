with base as (
    SELECT
        hub_dinstitution_openalex.dinstitution_hk,
        hub_dinstitution_openalex.id,
        hub_ror_openalex.ror
    FROM {{ref('hub_dinstitution_openalex')}}
    LEFT JOIN {{ref('link_dinstitution_ror_openalex')}} ON hub_dinstitution_openalex.dinstitution_hk = link_dinstitution_ror_openalex.dinstitution_hk
    LEFT JOIN {{ref('hub_ror_openalex')}} ON hub_ror_openalex.ror_hk = link_dinstitution_ror_openalex.ror_hk
)

SELECT * FROM base