with base as (
    {{ select_metadatavalue('origin_name', 'mods', 'originInfo', 'place', True)}}
),

final as (
    select * from base
)

select * from final
