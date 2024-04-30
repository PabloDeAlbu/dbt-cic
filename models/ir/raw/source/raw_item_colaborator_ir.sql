with base as (
    {{ select_metadatavalue('colaborator_name', 'sedici', 'contributor', 'colaborator', True)}}
),

final as (
    select * from base
)

select * from final
