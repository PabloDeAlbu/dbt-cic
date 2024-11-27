{{ config(materialized='table') }}

with base as (
    SELECT 
        rp2pid.id,
        COALESCE(doi.pid_text, 'NOT_SET') as doi,
        COALESCE(pmid.pid_text, 'NOT_SET') as pmid,
        COALESCE(pmc.pid_text, 'NOT_SET') as pmc,
        COALESCE(arxiv.pid_text, 'NOT_SET') as arxiv,
        COALESCE(handle.pid_text, 'NOT_SET') as handle,
        COALESCE(mag.pid_text, 'NOT_SET') as mag,
        rp2pid.load_datetime
    FROM {{ref('base_openaire_researchproduct2pid')}} rp2pid
    LEFT JOIN {{ref('norm_openaire_researchproduct2doi')}} doi ON doi.id = rp2pid.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2pmid')}} pmid ON pmid.id = rp2pid.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2pmc')}} pmc ON pmc.id = rp2pid.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2arxiv')}} arxiv ON arxiv.id = rp2pid.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2handle')}} handle ON handle.id = rp2pid.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2mag')}} mag ON mag.id = rp2pid.id
),

final as (
    select * from base
)

select * from final
