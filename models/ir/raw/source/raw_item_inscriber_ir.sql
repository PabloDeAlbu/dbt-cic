with base as (
    {{ select_metadatavalue('inscriber_name', 'sedici', 'contributor', 'inscriber', True)}}
),

final as (
    select * from base
)

select * from final
