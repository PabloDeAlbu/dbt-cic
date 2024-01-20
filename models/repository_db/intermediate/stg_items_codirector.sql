with base as (
    {{ select_metadatavalue('codirector_name', 'sedici', 'contributor', 'codirector', True)}}
),

final as (
    select * from base
)

select * from final
