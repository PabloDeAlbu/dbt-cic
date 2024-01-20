with base as (
    {{ select_metadatavalue('subject', 'sedici', 'subject', 'materia')}}
),

final as (
    select * from base
)

select * from final
