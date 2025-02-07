with base as (
    select 
        hub.handle_hk,
        hub.handle
    from {{ref('hub_dspace5_handle')}} hub
)

select * from base