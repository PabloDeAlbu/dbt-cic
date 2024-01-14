with base as (
    {{ select_metadatavalue('subtype', 'sedici', 'subtype')}}
),

final as (
    select * from base
)

select * from final