with base as (
    {{ select_metadatavalue('doi', 'sedici', 'identifier', 'other', True)}}
),

final as (
    select * from base
    where doi similar to 'https?://\S+' and doi like '%doi%'
)

select * from final
