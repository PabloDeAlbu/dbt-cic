with base as (
    {{ select_metadatavalue('subject', 'sedici', 'subject', 'materias', True)}}
),

final as (
    select * from base
)

select * from final
