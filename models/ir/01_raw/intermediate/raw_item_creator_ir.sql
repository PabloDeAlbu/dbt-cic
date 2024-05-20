with base as (
    {{ select_metadatavalue('creator_name','sedici', 'creator', 'person', True)}}
),

final as (
    select * from base
)

select * from final
