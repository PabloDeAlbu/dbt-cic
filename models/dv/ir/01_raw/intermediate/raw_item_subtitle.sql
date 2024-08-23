with base as (
    {{ select_metadatavalue('subtitle', 'sedici', 'title', 'subtitle')}}
),

final as (
    select * from base
)

select * from final