with base as (
    select 
        hub.type_hk,
        hub.type,
        seed.label_es,
        seed.coar_uri
    from {{ref('hub_dspace5_type')}} hub
    inner join {{ref('seed_sedici-types2coar-types')}} seed on seed.type = hub.type
)

select * from base