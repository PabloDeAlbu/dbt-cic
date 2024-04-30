with base as (
    {{ select_metadatavalue('compiler_name', 'sedici', 'contributor', 'compiler', True)}}
),

final as (
    select * from base
)

select * from final
