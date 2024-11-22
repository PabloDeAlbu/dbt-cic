{{ config(materialized='table') }}

with base as (
    SELECT 
        r.id, 
        COALESCE(r2d.pid_text, 'NOT_SET') as doi, 
        COALESCE(r2pmid.pid_text, 'NOT_SET') as pmid, 
        COALESCE(r2pmc.pid_text, 'NOT_SET') as pmc, 
        COALESCE(r2arxiv.pid_text, 'NOT_SET') as arxiv, 
        COALESCE(r2handle.pid_text, 'NOT_SET') as handle, 
        COALESCE(r2mag_id.pid_text, 'NOT_SET') as mag,
        r.load_datetime
    FROM {{ref('norm_openaire_researchproduct')}} r
    LEFT JOIN {{ref('norm_openaire_researchproduct2doi')}} r2d ON r2d.id = r.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2pmid')}} r2pmid ON r2pmid.id = r.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2pmc')}} r2pmc ON r2pmc.id = r.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2arxiv')}} r2arxiv ON r2arxiv.id = r.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2handle')}} r2handle ON r2handle.id = r.id
    LEFT JOIN {{ref('norm_openaire_researchproduct2mag_id')}} r2mag_id ON r2mag_id.id = r.id
),

final as (
    select * from base
)

select * from final
