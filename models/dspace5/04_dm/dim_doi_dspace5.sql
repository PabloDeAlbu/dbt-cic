with base as (
    select 
        hub.doi_hk,
        hub.doi
    from {{ref('hub_dspace5_doi')}} hub
)

select * from base