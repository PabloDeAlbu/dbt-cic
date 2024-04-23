{{ config(materialized='table') }}

with base as (
    select d.doi, h.handle, i.internal_identifier, d.doi_hk, h.handle_hk, i.publication_hk
    from {{ ref('stg_publication_ir')}} stg
    left join {{ ref('hub_publication_doi_ir')}} d on stg.doi_hk =  d.doi_hk
    left join {{ ref('hub_publication_handle_ir')}} h on stg.handle_hk =  h.handle_hk
    left join {{ ref('hub_publication_id_ir')}} i on stg.publication_hk = i.publication_hk
),

final as (
    select * from base
)

select * from final