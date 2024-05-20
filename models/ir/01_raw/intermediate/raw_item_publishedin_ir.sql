with base as (
    {{ select_metadatavalue('publishedin', 'mods', 'originInfo', 'place', True)}}
),

final as (
    select * from base
)

select * from final
