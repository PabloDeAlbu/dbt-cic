with base as (
    {{ select_metadatavalue('director_name', 'sedici', 'contributor', 'director', True)}}
),

final as (
    select * from base
)

select * from final
