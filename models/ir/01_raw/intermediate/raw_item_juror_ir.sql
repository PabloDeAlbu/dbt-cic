with base as (
    {{ select_metadatavalue('juror_name', 'sedici', 'contributor', 'juror', True)}}
),

final as (
    select * from base
)

select * from final
