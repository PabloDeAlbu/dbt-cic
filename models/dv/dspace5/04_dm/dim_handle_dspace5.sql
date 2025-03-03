with base as (
    select 
        hub.handle_hk,
        hub.handle as full_handle,
        split_part(hub.handle, 'handle/', 2) as handle
    from {{ref('hub_dspace5_handle')}} hub
)

select * from base