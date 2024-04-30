with base as (
    {{ select_metadatavalue('editor_name', 'sedici', 'contributor', 'editor', True)}}
),

final as (
    select * from base
)

select * from final
